#!/bin/sh

backup_dir() {
    local files=""

    cd $1

    for file in $(find . -maxdepth 1 -mindepth 1)
    do
        file=${file:2}
        echo "Looking at file $file"
        if [[ -f $file ]] ; then
            if [[ "$files" != "" ]] ; then
                files="$files $file"
                echo "Set files to $files"
            else
                files=$file
                echo "Set empty files to $files"
            fi
        elif [[ -d $file ]] ; then
            src=$1
            destDir="$2/$file"
            if [[ -e $destDir && ! -d $destDir ]] ; then
                echo "Target directory $destDir already exists but is not a directory!"
                exit 1
            fi
            mkdir -p $destDir

            absSrc="$src/$file"
            echo "Calling backup_dir with absSrc: $absSrc dest: $destDir"
            backup_dir $absSrc $destDir
            cd $1
        fi
    done

    echo "files is $files"
    if [[ "$files" != "" ]] ; then
        dest=$2
        destFile="$dest/BACKUP.tar.gz"
        echo "tar -czvf $destFile $files"
        tar -czvf $destFile $files
    fi
}

files=""
backup_dir $1 $2

exit 0
