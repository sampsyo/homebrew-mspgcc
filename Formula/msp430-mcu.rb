require 'formula'

class Msp430Mcu < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-20120406.tar.bz2'
  sha1 'c096eec84f0f287c45db713a550ec50c518fa065'

  def install
    # Create the "bin" directory for installation. The install.sh script
    # expects this to exist.
    Dir.mkdir "#{prefix}/bin"

    # As suggested by the README.
    ENV['MSP430MCU_ROOT'] = Dir.pwd
    system "./scripts/install.sh", prefix
  end
end
