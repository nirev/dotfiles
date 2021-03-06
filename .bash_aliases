
# tv series helper :D
function legendas {
  for i in *.rar; do unrar x -y $i; rm $i; done
}
alias lowercaseEverything='for f in *; do mv "$f" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done'

# tar aliases
alias tarx='tar -xvzf'
alias tarc='tar -cvzf'

# ls aliases
alias ls='ls --color'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -la'

alias cgrep='grep --color'

alias howmuch="du -h --max-depth=1"

alias rehash="source ~/.bash_profile"

alias screenturnoff="sleep 2; xset dpms force off"

alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."

alias 2clip="xclip -in -selection clipboard"
alias fromclip="xclip -out -selection clipboard"


# NINFA
alias phoenixnow="ssh -X -Y gmnogueira@phoenix.inf.ufes.br"
alias ninfaproxy="ssh -D 4099 -Nf gmnogueira@phoenix.inf.ufes.br"
alias ufesproxy="ssh -D 4099 -Nf gmnogueira@di.inf.ufes.br"

alias gopy="source ~/.pyenv/bin/activate"

function telnyx_git {
  GITHUB_USER=team-telnyx GITHUB_USER_TYPE=orgs CODE_DIR=~/work/telnyx gitmulticast.sh $@
}

function asdf-update {
  asdf update && asdf plugin-update --all
}
