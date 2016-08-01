require 'formula'

class Msp430Mcu < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-20120406.tar.bz2'
  sha256 "0637014e8e509746c3f6df8e1d65b786770d162b3a0b86548bdf76ac3102c96e"

  def install
    # Create the "bin" directory for installation. The install.sh script
    # expects this to exist.
    Dir.mkdir "#{prefix}/bin"

    # As suggested by the README.
    ENV['MSP430MCU_ROOT'] = Dir.pwd
    system "./scripts/install.sh", prefix
  end
end
