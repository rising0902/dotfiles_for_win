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
ABSOLUTE_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
echo $ABSOLUTE_PATH

# functions

function update() {
    git pull origin master
}

function sync() {
    for file in {_vimrc,_gvimrc,.bash_profile,.bashrc,.bash_prompt,.bash_aliases,.bash_functions,.gitconfig}; do
        cp -f ~/.dotfiles_for_win/${file} ~
    done
}

function sync_cygwin() {
    mkdir /c/cygwin64/home/${USERNAME}/backup
    for file in {.bash_profile,.bashrc,.profile}; do
        mv -n /c/cygwin64/home/${USERNAME}/${file} /c/cygwin64/home/${USERNAME}/backup
    done
    for file in {.bash_profile,.bashrc,.bash_prompt,.bash_aliases,.bash_functions,.gitconfig,.minttyrc}; do
        cp -f ~/.dotfiles_for_win/${file} /c/cygwin64/home/${USERNAME}/
    done
    if [ ! -d /c/cygwin64/home/${USERNAME}/.vim/bundle ]; then
        mkdir -p ~/.vim/bundle
        git clone https://github.com/Shougo/neobundle.vim /c/cygwin64/home/${USERNAME}/.vim/bundle/neobundle.vim
    fi
    mkdir /c/cygwin64/home/${USERNAME}/bin
    cd /c/cygwin64/home/${USERNAME}/bin
    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o git-prompt.sh
		cat ${ABSOLUTE_PATH}/.bashrc | sed '1i\
source ~/bin/git-prompt.sh' > /c/cygwin64/home/${USERNAME}/.bashrc
    cp ${ABSOLUTE_PATH}/_vimrc /c/cygwin64/home/${USERNAME}/.vimrc
    mkdir /c/cygwin64/usr/local/src
    cd /c/cygwin64/usr/local/src
    git clone https://github.com/kou1okada/apt-cyg.git
    ln -s /c/cygwin64/usr/local/src/apt-cyg/apt-cyg /c/cygwin64/usr/local/bin/
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
sync_cygwin
setup_vim
