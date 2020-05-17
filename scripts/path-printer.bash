#!/bin/bash
#
# path-printer - Print a path with a maximum length.
# Author: Jason Cox (dev@jasoncarloscox.com)

EXEC_NAME="$0"
SHORTENER=…
MAX_LENGTH=30

usage() {
    echo \
"path-printer - Print a path with a maximum length.

USAGE

$EXEC_NAME [OPTIONS] [PATH]

If no PATH is given, it is assumed to be the current directory.

OPTIONS

-h | --help
    Print this help message.

-l | --length LENGTH
    Set the maximum length to LENGTH. Default $MAX_LENGTH.

-s | --shortener SHORTENER
    Set the shortener to SHORTENER. This will be used to indicate that the path
    was shortened. Default '$SHORTENER'."
}

# parse options
while [ -n "$1" ]; do
    case "$1" in
        -h|--help)
            usage
            exit 1
            ;;
        -l|--length)
            shift
            MAX_LENGTH="$1"
            ;;
        -s|--shortener)
            shift
            SHORTENER="$1"
            ;;
        *)
            path="$1"
            break
            ;;
    esac

    shift
done

# use current directory as path if none given
if [ -z "$path" ]; then
    path="$(pwd)"
fi

# use ~ as abbreviation for $HOME
if [[ "$path" == "$HOME"* ]]; then
    path="~${path#$HOME}"
fi

# shorten path if needed
if [ ${#path} -gt $MAX_LENGTH ]; then

    # identify the part of the path that should go before $SHORTENER, and the
    # length of the part that should go after
    case "$path" in
        /*)
            prefix=/
            suffix_length=$(($MAX_LENGTH - 1))
            ;;
        '~/'*)
            prefix='~/'
            suffix_length=$(($MAX_LENGTH - 2))
            ;;
        *)
            # no prefix
            suffix_length=$MAX_LENGTH
            ;;
    esac

    # adjust suffix length to account for shortener
    suffix_length=$(($suffix_length - ${#SHORTENER}))

    # get path without $prefix - what should go after $SHORTENER
    path="${path#$prefix}"

    # combine $prefix, $SHORTENER, and shortened end of path
    path="$prefix$SHORTENER${path: -$suffix_length}"
fi

# print the final path
echo -n "$path"

