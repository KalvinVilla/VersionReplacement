#!/bin/bash

while getopts ":o:n:" opt; do
    case $opt in
        o) old_version="$OPTARG"
        ;;
        n) new_version="$OPTARG"
        ;;
        \?) echo "invalid option -$OPTARG" >&2
        exit 1
        ;;
    esac

    case $OPTARG in 
        -*) echo "Option $opt needs a valid argument"
        exit 1
        ;;
    esac
done

replace() {
    for filename in $1/*;do
        if [[ -f $filename ]]
        then
            $(sed -i -e "s/$old_version/$new_version/g" $filename)
        else
            replace $filename
        fi
    done
}

replace '.'