#!/usr/bin/sh

if [ "$1" = "--debug" ]; then
    export DEBUG_MODE=1
    shift
fi

# PS4 ダブルクォートで囲ってしまうと実行時に変数が展開されてしまう。
if [ -n "${DEBUG_MODE}" ]; then
    export PS4='+ [${BASH_SOURCE##*/} : ${LINENO}] '
    set -x
fi

# variables
VERSION=0.0.1
HELP=" usage : ./setup.sh [OPTION] "

# functions

function update() {
    git pull origin master
}

function sync() {
    for file in {_vimrc,_gvimrc,.bash_profile,.bashrc,.bash_prompt,.bash_aliases,.bash_functions}; do
        cp -f ~/.dotfiles_for_win/${file} ~
    done
}

function setup_vim() {
    if [ ! -d ~/.vim/bundle ]; then
        mkdir -p ~/.vim/bundle
        git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    fi
}


# main

#subcommand="${1:---help}"
#case "$subcommand" in
#"-h" | "--help")
#    echo -e "$VERSION\n$HELP" >&2
#    exit 0
#    ;;
#"-v" | "--version")
#    echo -e "$VERSION" >&2
#    exit 0
#    ;;
#*)
#    command_path="$(command -v "$tool-$subcommand" || true)"
#    if [ -z "$command_path" ]; then
#        echo "sample: no such command $subcommand" >&2
#        exit 1
#    fi
#    shift 1
#    exec "$command_path" ${SERVER} ${PORT} ${CERT_PATH} ${KEY_PATH}
#    ;;
#esac

update
sync
setup_vim
