class Msp430Libc < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://downloads.sourceforge.net/project/mspgcc/msp430-libc/msp430-libc-20120716.tar.bz2"
  sha256 "cbd78f468e9e3b2df9060f78e8edb1b7bfeb98a9abfa5410d23f63a5dc161c7d"

  depends_on "msp430-gcc"
  depends_on "msp430-mcu"

  def install
    # When building, we need to have the "msp430/bin" directory on the path.
    # This is because, even when we invoke msp430-gcc, it goes looking for a
    # binary called "as". If we don't do this, then it will find the system
    # (i.e., x86) as.
    binutils = Formula["msp430-binutils"]
    gcc = Formula["msp430-gcc"]
    msppath = "#{binutils.opt_prefix}/msp430/bin:#{gcc.opt_prefix}/msp430/bin"

    Dir.chdir "src" do
      ENV.prepend_path "PATH", msppath.to_s
      system "make"
      system "make", "PREFIX=#{prefix}", "install"
    end
  end
end
