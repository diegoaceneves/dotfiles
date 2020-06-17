#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# .vimrc - Vim/GVim Configuration File
# Diego Neves - https://github.com/diegoaceneves/dotfiles
#
# "THE BEER-WARE LICENSE" (Revision 42):
# <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.git/git-prompt.sh ] ; then
    . ~/.git/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
fi

export PS1='[\T]\n[\u@\h \W]$(__git_ps1 " (%s)")\$ '
#export PS1="\T\n[\u@\h \W]\\$\[$(tput sgr0)\]"

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH=$PATH:/usr/local/go/bin
