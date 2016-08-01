class Msp430Binutils < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.22.tar.gz"
  sha256 "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6"

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/binutils-2.22/msp430-binutils-2.22-20120911.patch"
    sha256 "1dc3cfb0eac093b5f016f4264b811b4352515e8a3519c91240c73bacd256a667"
  end

  def install
    mkdir "build" do
      system "../configure", "--target=msp430", "--program-prefix='msp430-'", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end
end
