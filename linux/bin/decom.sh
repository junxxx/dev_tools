#!/bin/bash
# Decompress file automatic
getFileType() {
    echo $1
    echo 'file'
}

_main() {
    file=$1
    if [ ! -f $file ]; then
        echo "file $file does not exist!"
        exit 1
    fi
    fileExt=$(getFileType $file)
    echo $fileExt
    case $fileExt in 
        'zip')
            ;;
        'tar')
            ;;
        'gz')
            ;;
        '*')
            ;;
    esac
}

_main $1
