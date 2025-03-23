The Advanced Basic Editor and Advanced Basic Editor Plus were PRES
products for the Electron. Review here:
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
`../beeb/1/$.ELECTRON`.

`$.!MAKROM` has 3 includes commented out. You can find a copy of the
ROM built with those commented back in in `../beeb/1/$.ELECTRON2`.

There's a ROM image on the disk already: `../beeb/1/$.ELK`. It doesn't
match either of the above.

I haven't actually tested any of these ROMs yet.

