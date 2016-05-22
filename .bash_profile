############################
# Aliases
############################

source ~/.bash_aliases



############################
# Colored output
############################

# directories
#eval `dircolors -b`

# grep output
export GREP_COLOR="1;33"
alias colorgrep="grep --color -Tn"

# man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

############################
# PS1
############################
# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

function pre_prompt {
	newPWD="${PWD}"
	user="whoami"
	host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
	datenow=$(date "+%a, %d %b %y")
	#let promptsize=$(echo -n "--($user@$host ddd, DD mmm YYYY)---(${PWD})---" | wc -c | tr -d " ")
        let promptsize=$(echo -n "--(xx:dd)---(${PWD})---" | wc -c | tr -d " ")
	let fillsize=${COLUMNS}-${promptsize}
	fill=""
	while [ "$fillsize" -gt "0" ] 
	do 
		fill="${fill}─"
		let fillsize=${fillsize}-1
	done
	if [ "$fillsize" -lt "0" ]
	then
		let cutt=3-${fillsize}
		newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
	fi
}

PROMPT_COMMAND=pre_prompt
# export black="\[\033[0;38;5;0m\]"
# export green="\[\033[0;38;5;2m\]"
# export blue="\[\033[0;38;5;4m\]"
# export magenta="\[\033[0;38;5;55m\]"
# export cyan="\[\033[0;38;5;6m\]"
export smoothblue="\[\033[0;38;5;111m\]"
# export iceblue="\[\033[0;38;5;45m\]"
# export turqoise="\[\033[0;38;5;50m\]"

export red="\[\e[0;31m\]"
# export coldblue="\[\e[1;34m\]"
export yellow="\[\e[0;33m\]"
export white="\[\e[0;37m\]"
export smoothgreen="\[\e[0;32m\]"
export darkgrey="\[\e[1;30m\]"
export lightgrey="\[\e[0;37m\]"


function git_branch_name() {
   git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1) /'
}

#PS1="${darkgrey}┌─(${coldblue}\$newPWD${darkgrey})─\${fill}─($red\$(date \"+%H:%M\")\
#${darkgrey})───┐\n${darkgrey}└─(${smoothgreen}\u${lightgrey}@${smoothgreen}\h ${red}\$(git_branch_name)${yellow}\$${darkgrey})─>$white "

PS1="${darkgrey}┌─($red\$(date \"+%H:%M\")${darkgrey})─(${smoothblue}\$newPWD${darkgrey})\
\n${darkgrey}└─(${smoothgreen}\u${lightgrey}@${smoothgreen}\h ${red}\$(git_branch_name)${yellow}\$${darkgrey})─>$white "


############################
# Functions
############################

unpacksubtitles () {
  find . -iname "*zip" -exec unzip -o {} \;
  find . -iname "*rar" -exec unrar x -y {} \;
}

#netinfo - shows network information for your system
netinfo () {
	echo "————— Network Information —————"
	/sbin/ifconfig | awk /’inet addr/ {print $2}’
	/sbin/ifconfig | awk /’Bcast/ {print $3}’
	# /sbin/ifconfig | awk /’inet addr/ {print $4}’
	/sbin/ifconfig | awk /’HWaddr/ {print $4,$5}’
	myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
	echo
	echo "${myip}"
	echo "—————————————————"
}

#Translate a Word - USAGE: translate house
translate () {
	TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "Portuguese (Brazil):" | sed 's/^[ \t]*//;s/[ \t]*$//'`
	if [[ ${#TRANSLATED} != 0 ]] ;then
	echo "\"${1}\" in ${TRANSLATED}"
	else
	echo "Sorry, I can not translate \"${1}\" to Portuguese (Brazil)"
	fi
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


############################
# Misc
############################

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
# source /media/data/home/nirev/bin/funcoeszz
# export ZZPATH=/media/data/home/nirev/bin/funcoeszz

# para o octave
#export GDFONTPATH=/usr/share/fonts/TTF/    

# para o open office
#export SAL_GTK_USE_PIXMAPPAINT=1

export EDITOR=vim
export GIT_AUTHOR_EMAIL=guilherme@nirev.org
export GIT_AUTHOR_NAME='nirev'
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME

#export WINEARCH=win32
#export FRASCATI_HOME=/home/nirev/apps/frascati-runtime-1.4

# chruby: changes rubies
# auto: switch ruby version when "cd"ing to a dir containing a .ruby-version file
#source /usr/share/chruby/chruby.sh
#source /usr/share/chruby/auto.sh

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    source ~/.bash_profile_osx
fi

# configure GO
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source $(brew --prefix)/etc/bash_completion;
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

export PATH="$PATH:~/bin"

alias recreate-phoenix-db="mix ecto.drop && mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs && mix run priv/repo/seeds/cities.exs && mix run priv/repo/seeds/cbos.exs && mix run priv/repo/seeds/banks.exs"
