class Msp430Gdb < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://ftpmirror.gnu.org/gdb/gdb-7.2a.tar.bz2"
  sha256 "3c24dde332e33bfe2d5980c726d76224ebf8304278112a07bf701f8d2145d9bc"
  env :std

  patch do
    url "https://downloads.sourceforge.net/project/mspgcc/Patches/gdb-7.2a/msp430-gdb-7.2a-20111205.patch"
    sha256 "b70b54df5e00d24a3a5b744545a87ce656bdc88546081c6ffabefbc4d6c42956"
  end

  def install
    mkdir "build" do
      # supress warnings
      ENV["CFLAGS"] = "-Wno-error=return-type -Wno-error=sizeof-pointer-memaccess -Wno-error=sometimes-uninitialized"
      system "../configure",
              "--target=msp430",
              "--program-prefix='msp430-'",
              "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end
end
