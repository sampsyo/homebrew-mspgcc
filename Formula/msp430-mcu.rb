require 'formula'

class Msp430Mcu < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-20120406.tar.bz2'

  def install
    system "./scripts/install.sh", prefix
  end
end
