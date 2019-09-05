#!/bin/sh

backup_dir() {
    files=""

    for file in $(find $1 -d 1)
    do
        if [[ -f $file ]] ; then
            files="$files $file"
        elif [[ -d $file ]] ; then
            backup_dir $file
        fi
    done

    if [[ files != "" ]] ; then
        echo "Files in directory: $files"
    fi
}

if [[ -e $2 && ! -d $2 ]] ; then
    echo "Target $2 already exists but is not a directory!"
    exit 1
fi

backup_dir "$@"

exit 0
