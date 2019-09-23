#!/usr/bin/python
import os
import sys
import tarfile

def backup(srcDir, backupDir):
    with os.scandir(srcDir) as entries:
        dirs = []
        files = []

        for entry in entries:
            if entry.is_dir():
                backup(srcDir + '/' + entry.name, backupDir + '/' + entry.name)
            else:
                files.append(entry.name)

        os.makedirs(backupDir, exist_ok=True)
        tar = tarfile.open(backupDir + '/BACKUP.tar.gz', 'w:gz')
        for file in files:
            tar.add(srcDir + '/' + file)
        tar.close()

backup(sys.argv[1], sys.argv[2])
