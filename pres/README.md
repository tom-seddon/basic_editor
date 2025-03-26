The Advanced Basic Editor (ABE) and Advanced Basic Editor Plus (ABEP)
were PRES products for the Electron. Review here:
https://www.everygamegoing.com/larticle/Advanced-Basic-Editor-Plus-000/15244

It comes as a 32 KB ROM with a bank switching mechanism handled by a
PLD. (Accesses to $bff8...$bffb select one bank, and $bffc...$bfff
select the other.)

The product looks a lot like the Acornsoft BASIC Editor, with an extra
command (`UTILS`) that enters a separate UI that provides some
additional stuff like program packing. And looking at the code, it
looks like it is indeed related (though not identical).

This folder contains any materials related to investigating it. Since
it's apparently related to the Acornsoft BASIC Editor, it'd be nice to
have an updated version of it too, based on the updated BASIC Editor,
if that would be easy to do!

# Original source files

Disk image posted here:
https://stardot.org.uk/forums/viewtopic.php?f=3&t=7719&start=30#p108512

The extracted contents of the disk images can be found in the repo.
Largely text files with CR line endings, so comprehensible to many PC
tools.

- BASEDS1 - `../beeb/1/`
- BASEDS2 - `../beeb/2/`
- BASEDMAN - `../beeb/3/`

There's a `!BOOT` file in BASEDS1, but it's unlikely to work out of
the box. To build the code:

1. Load `$.DDTMASS` into sideways RAM somehowand do a CTRL+BREAK
2. Ensure the output file named in the `$ATD` line in `$.!MAKROM`
   conforms to any FS restrictions (the default one is no good for
   DFS)
3. Do `*MASS !MAKROM`

You can find a copy of the ROM built from the code as supplied in
`../beeb/1/$.ELECTRON`. I haven't tested this ROM, just built it.

`$.!MAKROM` has 3 includes commented out. You can find a copy of the
ROM built with those commented back in in `../beeb/1/$.ELECTRON2`. But
it looks like just uncommenting the includes might not be enough.
There's still some commented-out stuff in `Table2`, for example - I
haven't tested this ROM either.

There's a ROM image on the disk already: `../beeb/1/$.ELK`. It doesn't
match either of the above, and I haven't tested it.

# 64tass format source files

There's a 64tass format source file converted from the BBC files in
`butils.s65`, with some flags and updates so it can be built to match
some of the existing ROMs.

To build it, ensure the prerequisites for building are available (see
[the build instructions](../docs/build.md)), then do `make
_pres_stuff` from the root of the working copy. This will assemble
each different version of the code and (when appropriate) check it
matches the original. The build will fail if there's a problem.

Consult `butils.s65` for more info about the different versions..

# Original ROMs

ROM images can be found in this folder, named after the product
according to the following table. `.32KB.rom` is a 32 KB ROM, useable
with the appropriate PLD. and `.0.rom` and `.1.rom` are the two 16 KB
halves, not useable independently.

- `ABE` - Advanced BASIC Editor
- `ABEP` - The BASIC Editor Plus
- `BET` - BASIC Editor & Tooklkit
- `BET2` - BASIC Editor & Tooklkit (sideways RAM version - no 32 KB
  version)
- `ABE-ELK` - BASIC Editor & Tooklbit (Electron version? - named
  `ABE-ELK` in [original zip](referred to as "))

Some notes about the differences.

## ABE vs ABEP

It looks like these two products are essentially identical.

The ABEP 32 KB ROM is the other way around, so to speak, and it seems
the PLD is set up differently to accommodate this. Looks like in both
cases accessing $bff8...$bffb selects the BASIC Editor half, and
accessing $bffc...$bfff selects the BUTILS half.

`-` lines are from ABE and `+` lines are from ABEP.

Differences between `ABE.0.rom` and `ABEP.1.rom` are the ROM name:

```
-00000000: 4c 36 b9 4c 7d b9 c2 24 01 41 64 76 61 6e 63 65 L6.L}..$.Advance
+00000000: 4c 36 b9 4c 7d b9 c2 24 01 54 68 65 20 42 41 53 L6.L}..$.The BAS
                                      ^^ ^^ ^^ ^^ ^^ ^^ ^^          ^^^^^^^
```
```
-00000010: 64 20 42 41 53 49 43 20 45 64 69 74 6f 72 20 00 d BASIC Editor .
+00000010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 20 00 IC Editor Plus .
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^       ^^^^^^^^^^^^^^
```

And similarly for the differences between `ABE.1.rom` and
`ABEP.0.rom`:

```
-00000000: 4c 52 8e 4c 33 80 c2 24 01 41 64 76 61 6e 63 65 LR.L3..$.Advance
+00000000: 4c 52 8e 4c 33 80 c2 24 01 54 68 65 20 42 41 53 LR.L3..$.The BAS
                                      ^^ ^^ ^^ ^^ ^^ ^^ ^^          ^^^^^^^
```
```
-00000010: 64 20 42 41 53 49 43 20 45 64 69 74 6f 72 00 20 d BASIC Editor.
+00000010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 20 IC Editor Plus.
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^       ^^^^^^^^^^^^^^
```
```
-00002990: 6e 67 20 3a 20 16 07 0a 41 64 76 61 6e 63 65 64 ng : ...Advanced
+00002990: 6e 67 20 3a 20 16 07 0a 54 68 65 20 42 41 53 49 ng : ...The BASI
                                   ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^         ^^^^^^^^
```
```
-000029A0: 20 42 41 53 49 43 20 45 64 69 74 6f 72 00 0d 0a  BASIC Editor...
+000029A0: 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 0d 0a C Editor Plus...
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^          ^^^^^^^^^^^^^
```

## BET

Looks to be based on ABEP. The 32 KB versions are mostly identical.

`-` lines are from ABEP and `+` lines are from BET.

Different names and copyrights in ROM header in part 0:

```
-00000000: 4c 52 8e 4c 33 80 c2 24 01 54 68 65 20 42 41 53 LR.L3..$.The BAS
+00000000: 4c 52 8e 4c 33 80 c2 24 01 42 41 53 49 43 20 45 LR.L3..$.BASIC E
                                      ^^ ^^ ^^ ^^ ^^ ^^ ^^          ^^^^^^^
```
```
-00000010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 20 IC Editor Plus. 
+00000010: 64 69 74 6f 72 20 26 20 54 6f 6f 6c 6b 69 74 20 ditor & Toolkit 
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^^^^^^^^^^^^^^
```
```
-00000020: 31 2e 30 30 00 28 43 29 20 31 39 38 38 20 50 52 1.00.(C) 1988 PR
+00000020: 56 31 2e 30 00 28 43 29 20 31 39 39 30 20 42 2e V1.0.(C) 1990 B.
           ^^ ^^ ^^                         ^^ ^^    ^^ ^^ ^^^        ^^ ^^
```
```
-00000030: 45 53 00 08 48 98 48 a5 a8 48 a5 a9 48 8a 48 86 ES..H.H..H..H.H.
+00000030: 45 2e 00 08 48 98 48 a5 a8 48 a5 a9 48 8a 48 86 E...H.H..H..H.H.
              ^^                                            ^
```

Additional branding updates and tweaks to command prompt HUD:

```
-00002990: 6e 67 20 3a 20 16 07 0a 54 68 65 20 42 41 53 49 ng : ...The BASI
+00002990: 6e 67 20 3a 20 16 07 0a 42 41 53 49 43 20 45 64 ng : ...BASIC Ed
                                   ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^         ^^^^^^^^
```
```
-000029A0: 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 0d 0a C Editor Plus...
+000029A0: 69 74 6f 72 20 26 20 54 6f 6f 6c 6b 69 74 00 0d itor & Toolkit..
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^    ^^ ^^ ^^ ^^ ^^ ^^^^^^^^^^ ^^^^^
```
```
-000029B0: 0a 50 72 6f 67 72 61 6d 20 73 69 7a 65 20 3a 0d .Program size :.
+000029B0: 0a 0a 50 72 6f 67 72 61 6d 20 73 69 7a 65 3a 0d ..Program size:.
              ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^     ^^^^^^^^^^^^^^
```
```
-000029C0: 0a 42 79 74 65 73 20 66 72 65 65 20 20 20 3a 0d .Bytes free   :.
+000029C0: 0a 42 79 74 65 73 20 66 72 65 65 20 20 3a 0d 0a .Bytes free  :..
                                                  ^^ ^^ ^^              ^^^
```
```
-000029D0: 0a 53 63 72 65 65 6e 20 6d 6f 64 65 20 20 3a 1f .Screen mode  :.
+000029D0: 53 63 72 65 65 6e 20 6d 6f 64 65 20 3a 20 20 1f Screen mode :  .
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^    ^^ ^^ ^^^^^^^^^^^^^ ^^
```

Different names and copyrights in ROM header in part 1:

```
-00004000: 4c 36 b9 4c 7d b9 c2 24 01 54 68 65 20 42 41 53 L6.L}..$.The BAS
+00004000: 4c 36 b9 4c 7d b9 c2 24 01 42 41 53 49 43 20 45 L6.L}..$.BASIC E
                                      ^^ ^^ ^^ ^^ ^^ ^^ ^^          ^^^^^^^
```
```
-00004010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 20 00 IC Editor Plus .
+00004010: 64 69 74 6f 72 20 26 20 54 6f 6f 6c 6b 69 74 20 ditor & Toolkit 
           ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^^^^^^^^^^^^^^^
```
```
-00004020: 31 2e 30 30 00 28 43 29 31 39 38 38 20 50 52 45 1.00.(C)1988 PRE
+00004020: 56 31 2e 30 00 28 43 29 31 39 39 30 20 42 2e 45 V1.0.(C)1990 B.E
           ^^ ^^ ^^                      ^^ ^^    ^^ ^^    ^^^       ^^^^^
```
```
-00004030: 53 00 48 8a 48 98 48 ba bd 03 01 c9 04 f0 14 c9 S.H.H.H.........
+00004030: 2e 00 48 8a 48 98 48 ba bd 03 01 c9 04 f0 14 c9 ..H.H.H.........
           ^^                                              ^
```

## `BET2`

Looks to be based on BET.

`-` lines are from BET and `+` lines are from BET2.


Different version string in ROM header in part 0:

```
-00000020: 56 31 2e 30 00 28 43 29 20 31 39 39 30 20 42 2e V1.0.(C) 1990 B.
+00000020: 31 2e 30 30 00 28 43 29 20 31 39 39 30 20 42 2e 1.00.(C) 1990 B.
           ^^ ^^ ^^                                        ^^^
```

Code change. BET accesses the magic addresses to select the other
bank, but BET2 swaps to the adjacent sideways ROM bank.

BET:

    8134 78        sei
	8135 ac f0 bf  ldy $bff0
	8138 ac fc bf  ldy $bffc
	813b ac f4 bf  ldy $bff4
	813e 58        cli

BET2:

    8134 48        pha
	8135 a5 f4     lda $f4
	8137 49 01     eor #$01
	8139 85 f4     sta $f4
	813b 8d 30 fe  sta $fe30
	813e 68        pla

```
-00000130: f0 d7 18 60 78 ac f0 bf ac fc bf ac f4 bf 58 6c ...`x.........Xl
+00000130: f0 d7 18 60 48 a5 f4 49 01 85 f4 8d 30 fe 68 6c ...`H..I....0.hl
                       ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^
```

Service entry point is a no-nop in part 2 of BET2: (looks like this
might be a poke)

```
-00000000: 4c 36 b9 4c 7d b9 c2 24 01 42 41 53 49 43 20 45 L6.L}..$.BASIC E
+00000000: 4c 36 b9 60 7d b9 c2 24 01 42 41 53 49 43 20 45 L6.`}..$.BASIC E
                    ^^                                        ^
```

Different version string in ROM header in part 1:

```
-00000020: 56 31 2e 30 00 28 43 29 31 39 39 30 20 42 2e 45 V1.0.(C)1990 B.E
+00000020: 31 2e 30 30 00 28 43 29 31 39 39 30 20 42 2e 45 1.00.(C)1990 B.E
           ^^ ^^ ^^                                        ^^^
```

Code change. Along the same lines as the change in part 0.

BET:

    b040 78        sei
	b041 ac f0 bf  ldy $bff0
	b044 ac f8 bf  ldy $bff8
	b047 ac 00 80  ldy $8000
	b04a 58        cli

BET2:

    b040 48        pha
	b041 a5 f4     lda $f4
	b043 49 01     eor #$01
	b045 85 f4     sta $f4
	b047 8d 30 fe  sta $fe30
	b04a 68        pha


```
-00003040: 78 ac f0 bf ac f8 bf ac 00 80 58 6c ee bf a9 7e x.........Xl...~
+00003040: 48 a5 f4 49 01 85 f4 8d 30 fe 68 6c ee bf a9 7e H..I....0.hl...~
```

** `ABE-ELK`

Looks to be based on BET2.

`-` lines are from BET2 and `+` lines are from ABE-ELK.

The differences are the ROM paging register written to by the ROM
switch routine. Now it's $fe35 rather than $fe30.

ABE-ELK part 1:

```
-00000130: f0 d7 18 60 48 a5 f4 49 01 85 f4 8d 30 fe 68 6c ...`H..I....0.hl
+00000130: f0 d7 18 60 48 a5 f4 49 01 85 f4 8d 35 fe 68 6c ...`H..I....5.hl
                                               ^^                      ^
```

ABE-ELK part  2:

```
-00003040: 48 a5 f4 49 01 85 f4 8d 30 fe 68 6c ee bf a9 7e H..I....0.hl...~
+00003040: 48 a5 f4 49 01 85 f4 8d 35 fe 68 6c ee bf a9 7e H..I....5.hl...~
                                   ^^                              ^
```

As this routine always switches between two non-BASIC paged ROMs, the
2-step Electron ROM switching presumably doesn't apply, and the ROM
select register can be written to directly.
