import os,os.path,sys

good=True
for x in sys.argv[1:]:
    size=os.path.getsize(x)
    print "%s: %d byte(s) free"%(x,16384-size)
    if size>16384:
        good=False

if not good:
    sys.exit(1)
