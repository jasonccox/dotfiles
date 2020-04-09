# cdnvm.bash
# Switch to correct node version when changing directories. Comes from
# https://dev.to/d4nyll/automatic-nvm-use-34ol with minor modifications detailed
# below.

# CHANGES
#
# - echo "Changing node version..." before switching so user knows why cd is
#   being slow
# - use builtin cd to prevent issues if cd is already aliased to cdnvm when this
#   is sourced
# - make cdnvm noticeably faster by making find-up() stop at home directory

# search for a file in current directory and its ancestors
find-up () {
    path=$(pwd)
    while [[ "$path" != "" && "$path" != "$HOME" && ! -e "$path/$1" ]]; do
        path=${path%/*}
    done
    echo "$path"
}

# run cd with arguments and switch node version (using nvm) as applicable
cdnvm(){
    builtin cd $@;
    nvm_path=$(find-up .nvmrc | tr -d '[:space:]')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            echo Changing node version...
            nvm use default;
        fi

    elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then

        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        # Add the `v` suffix if it does not exists in the .nvmrc file
        if [[ $nvm_version != v* ]]; then
            nvm_version="v""$nvm_version"
        fi

        # If it is not already installed, install it
        if [[ $(nvm ls "$nvm_version" | tr -d '[:space:]') == "N/A" ]]; then
            nvm install "$nvm_version";
        fi

        if [[ $(nvm current) != "$nvm_version" ]]; then
            echo Changing node version...
            nvm use "$nvm_version";
        fi
    fi
}

