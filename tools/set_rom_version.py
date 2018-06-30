#!env python
import argparse,re,sys

def fatal(str):
    sys.stderr.write("FATAL: %s"%str)
    if str[-1]!='\n': sys.stderr.write("\n")
    sys.exit(1)

def main(options):
    with open(options.fname,"rb") as f: data=f.read()

    if re.match(r"^[0-9]\.[0-9][0-9]$",options.version) is None: fatal("version not N.NN: %s"%options.version)

    nn=ord(data[7])
    if data[nn:nn+4]!=chr(0)+"(C)": fatal("not a ROM (bad copyright string)")

    ver=9
    while data[ver]!=chr(0): ver+=1
    if data[ver:ver+6]!=chr(0)+" $VER": fatal("didn't find $VER marker in ROM title")

    ver+=2#skip "\x00 "

    # Replace $VER with actual version.
    data=data[:ver]+options.version+data[ver+4:]

    # Replace ROM version with BCD fraction.
    h=int(options.version[-2])
    l=int(options.version[-1])
    data=data[:8]+chr(h*16+l)+data[9:]

    if options.output_fname is not None:
        with open(options.output_fname,"wb") as f: f.write(data)
    
if __name__=="__main__":
    parser=argparse.ArgumentParser(description="set The BASIC Editor ROM version")

    parser.add_argument("-o",
                        dest="output_fname",
                        metavar="FILE",
                        default=None,
                        help="file to save new ROM image to")

    parser.add_argument("fname",
                        metavar="FILE",
                        help="BBC Micro ROM image")

    parser.add_argument("version",
                        metavar="VERSION",
                        help="Version to set")

    args=sys.argv[1:]

    options=parser.parse_args(args)
    
    main(options)
    
