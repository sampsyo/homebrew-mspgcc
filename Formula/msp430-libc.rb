require 'formula'

class Msp430Libc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-20120224.tar.bz2'
  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
