class Msp430Mcu < Formula
  homepage "http://mspgcc.sourceforge.net"
  url "https://downloads.sourceforge.net/project/mspgcc/msp430mcu/msp430mcu-20130321.tar.bz2"
  sha256 "01be411f8901362fab32e7e1be044a44e087a98f3bd2346ac167960cfe6fa221"

  def install
    # Create the "bin" directory for installation. The install.sh script
    # expects this to exist.
    Dir.mkdir bin.to_s

    # As suggested by the README.
    ENV["MSP430MCU_ROOT"] = Dir.pwd
    system "./scripts/install.sh", prefix
  end
end
