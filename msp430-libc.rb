require 'formula'

class Msp430Libc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-20120224.tar.bz2'
  sha1 'd01cf0db41bff1a0ab50644cbb11bc5a1d5be172'

  depends_on 'msp430-gcc'
  depends_on 'msp430-mcu'

  def install
    Dir.chdir 'src' do
      system "make"
      system "make", "PREFIX=#{prefix}", "install"
    end
  end
end
