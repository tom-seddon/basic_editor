#!env python
import argparse,sys,os,os.path
emacs=os.getenv("EMACS") is not None

##########################################################################
##########################################################################

def fatal(str):
    sys.stderr.write("FATAL: %s"%str)
    if str[-1]!="\n": sys.stderr.write("\n")
    
    if emacs: raise RuntimeError
    else: sys.exit(1)

##########################################################################
##########################################################################

def get_rom_str(rom,i):
    str=""
    while rom[i]!=0:
        str+=chr(rom[i])
        i+=1

    return i+1,str

def main(options):
    if options.not_emacs:
        global emacs
        emacs=False
    
    with open(options.realrom,"rb") as f: a=[ord(x) for x in f.read()]
    with open(options.altrom,"rb") as f: b=[ord(x) for x in f.read()]

    print "%s: %d bytes"%(options.realrom,len(a))
    print "%s: %d bytes"%(options.altrom,len(b))

    if len(a)!=len(b): fatal("ROMs are not the same length")

    # Check realrom is a valid Tube ROM with space for the relocation
    # bitmap.
    i,name=get_rom_str(a,9)
    i,ver=get_rom_str(a,i)
    i,copyr=get_rom_str(a,i)
    reloc=(a[i+0]<<0)|(a[i+1]<<8)
    i+=2

    print "ROM: Name: %s"%name
    print "      Ver: %s"%ver
    print "    Copyr: %s"%copyr
    print "     Copro address: 0x%04X"%reloc

    if not copyr.startswith("(C)"): fatal("seemingly not a ROM: %s"%options.realrom)
    if a[6]!=128+64+32+2: fatal("invalid ROM flags")
    if a[i]!=0 or a[i+1]!=0: fatal("relocation pointer has top bits set")
    
    # Build the relocation table
    num_diffs=0
    dist=None
    relocs=[]
    num_relocs=0
    for i in range(len(a)):
        if a[i]>=0x7F and a[i]<=0xBF:
            reloc=False
            if a[i]!=b[i]:
                reloc=True
                if dist is None: dist=b[i]-a[i]
                else:
                    if b[i]-a[i]!=dist: fatal("distance is not constant (was: %d now: %d"%(dist,b[i]-a[i]))
            index=num_relocs>>3
            mask=1<<(7-(num_relocs&7))
            if index==len(relocs): relocs.append(0)
            if reloc: relocs[index]|=mask
            num_relocs+=1

    relocs.reverse()
    relocs="".join(["%c"%x for x in relocs])+chr((len(relocs)>>0)&255)+chr((len(relocs)>>8)&255)+chr(0xC0)+chr(0xDE)

    print "%d bytes relocation data (%d relocatable bytes)"%(len(relocs),num_relocs)

    print "%d bytes left in ROM"%(16384-(len(a)+len(relocs)))
                    
    if len(a)+len(relocs)>16384: fatal("relocation data won't fit in ROM")
    # print "%d diff(s) - %d bytes"%(num_diffs,(num_diffs+7)/8)

    # unfortunately the ROM turned out to be too big to store the
    # data, so I never bothered finishing this program.
    fatal("This tool is unfinished")

##########################################################################
##########################################################################

if __name__=="__main__":
    parser=argparse.ArgumentParser(description="build Acorn MOS 3.50 relocation table data")

    parser.add_argument("--not-emacs",
                        action="store_true",
                        help="Assume not running under emacs")

    parser.add_argument("-o",
                        metavar="FILE",
                        help="File to write full relocatable ROM to")

    parser.add_argument("realrom",
                        metavar="REAL-ROM",
                        help="Path to ROM assembled for &8000")

    parser.add_argument("altrom",
                        metavar="ALT-ROM",
                        help="Path to ROM with language part assembled for Tube")

    args=sys.argv[1:]

    options=parser.parse_args(args)
    main(options)
    
