# Original manual

Thanks to
[Yrrah2 from stardot](https://stardot.org.uk/forums/memberlist.php?mode=viewprofile&u=838),
there's an OCR'd copy of the manual in the repo:
[BASIC_Editor_Manual.pdf](./BASIC_Editor_Manual.pdf).

The vast majority of the manual still applies. Differences are noted
below.

# General

## MODE 2/5 avoidance

The editor will select MODE 135 if it finds itself starting up in a
mode with less than 40 columns. It's no fun trying to work in 20
column mode!

On a Master or B+, MODE 135 is a shadow mode; on a B or Electron it's
equivalent to selecting mode 7. Either way, you'll never lose any
memory compared to whatever mode was initially selected.

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

## SHIFT+ESCAPE (in The BASIC Editor)

You can press SHIFT+ESCAPE at the command prompt or in edit mode to
get back to BASIC.

## SHIFT+ESCAPE (in BASIC)

You can press SHIFT+ESCAPE at the BASIC prompt to get back to The
BASIC Editor. If you left The BASIC Editor while in edit mode, using
SHIFT+ESCAPE or f9, you'll go back to edit mode again; otherwise,
command mode.

This feature is off by default. Switch it on with `*FX26,1`, or switch
it off with `*FX26,0`.

(This works by trapping the `Escape` error while BASIC is active, so
you don't necessarily have to actually be at the BASIC prompt
specifically! On the other hand, it is easily foiled, e.g., by
`*FX229,1`.)

Unfortunately this feature does not (yet?) work in the second
processor.

## Case-insensitive search

The `FIND`, `CHANGE` and `QCHANGE` commands have case-insensitive
equivalents: `IFIND`, `ICHANGE` and `QICHANGE`.

When using `ICHANGE` or `QICHANGE`, the replacement text's case is
always retained.

## No MODE restrictions

You can select any screen mode, not just 0-7, so additional modes
(shadow RAM, alternative display drivers, etc.) are available.

The editor will switch out of a 20-column mode on startup if it
detects one, but it will let you select one manually.

# Edit mode

## Insert mode ##

Insert mode is now the default.

## Default colour scheme

The default colour scheme is now white on black instead of white on
blue.

## COPY key

The COPY key deletes forward, like SHIFT+DELETE.

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

# Electron version

The Electron version is largely identical to the BBC normal version
but has had some changes to accommodate differences in the Electron's
display and keyboard capabilities.

When in the editor, insert mode is indicated by a flashing cursor.
Overwrite mode uses a steady cursor.

Function keys 0-9 do the same thing as they do on the BBC but you
obviously have to press FUNC + number.  Also note that f0 (execute)
is at the other end of the row.

SHIFT and CTRL, however, cannot be used with function keys, nor COPY
and the cursor keys.  Instead, these functions have been remapped to
FUNC + various letters and punctuation characters:

- A - swap case (SHIFT+f3)
- B - number (SHIFT+f7)
- C - foreground (CTRL+f8)
- D - previous statement (CTRL+left)
- E - extend statement (SHIFT+f4)
- F - next statement (CTRL+right)
- G - goto (CTRL+f1)
- J - join statements (CTRL+f3)
- K - mark (CTRL+f0)
- L - label (SHIFT+f6)
- M - mode (SHIFT+f5) - currently unused
- N - new (SHIFT+f0)
- O - old (SHIFT+f1)
- Q - scroll on (CTRL+f5)
- R - ZRUN (CTRL+f9)
- S - split statement (CTRL+f2)
- T - insert at top (SHIFT+f8)
- U - undo (SHIFT+f2)
- V - background (CTRL+f7)
- W - scroll off (CTRL+f6)
- Y - repeat (CTRL+f4)
- Z - ZSAVE (SHIFT+f9)
- ,/< - start of line (SHIFT+left)
- ./> - end of line (SHIFT+right)
- :/* - screen up (SHIFT+up)
- (slash)/? - screen down (SHIFT+down)
- -/= - top of screen (CTRL+up)
- ;/+ - bottom of screen (CTRL+down)

Note that these shortcuts prevent you from using FUNC + the letter keys to
obtain the keyword firmkeys that you would normally get in BASIC on the
Electron.

# The BASIC Editor (relocatable) (MOS 3.50 only) (DIY required)

The BASIC Editor (relocatable) is an ordinary-looking sideways ROM
containing The BASIC Editor. But, in conjunction with its relocation
bitmap (supplied), and a bit of elbow grease (this part is up to you,
sorry!), it can also act as The HIBASIC Editor when used with a 6502
second processor. Both ROMs in 1 ROM bank!

These files can be used with my `tube_relocation` Python 3.x script:
https://github.com/tom-seddon/beeb/tree/master/bin#tube_relocation -
the script will insert the relocation bitmap into a spare region in
some other ROM, and update the ROM image updated to refer to it.

You should be able to make this work with standard MOS 3.50, but my
refreshed MOS 3.50 versions will give you more options (and noticeably
improve the relocation speed):
https://github.com/tom-seddon/acorn_mos_disassembly/blob/master/docs/refresh.md

Setting this up is currently a DIY job.
