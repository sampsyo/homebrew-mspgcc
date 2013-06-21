require 'formula'

class Mspgcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/mspgcc/mspgcc-20120406.tar.bz2'
  sha1 'cc96a7233f0b1d2c106eff7db6fc00e4ed9039a8'
end

class Msp430Binutils < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://ftpmirror.gnu.org/binutils/binutils-2.21.1a.tar.bz2'
  sha1 '525255ca6874b872540c9967a1d26acfbc7c8230'

  def patches
    Mspgcc.new.brew do
      buildpath.install "msp430-binutils-2.21.1a-20120406.patch"
    end
    "msp430-binutils-2.21.1a-20120406.patch"
  end

  def install
    system "./configure", "--target=msp430", "--program-prefix='msp430-'", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
