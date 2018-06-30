# The BASIC Editor

From the ROM:

* `(C) 1984 Acornsoft`
* `From the pens of Pete Morris & Chris Gibson. P.S. many thanks Pat!`

An updated version of Acornsoft's BASIC Editor. Extra functionality,
improved usability, shadow RAM compatibility and a new HIBASIC Editor
for use with the 6502 Second Processor.

More details from its web page:
http://www.tomseddon.plus.com/beeb/be.html

# Building

Prerequisites:

* Some kind of Unix with all the usual Unix stuff
* GNU Make
* [64tass](https://sourceforge.net/projects/tass64/)
* Recent Python 2.x

To build, type `make`.

The ROM images are written to a folder called `.build`: `basiced.rom`
and `hibasiced.rom`.

