homebrew-mspgcc
===============

These are [Homebrew][] formulae for [mspgcc][], the compiler toolchain for the MSP430 microcontroller. The repository includes `binutils`, `gcc`, `libc`, and the `mcu` files.

To get everything, type:

    $ brew tap sampsyo/mspgcc
    $ brew install msp430-libc

Since `libc` is the top of the dependency chain, this should suffice to get everything you need.

    $ msp430-gcc --version
    msp430-gcc (GCC) 4.6.3 20120301 (mspgcc LTS 20120406 unpatched)
    ...

These formulae are quick n' dirty and undoubtedly need some improvement (missing dependencies, brittle workarounds, etc.). I also haven't (yet) included `gdb` or `mspdebug`.

[mspgcc]: http://mspgcc.sourceforge.net/
[Homebrew]: http://mxcl.github.io/homebrew/
