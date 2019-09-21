#!/usr/bin/python
import os
import sys

def backup(srcDir, backupDir):
    with os.scandir(srcDir) as entries:
        dirs = []
        files = []

        for entry in entries:
            if entry.is_dir():
                dirs.append(entry.name)
            else:
                files.append(entry.name)

        print("dirs: " + str(dirs))
        print("files: " + str(files))

backup(sys.argv[1], "")
