require 'formula'

class Msp430Libc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-20120224.tar.bz2'
  sha1 'd01cf0db41bff1a0ab50644cbb11bc5a1d5be172'

  depends_on 'msp430-gcc'
  depends_on 'msp430-mcu'

  def install
    # When building, we need to have the "msp430/bin" directory on the path.
    # This is because, even when we invoke msp430-gcc, it goes looking for a
    # binary called "as". If we don't do this, then it will find the system
    # (i.e., x86) as.
    binutils = Formula.factory('msp430-binutils')
    gcc = Formula.factory('msp430-gcc')
    msppath = "#{binutils.opt_prefix}/msp430/bin:#{gcc.opt_prefix}/msp430/bin"

    Dir.chdir 'src' do
      system "env", "PATH=#{msppath}:#{ENV['PATH']}", "make"
      system "make", "PREFIX=#{prefix}", "install"
    end
  end
end
