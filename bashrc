#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# .bashrc - Bash Configuration File
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

AWS=aws
STARTSHIP=starship

# Configure Bash History
shopt -s direxpand histappend
HISTCONTROL='ignoreboth'
HISTTIMEFORMAT="[%F %T] "
HISTSIZE=-1
HISTFILESIZE=-1

source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/docker 

which $AWS 2> /dev/null > /dev/null
if [[ $? == 0 ]]; then
	if [[ -f ~/.aws/credentials ]]; then
		aws_export_keys(){
			export AWS_ACCESS_KEY_ID=$(aws configure get $1.aws_access_key_id)
			export AWS_SECRET_ACCESS_KEY=$(aws configure get $1.aws_secret_access_key)
		}
		aws_list_profiles(){
			aws configure list-profiles
		}
	fi

fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi


if ! [[ "$PATH" =~ "/usr/local/go/bin" ]]; then
    if [[ -d /usr/local/go/bin ]]; then
    	PATH=$PATH:/usr/local/go/bin
    fi
fi   

if ! [[ "$PATH" =~ "$HOME/.linuxbrew/bin" ]]; then
	if [[ -d ~/.linuxbrew/bin ]]; then
		PATH=$PATH:~/.linuxbrew/bin
	fi
fi

export PATH

which $STARTSHIP 2> /dev/null > /dev/null
if [[ $? == 0 ]]; then
	eval "$(starship init bash)"
fi
