require 'formula'

class Mspgcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url ' http://downloads.sourceforge.net/project/mspgcc/mspgcc/DEVEL-4.7.x/mspgcc-20120911.tar.bz2'
  sha1 '04f5860857dbb166d997737312494018b125f4bd'
end

class Msp430Gcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://www.netgull.com/gcc/releases/gcc-4.7.0/gcc-4.7.0.tar.bz2'
  sha1 '03b8241477a9f8a34f6efe7273d92b9b6dd9fe82'
  env :std

  depends_on 'msp430-binutils'
  depends_on 'mpfr'
  depends_on 'gmp'
  depends_on 'isl'
  depends_on 'libmpc'

  patch do
    url "http://sourceforge.net/projects/mspgcc/files/Patches/gcc-4.7.0/msp430-gcc-4.7.0-20120911.patch/download"
    sha1 "3e70230f6052ed30d1a288724f2b97ab47581489"
  end

  def install
    # The bootstrap process uses "xgcc", which doesn't have these flags. This
    # results in an error like the following:
    # configure: error: cannot compute suffix of object files: cannot compile
    # which, upon further inspection, arises when xgcc bails out when it sees
    # this argument.
    ENV.remove_from_cflags '-Qunused-arguments'
    ENV.remove_from_cflags(/ ?-march=\S*/)
    ENV.remove_from_cflags(/ ?-msse4(\.\d)?/)
    ENV.remove_from_cflags(/ ?-mmacosx-version-min=10\.\d+/)

    # gcc must be built outside of the source directory.
    mkdir 'build' do
      binutils = Formula.factory('msp430-binutils')
      cc = ENV['CC']
      system "../configure", "--target=msp430", "--enable-languages=c,c++", "--program-prefix='msp430-'", "--prefix=#{prefix}", "--with-as=#{binutils.opt_prefix}/msp430/bin/as", "--with-ld=#{binutils.opt_prefix}/msp430/bin/ld"
      system "make"
      system "make install"

      # Remove libiberty, which conflicts with the same library provided by
      # binutils.
      # http://msp430-gcc-users.1086195.n5.nabble.com/overwriting-libiberty-td4215.html
      # Fix inspired by:
      # https://github.com/larsimmisch/homebrew-avr/commit/8cc2a2e591b3a4bef09bd6efe2d7de95dfd92794
      if File.exists?("#{prefix}/lib/x86_64/libiberty.a")
        File.unlink "#{prefix}/lib/x86_64/libiberty.a"
      else
        File.unlink "#{prefix}/lib/libiberty.a"
      end
    end
  end
end
