require 'formula'

class Mspgcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/mspgcc/mspgcc-20120406.tar.bz2'
  sha1 'cc96a7233f0b1d2c106eff7db6fc00e4ed9039a8'
end

class Mspgcc_lts1 < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/Patches/LTS/20120406/msp430-gcc-4.6.3-20120406-sf3540953.patch',
    :using => :nounzip
  sha1 '9de4e74d8ceb2005409e03bf671e619f2e060082'
end

class Mspgcc_lts2 < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/Patches/LTS/20120406/msp430-gcc-4.6.3-20120406-sf3559978.patch',
    :using => :nounzip
end

class Msp430Gcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.6.3/gcc-core-4.6.3.tar.bz2'
  sha1 'eaefb90df5a833c94560a8dda177bd1e165c2a88'
  env :std

  depends_on 'msp430-binutils'
  depends_on 'mpfr'
  depends_on 'gmp'
  depends_on 'isl'
  depends_on 'libmpc'

  def patches
    # Main patch.
    Mspgcc.new.brew do
      buildpath.install "msp430-gcc-4.6.3-20120406.patch"
    end

    # Long-term support (LTS) patches.
    Mspgcc_lts1.new.brew do
      buildpath.install "msp430-gcc-4.6.3-20120406-sf3540953.patch"
    end
    Mspgcc_lts2.new.brew do
      buildpath.install "msp430-gcc-4.6.3-20120406-sf3559978.patch"
    end

    [
      "http://sourceforge.net/projects/mspgcc/files/Patches/gcc-4.6.3/msp430-gcc-4.6.3-20120406.patch",
      "http://sourceforge.net/projects/mspgcc/files/Patches/LTS/20120406/msp430-gcc-4.6.3-20120406-sf3540953.patch",
      "http://sourceforge.net/projects/mspgcc/files/Patches/LTS/20120406/msp430-gcc-4.6.3-20120406-sf3559978.patch"
    ]
  end

  def install
    # The bootstrap process uses "xgcc", which doesn't have these flags. This
    # results in an error like the following:
    # configure: error: cannot compute suffix of object files: cannot compile
    # which, upon further inspection, arises when xgcc bails out when it sees
    # this argument.
    ENV.remove_from_cflags '-Qunused-arguments'
    ENV.remove_from_cflags '-march=native'
    ENV.remove_from_cflags(/ ?-mmacosx-version-min=10\.\d/)

    # gcc must be built outside of the source directory.
    mkdir 'build' do
      binutils = Formula.factory('msp430-binutils')
      system "../configure", "--target=msp430", "--enable-languages=c", "--program-prefix='msp430-'", "--prefix=#{prefix}", "--with-as=#{binutils.opt_prefix}/msp430/bin/as", "--with-ld=#{binutils.opt_prefix}/msp430/bin/ld"
      system "make"
      system "make install"

      # Remove libiberty, which conflicts with the same library provided by
      # binutils.
      # http://msp430-gcc-users.1086195.n5.nabble.com/overwriting-libiberty-td4215.html
      # Fix inspired by:
      # https://github.com/larsimmisch/homebrew-avr/commit/8cc2a2e591b3a4bef09bd6efe2d7de95dfd92794
      multios = `gcc --print-multi-os-directory`.chomp
      File.unlink "#{prefix}/lib/#{multios}/libiberty.a"
    end
  end
end
