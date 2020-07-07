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

# Configure Bash History
shopt -s direxpand histappend
HISTCONTROL='ignoreboth'
HISTTIMEFORMAT="[%F %T] "
HISTSIZE=-1
HISTFILESIZE=-1

## Set Color
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

if [[ "${USER}" == "root" ]]; then
	userStyle="${orange}";
else
	userStyle="${blue}";
fi;

if [[ "${SSH_TTY}" ]]; then
	hostStyle="${cyan}";
else
	hostStyle="${reset}${cyan}";
fi;

prompt_git() {
	local s='';
	local branchName='';
	git rev-parse --is-inside-work-tree &>/dev/null || return;
	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git describe --all --exact-match HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";
	repoUrl="$(git config --get remote.origin.url)";
	if grep -q 'chromium/src.git' <<< "${repoUrl}"; then
		s+='*';
	else
		if ! $(git diff --quiet --ignore-submodules --cached); then
			s+='+';
		fi;
		if ! $(git diff-files --quiet --ignore-submodules --); then
			s+='!';
		fi;
		if [ -n "$(git ls-files --others --exclude-standard)" ]; then
			s+='?';
		fi;
		if $(git rev-parse --verify refs/stash &>/dev/null); then
			s+='$';
		fi;
	fi;
	[ -n "${s}" ] && s=" [${s}]";
	echo -e "${1}${branchName}${2}${s}";
}

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if [[ -d /usr/local/go/bin ]]; then
	PATH=$PATH:/usr/local/go/bin
fi

if [[ -f /usr/bin/kubectl ]]; then
	alias k="kubectl"
fi

PS1='${bold}[${green}\T${reset}] '
PS1+='[${bold}${userStyle}\u${purple}@${hostStyle}\h ${bold}${green}\W${reset}] '
PS1+='$(prompt_git \[${purple}\] \[\]\[${blue}\])${bold}${red} +${reset}\n\$ '

#AWS
if [[ -f '/usr/local/aws/bin/aws_completer' ]]; then
	complete -C '/usr/local/aws/bin/aws_completer' aws 
fi

export PS1
export PATH
