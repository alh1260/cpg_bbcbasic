# cpg_bbcbasic
BBC BASIC implementations of the competitive programming group questions

The repo no one asked for, but is being created anyway. For those that don't know, I have decided to attempt the problems featured in the UQ Computing Society's competitive programming group in a strange old language called BBC BASIC , mainly for a) the challenge of it, and b) I'm crazy. This is where I will share my implementations for those curious enough.

## Important info about these files
I provide 2 files: a version with a `.bas` extension, and another without an extension. The one with the extension is a plain text version of the source, and the extensionless file is the actual source.

Beeb BASIC, like most dialects of BASIC, doesn't store its source files as plain text, but rather in what's called a "tokenized form", which is sort of like a compiled bytecode format but only the language keywords get compiled into byte sequences. This means that you cannot open these in most normal text editors (except those on RISC OS).

## How to run these
At present the sources here will only run on the real BASIC for RISC OS (because I'm using RISC OS specific software interrupts (a.k.a. system calls for everyone else) to emulate `argv`). Downside is that RISC OS only runs on ARM Aarch32 (yes, 32-bit only! No Aarch64 here, so forget about trying to run it on your M1 Mac!), and even then only on specific devices. This leaves 2 options:
  - If you want to run natively, there is a version for the Raspberry Pi [here](https://www.riscosopen.org/content/downloads/raspberry-pi) that is fairly easy to set up. This is probably the easiest option.
  - You could use an emulator for old Acorn machines such as [RPCEmu](https://www.marutan.net/rpcemu/index.php), which emulates the [Acorn Risc PC](https://en.wikipedia.org/wiki/Risc_PC). This option does require getting old system rom images, however the rom images for the latest version of RISC OS are freely available [here](https://www.riscosopen.org/content/downloads/riscpc).

In the future I plan to provide ports to these versions of Beeb, just so you don't have to use RISC OS:

- [BBC BASIC for Windows (BB4W)](https://www.bbcbasic.co.uk/bbcwin/bbcwin.html)/[BBC BASIC for SDL (BBCSDL)](https://www.bbcbasic.co.uk/bbcsdl/index.html)
This is a good version that is still being actively developed. Notable for adding more features over the original, such as structs. It is paid software, but it appears the trial is unlimited, just that the runtime is restricted in memory size, and you can't "compile" programs.

- [Brandy Basic](https://jaguar.orpheusweb.co.uk/branpage.html)
Another good version, aims to be more like the original but also adds some quality of life improvements (such as actual `ARGC` and `ARGV$`). This one is free (both as in beer and as in freedom; it's GPLv2 licenced).

## Links
- [Wikipedia page about BBC BASIC](https://en.wikipedia.org/wiki/BBC_BASIC)
- [The current BBC BASIC reference manual from RISC OS Open, Ltd.](https://www.riscosopen.org/zipfiles/platform/common/BASICRefManual.3.pdf?1613981974)

Al H.
