homebrew-mspgcc
===============

These are [Homebrew][] formulae for [mspgcc][], the compiler toolchain for the MSP430 microcontroller. The repository includes `binutils`, `gcc`, `libc`, and the `mcu` files.

To get everything, type:

    $ brew tap sampsyo/mspgcc
    $ brew install msp430-libc

Since `libc` is the top of the dependency chain, this should suffice to get everything you need.

    $ msp430-gcc --version
    msp430-gcc (GCC) 4.7.0 20120322 (mspgcc dev 20120911)
    ...

These formulae are quick n' dirty and undoubtedly need some improvement (missing dependencies, brittle workarounds, etc.). I also haven't (yet) included `gdb` or `mspdebug`.

One manual step is required to get a working system. Annoyingly, since the `--prefix=` compile option for each of these packages is different, each of the various tools can't find required files installed by other packages. To consolidate the various `lib` pieces under a common directory, run:

    $ $(brew --prefix)/Homebrew/Library/Taps/sampsyo/homebrew-mspgcc/addlinks.sh

This script symlinks everything from all the packages into `msp430` under the msp430-gcc keg. This means your root for the MSP430 toolchain is something like `/usr/local/opt/msp430-gcc/msp430` (which would be `/usr/local/msp430` on a "normal" installation).

[mspgcc]: http://mspgcc.sourceforge.net/
[Homebrew]: http://brew.sh
