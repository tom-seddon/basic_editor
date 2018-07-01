# New in 1.40

- `\*BZ` and `\*BR`
- Shorten error messages to make space

# New in 1.39

- VDU5, VDU19 and COLOUR settings reset on entry (bug introduced in
  1.35)
- New `ZRUN` command that does a `ZSAVE` then `RUN`

# New in 1.38

- Paged mode disabled when editing (bug introduced in 1.35)
 
# New in 1.37

- You can press SHIFT+ESCAPE at the command prompt to get back to
  BASIC
- Searches can be case-insensitive

# New in 1.36

- Error messages work again (version 1.35 would hang if you tried to
  `LOAD` a non-existent file, for example)

# New in 1.35

(What happened to 1.34? Don't ask. It won't happen again.)

- `COPY` key forward deletes
- `MODE` restrictions have been lifted
- Full help text is back (albeit in a slightly less pretty form)
- `OVERTYPE` is back
- `ZAUTOSAV` is called `ZSAVE`
- The HIBASIC Editor
- Smaller command prompt HUD

# New in 1.33

- `RUN` can be spelt `R`
- Default colour scheme is white on black
- Insert mode is the default
- Command prompt HUD shows program name
- `SAVE` updates program name
- New `ZAUTOSAV` command to save the program under the program name
- Program name inferred from initial `REM>`
- Shorter HELP text
- `OVERTYPE` command mode command has been removed
- Smaller command prompt HUD