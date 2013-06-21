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

  # depends_on 'msp430-binutils'

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
      "msp430-gcc-4.6.3-20120406.patch",
      "msp430-gcc-4.6.3-20120406-sf3540953.patch",
      "msp430-gcc-4.6.3-20120406-sf3559978.patch"
    ]
  end

  def install
    # Configure seems to fail if we run it in the source directory, so we
    # instead build in a subdirectory.
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure", "--target=msp430", "--enable-languages=c", "--program-prefix='msp430-'", "--prefix=#{prefix}"
      system "make"
      system "make install"
    end
  end
end
