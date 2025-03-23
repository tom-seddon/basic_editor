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

# Source files

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
`butils.s65`.

To build it, ensure 64tass is on the path, then do `make pres_stuff`
from the root of the working copy. This will assemble the code and
check it matches `$.ELECTRON2` (see above) - the build will fail if it
doesn't.

# Original ROMs

ROM images can be found in this folder, named `ABE` or `ABEP`
according to product: `.32KB.rom` is the original 32 KB ROM, useable
with the appropriate PLD. and `.0.rom` and `.1.rom` are the two 16 KB
halves, not useable independently.

It looks like these two products are essentially identical. The
differences between `ABE.0.rom` and `ABEP.1.rom`:

```
-00000000: 4c 36 b9 4c 7d b9 c2 24 01 41 64 76 61 6e 63 65 L6.L}..$.Advance
+00000000: 4c 36 b9 4c 7d b9 c2 24 01 54 68 65 20 42 41 53 L6.L}..$.The BAS
```
```
-00000010: 64 20 42 41 53 49 43 20 45 64 69 74 6f 72 20 00 d BASIC Editor .
+00000010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 20 00 IC Editor Plus .
```

The differences between `ABE.1.rom` and `ABEP.0.rom`:

```
-00000000: 4c 52 8e 4c 33 80 c2 24 01 41 64 76 61 6e 63 65 LR.L3..$.Advance
+00000000: 4c 52 8e 4c 33 80 c2 24 01 54 68 65 20 42 41 53 LR.L3..$.The BAS
```
```
-00000010: 64 20 42 41 53 49 43 20 45 64 69 74 6f 72 00 20 d BASIC Editor.
+00000010: 49 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 20 IC Editor Plus.
```
```
-00002990: 6e 67 20 3a 20 16 07 0a 41 64 76 61 6e 63 65 64 ng : ...Advanced
+00002990: 6e 67 20 3a 20 16 07 0a 54 68 65 20 42 41 53 49 ng : ...The BASI
```
```
-000029A0: 20 42 41 53 49 43 20 45 64 69 74 6f 72 00 0d 0a  BASIC Editor...
+000029A0: 43 20 45 64 69 74 6f 72 20 50 6c 75 73 00 0d 0a C Editor Plus...
```

The ABEP 32 KB ROM is the other way around, so to speak, and it seems
the PLD is set up differently to accommodate this. Looks like in both
cases accessing $bff8...$bffb selects the BASIC Editor half, and
accessing $bffc...$bfff selects the BUTILS half.

