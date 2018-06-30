# Original manual

There's a nice OCR'd copy of the original manual available from stardot: https://stardot.org.uk/forums/viewtopic.php?f=2&t=4785#p49280

# Changes in this version

## Insert mode

Insert mode is now the default.

## Default colour scheme

The default colour scheme is now white on black instead of white on
blue.

## COPY key

In edit mode, the COPY key deletes forward, like SHIFT+DELETE.

## No MODE restrictions

You can use any screen mode to edit, making shadow RAM modes
available. (And modes 2 and 5, if you're so inclined.)

## `RUN` is abbreviated `R`

`R` was previously the abbreviation for `RENUMBER`.

## File name

When you `LOAD` or `SAVE` a file, the file name as saved off. You'll
see this shown when in command mode.

Note that only the first 14 characters are stored off. You can
explicitly save and load files with longer names, but the additional
chars won't be stored. The command mode HUD will show the stored name,
so it should at least be fairly obvious when this happens...

## Quick save

The new `ZSAVE` command (abbreviation `Z`) saves the program using the
current file name.

The new `ZRUN` command (abbreviation `ZR`) saves the program using the
current file name, then runs it. It's equivalent to doing `ZSAVE` then
`RUN`.

## `REM>`

The first line in the program may be a `REM` in the BASIC V style that
names the program:

    10 REM > Filename

If such a line is present, the program's name will be taken from the
`REM` after an `OLD` command or on entry to the ROM (i.e., after BREAK
or `*BE`). `ZSAVE`/`ZRUN` will then save the program to the right
file.
     
The line number doesn't matter (it just has to be the first line), and
the spaces are optional. If it's the first line, `100REM>Filename`
(say) will do just as well.

## Case-insensitive search

The `FIND`, `CHANGE` and `QCHANGE` commands can now search
case-insensitively. (When using `CHANGE` or `QCHANGE`, the replacement
text's case is always retained.)

The new command `CASE` makes these commands case-sensitive (the
default); the new command `NOCASE` makes them case-insensitive.

The case sensitivity status can be seen using the `INFO` command.

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

