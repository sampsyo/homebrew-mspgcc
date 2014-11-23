require 'formula'

class Mspgcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/mspgcc/mspgcc/DEVEL-4.7.x/mspgcc-20120911.tar.bz2'
  sha1 '04f5860857dbb166d997737312494018b125f4bd'
end

class Msp430Gdb < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://ftpmirror.gnu.org/gdb/gdb-7.2a.tar.bz2'
  sha1 '14daf8ccf1307f148f80c8db17f8e43f545c2691'
  env :std

  patch do
    url "http://sourceforge.net/projects/mspgcc/files/Patches/gdb-7.2a/msp430-gdb-7.2a-20111205.patch/download"
  end

  def install
    mkdir 'build' do
        #supress warnings
        ENV['CFLAGS']='-Wno-error=return-type -Wno-error=sizeof-pointer-memaccess -Wno-error=sometimes-uninitialized'
        system "../configure",
                "--target=msp430",
                "--program-prefix='msp430-'",
                "--prefix=#{prefix}"
        system "make"
        system "make install"
    end
  end
end
