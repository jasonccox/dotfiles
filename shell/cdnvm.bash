# cdnvm.bash - Switch to correct node version when changing directories.

cdnvm() {
    builtin cd "$@"
    nvm use --silent
}
