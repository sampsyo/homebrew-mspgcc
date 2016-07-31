class Msp430Gcc < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://ftpmirror.gnu.org/gcc/gcc-4.7.0/gcc-4.7.0.tar.bz2"
  sha256 "a680083e016f656dab7acd45b9729912e70e71bbffcbf0e3e8aa1cccf19dc9a5"
  env :std

  depends_on "msp430-binutils"
  depends_on "mpfr"
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/gcc-4.7.0/msp430-gcc-4.7.0-20120911.patch"
    sha256 "db0b6e502c89be4cfee518e772125eaea66cc289d9428c57ddcc187a3be9e77a"
  end

  def install
    # The bootstrap process uses "xgcc", which doesn't have these flags. This
    # results in an error like the following:
    # configure: error: cannot compute suffix of object files: cannot compile
    # which, upon further inspection, arises when xgcc bails out when it sees
    # this argument.
    ENV.remove_from_cflags "-Qunused-arguments"
    ENV.remove_from_cflags(/ ?-march=\S*/)
    ENV.remove_from_cflags(/ ?-msse[\d\.]*/)
    ENV.remove_from_cflags(/ ?-mmacosx-version-min=10\.\d+/)

    # gcc must be built outside of the source directory.
    mkdir "build" do
      binutils = Formula["msp430-binutils"]
      system "../configure", "--target=msp430", "--enable-languages=c,c++", "--program-prefix='msp430-'", "--prefix=#{prefix}", "--with-as=#{binutils.opt_prefix}/msp430/bin/as", "--with-ld=#{binutils.opt_prefix}/msp430/bin/ld"
      system "make"
      system "make", "install"

      # Remove libiberty, which conflicts with the same library provided by
      # binutils.
      # http://msp430-gcc-users.1086195.n5.nabble.com/overwriting-libiberty-td4215.html
      # Fix inspired by:
      # https://github.com/larsimmisch/homebrew-avr/commit/8cc2a2e591b3a4bef09bd6efe2d7de95dfd92794
      multios = `gcc --print-multi-os-directory`.chomp
      libiberty = "#{lib}/#{multios}/libiberty.a"
      if File.exist?(libiberty)
        File.unlink libiberty
      end
    end
  end
end
