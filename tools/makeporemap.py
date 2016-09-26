#!/usr/bin/env python2
import sys
import os

# Given the source of craftbukkit,
# generate a craftbukkit -> pore remap
if len(sys.argv) < 2 or "help" in sys.argv[1]:
    print("Usage: python2 makeporemap.py [Craftbukkit Source Directory] [Optional Version Argument, Defaults to impl]")
    print("Example : python2 makeporemap.py Spigot-Server/src/main/java/ v1_10_R1")
    quit()

version = "impl"
if len(sys.argv) >= 3:
    version = sys.argv[2]

for path, subdirs, files in os.walk(sys.argv[1]):
    for x in files:
        line = os.path.relpath(os.path.join(path, x), os.path.dirname(sys.argv[1]))
        if "org/bukkit/craftbukkit" in line:
            line = line.rstrip()
            line = line.replace(".java", "")
            beforeLine = line.replace("org/bukkit/craftbukkit", "org/bukkit/craftbukkit/" + version)
            line = line.replace("org/bukkit/craftbukkit", "blue/lapis/pore/impl")
            line = line.replace("Craft", "Pore")
            print("CL: " + beforeLine + " " + line)
