#!/bin/bash
#
# git-info - Print git status info in an ideal format for tmux or bash.
# Author: Jason Cox (dev@jasoncarloscox.com)

EXEC_NAME="$0"

PREFIX=''
AHEAD_FLAG='a'
BEHIND_FLAG='b'
MODIFIED_FLAG='m'
STAGED_FLAG='s'
STASHED_FLAG='t'
UNTRACKED_FLAG='u'
CLEAN_FLAG='c'
CLEAN_COLOR=''
DIRTY_COLOR=''
DEFAULT_COLOR=''

usage() {
    echo \
"git-info - Print git status info in an ideal format for tmux or bash.

USAGE

$EXEC_NAME [OPTIONS] [PATH]

Prints information about the git repository at PATH. If PATH is not provided,
the current directory will be used instead. If PATH is not in a git repository,
nothing will be printed.

The format of the status message is '<PREFIX><BRANCH> <FLAGS>'. If the git
repository is in a detached HEAD state, the abbreviated hash of the current
commit will replace BRANCH. FLAGS are printed in the following order, with no
separation: ahead, behind, clean, staged, modified, untracked, stashed.

The options below allow you to set the FLAG used to describe various aspects of
the git repository. If FLAG is blank for any of the options, that part of the
status will not even be calculated.

Setting 'gitinfo.basic' to 'true' in the repository's .gitconfig will disable
all flags, regardless of the options passed.

OPTIONS

-a | --ahead FLAG
    Print FLAG when the local git branch is ahead of its remote. Default '$AHEAD_FLAG'.

-b | --behind FLAG
    Print FLAG when the local git branch is behind its remote. Default '$BEHIND_FLAG'.

-c | --clean FLAG
    Print FLAG when the local git branch is clean (nothing modified, staged, or
    untracked). DEFAULT '$CLEAN_FLAG'.

--clean-color COLOR
    The color to use for the flags when the local git branch is clean (nothing
    modified, staged, or untracked). DEFAULT '$CLEAN_COLOR'.

--default-color COLOR
    The color to reset to after applying the clean or dirty color. DEFAULT
    '$DEFAULT_COLOR'.

--dirty-color COLOR
    The color to use for the flags when the local git branch is dirty (something
    modified, staged, or untracked). DEFAULT '$DIRTY_COLOR'.

-h | --help
    Print this help message.

-m | --modified FLAG
    Print FLAG when there are modified files in the git repository. Default '$MODIFIED_FLAG'.

-p | --prefix PREFIX
    Print PREFIX before the branch name. Default '$PREFIX'.

-s | --staged FLAG
    Print FLAG when there are staged files in the git repository. Default '$STAGED_FLAG'.

-t | --stashed FLAG
    Print FLAG when there are stashes in the git repository. Default '$STASHED_FLAG'.

-u | --untracked FLAG
    Print FLAG when there are untracked files in the git repository. Default
    '$UNTRACKED_FLAG'

NOTES

The default symbols look best with a monospaced nerd font. (See
https://www.nerdfonts.com/)"
}

flags() {
    # don't print anything if git config says not to
    [ "$(git config --bool gitinfo.basic)" = "true" ] && return

    # get status info that will be used to determine most flags
    local status="$(git status --porcelain=v2 --branch)"

    local clean
    if [ -n "$MODIFIED_FLAG" ] || [ -n "$CLEAN_FLAG" ]; then
        if grep -E '^[12.] .[^.]' <<< "$status" &> /dev/null; then
            local modified="$MODIFIED_FLAG"
            clean=no
        fi
    fi

    if [ -n "$UNTRACKED_FLAG" ] || [ -n "$CLEAN_FLAG" ]; then
        if grep -E '^\? ' <<< "$status" &> /dev/null; then
            local untracked="$UNTRACKED_FLAG"
            clean=no
        fi
    fi

    if [ -n "$STAGED_FLAG" ] || [ -n "$CLEAN_FLAG" ]; then
        if grep -E '^[12.] [^.].' <<< "$status" &> /dev/null; then
            local staged="$STAGED_FLAG"
            clean=no
        fi
    fi

    if [ -z "$clean" ]; then
        clean="$CLEAN_FLAG"
        color="$CLEAN_COLOR"
    else
        clean=""
        color="$DIRTY_COLOR"
    fi

    if [ -n "$AHEAD_FLAG" ] || [ -n "$BEHIND_FLAG" ]; then
        local ab_line="$(grep -E '^# branch\.ab' <<< "$status")"
        local ab="${ab_line#*+}" # everything after the plus sign

        if [ -n "$AHEAD_FLAG" ]; then
            local a="${ab%\ -*}"
            if [ "$a" -gt 0 ]; then
                ahead="$AHEAD_FLAG"
            fi
        fi

        if [ -n "$BEHIND_FLAG" ]; then
            local b="${ab#*-}"
            if [ "$b" -gt 0 ]; then
                behind="$BEHIND_FLAG"
            fi
        fi
    fi

    if [ -n "$STASHED_FLAG" ] && [ -n "$(git stash list)" ]; then
        local stashed="$STASHED_FLAG"
    fi

    f="$ahead$behind$clean$staged$modified$untracked$stashed"
    with_color="$color$f$DEFAULT_COLOR"

    if [ -n "$f" ]; then
        with_color=":$with_color"
    fi

    echo -n "$with_color"
}

# parse options
while [ -n "$1" ]; do
    case "$1" in
        -a|--ahead)
            shift
            AHEAD_FLAG="$1"
            ;;

        -b|--behind)
            shift
            BEHIND_FLAG="$1"
            ;;

        -c|--clean)
            shift
            CLEAN_FLAG="$1"
            ;;

        --clean-color)
            shift
            CLEAN_COLOR="$1"
            ;;

        --default-color)
            shift
            DEFAULT_COLOR="$1"
            ;;

        --dirty-color)
            shift
            DIRTY_COLOR="$1"
            ;;

        -h|--help)
            usage
            exit 1
            ;;

        -m|--modified)
            shift
            MODIFIED_FLAG="$1"
            ;;

        -p|--prefix)
            shift
            PREFIX="$1"
            ;;

        -s|--staged)
            shift
            STAGED_FLAG="$1"
            ;;

        -t|--stashed)
            shift
            STASHED_FLAG="$1"
            ;;

        -u|--untracked)
            shift
            UNTRACKED_FLAG="$1"
            ;;

        *)
            path="$1"
            break
            ;;
    esac

    shift
done

# cd to $path if given
if [ -n "$path" ]; then
    cd "$path"
fi

# get branch (or hash)
ref="$(git branch --show-current 2> /dev/null)"
if [ "$?" -ne 0 ]; then
    # this isn't a git repo - exit
    exit
fi
if [ -z "$ref" ]; then
    # not on a branch head - get the hash of the current commit instead
    ref="$(git rev-parse --short HEAD)"
fi

# get flags
flags="$(flags)"

# print it all
echo -n "$PREFIX$ref$flags"

