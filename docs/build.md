# git clone

This repo has submodules. Clone it with `--recursive`:

    git clone --recursive https://github.com/tom-seddon/basic_editor
	
Alternatively, if you already cloned it non-recursively, you can do
the following from inside the working copy:

    git submodule init
	git submodule update

(The code won't build without fiddling around if you download one of
the archive files from GitHub - a GitHub limitation. It's easiest to
clone it as above.)

# Building

Prerequisites (Unix):

* GNU Make
* [64tass](https://sourceforge.net/projects/tass64/)
* Python 3.x

Prerequisites (Windows):

* Python 3.x

To build, type `make`.

The ROM images are written to a folder called `.build`:

- `basiced.rom` - The BASIC Editor, BBC version
- `hibasiced.rom` - The HIBASIC Editor, BBC version
- `elkbasiced.com` - The BASIC Editor, Electron version
- `elkhibasiced.com` - The HIBASIC Editor, Electron version
- `rbasiced.rom` `rbasiced.relocation.dat` - The BASIC Editor, relocatable MOS 3.50 version
