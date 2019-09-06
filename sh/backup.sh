#!/bin/sh

backup_dir() {
    files=""

    source=$1
    target=$2

    echo "source: $source"
    echo "target: $target"

    for file in $(find $source -d 1)
    do
        echo "Looking at file: $file"
        echo "source: $source"
        echo "target: $target"
        if [[ -f $file ]] ; then
            files="$files $file"
        elif [[ -d $file ]] ; then
            relativeDir=${file:${#source}:${#file}}
            echo "relativeDir: $relativeDir"
            targetDir="$target$relativeDir"
            if [[ -e $targetDir && ! -d $targetDir ]] ; then
                echo "Target directory $targetDir already exists but is not a directory!"
                exit 1
            fi
            echo "mkdir: $targetDir"
            mkdir $targetDir
            echo "Calling backup_dir with source: $file target: $targetDir"
            backup_dir $file $targetDir
        fi
    done

    if [[ files != "" ]] ; then
        destFile="$target/BACKUP.tar.gz"
        echo "tar -czvf $destFile $files"
        # tar -czvf $destFile $files
    fi

    echo "exiting backup_dir"
}

source=$1
target=$2

backup_dir $source $target

exit 0
