# Original manual

Thanks to
[Yrrah2 from stardot](https://stardot.org.uk/forums/memberlist.php?mode=viewprofile&u=838),
there's an OCR'd copy of the manual in the repo:
[BASIC_Editor_Manual.pdf](./BASIC_Editor_Manual.pdf).

The vast majority of the manual still applies. Differences are noted
below.

# Command mode

## Command prompt

The command prompt HUD is gone. The command line shows the number of
bytes free.

The other information previously shown in the HUD can be seen with
`INFO`.

## Help text

The `HELP` output is a bit shorter and not as nicely formatted.

## `RUN` abbrevation

`RUN` can now be spelled `R`, which was previously the abbreviation
for `RENUMBER`.

## `REM>`, `ZSAVE` and `ZRUN`

The first line in the program may be a `REM` in the BASIC V style that
specifies the file the program should be saved to:

    10 REM > Filename

The line number doesn't matter (it just has to be the first line), and
the spaces are optional. If it's the first line, `100REM>Filename`
(say) will do just as well.

You can save the program to this file using the new `ZSAVE` command
(abbrevation `Z`), or save it to this file and then run it using the
new `ZRUN` command (abbrevation `ZR`).

## Shift+ESCAPE

You can press Shift+ESCAPE at the command prompt to get back to BASIC.

## Case-insensitive search

The `FIND`, `CHANGE` and `QCHANGE` commands can now search
case-insensitively. (When using `CHANGE` or `QCHANGE`, the replacement
text's case is always retained.)

The new command `CASE` makes these commands case-sensitive (the
default); the new command `NOCASE` makes them case-insensitive.

The case sensitivity status can be seen using the `INFO` command.

# Edit mode

## Insert mode ##

Insert mode is now the default.

## Default colour scheme

The default colour scheme is now white on black instead of white on
blue.

## COPY key

The COPY key deletes forward, like SHIFT+DELETE.

## No MODE restrictions

You can use any screen mode to edit, making shadow RAM modes
available. (And modes 2 and 5, if you're so inclined.)

## SHIFT+left/right ##

Use SHIFT+left arrow to move the cursor to the beginning of the line,
and SHIFT+right arrow to move it to just past the end.

(The previous SHIFT+left/right functionality - move cursor left/right
two spaces - is gone.)

## CTRL+left/right

Use CTRL+left/right arrow to move the cursor between places where you
can (probably) add a new statement. The cursor stops at the beginning
of a line, after a `:`, or just after the end of a line.

(The search is not intelligent. If there's a `:` in the line, it will
be found, even if it's in a string or a comment.)

(The previous CTRL+left/right functionality - move cursor between
lines - is replaced by the new CTRL+up/down shortcut. Not exactly the
same, just very similar.)

## CTRL+up/down

Use CTRL+up/down to move the cursor to the previous or next line.

(The previous CTRL+up/down functionality - move cursor to top or
bottom of screen - is gone.)

## SHIFT+f9, CTRL+f9

If the program has a `REM>` (see above), press SHIFT+f9 to save it
from edit mode, like `ZSAVE`, or CTRL+f9 to save it and run it, like
`ZRUN`.

# `*BZ` and `*BR` #

If the first line is a `REM>`, you can use `*BZ` to do a `ZSAVE` from
inside BASIC, and use `*BR` to do a `ZRUN`.

# Zero page promise

The BASIC Editor now explicitly promises to preserve memory between
&70 and &8F inclusive, the zero page region allocated by BASIC for
user routines.

# The HIBASIC Editor

The HIBASIC Editor is The BASIC Editor analogue of HIBASIC: a version
assembled to run at &B800 inside your 6502 Second Processor, giving
you at least 50% more free memory. (45,054 bytes, to be precise,
compared to the 30,718 you get with the non-HI version on a Master.
Non-Master disc users will see an even greater benefit.)

Aside from all the extra memory, it's supposed to work exactly the
same as The BASIC Editor.

Notes:

- The HIBASIC Editor doesn't check to make sure you're running
  HIBASIC, but ideally you should be; otherwise, if your program is
  large enough to require The HIBASIC Editor, when you go back to
  BASIC, it will be overwritten...

  (On the Master 128, provided you've got HIBASIC in a ROM slot, The
  HIBASIC Editor seems to find it, even if it's not the language.)

- You can have The HIBASIC Editor and The BASIC Editor installed
  simultaneously. Put The HIBASIC Editor in the higher-priority ROM
  slot; when the Tube isn't active, the ROM does basically nothing, so
  when you type `*BE` you'll get The BASIC Editor.

