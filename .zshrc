# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/Dominic.Fraise/.oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

#plugins=(git zsh-syntax-highlighting zsh-autosuggestions autojump)

source $ZSH/oh-my-zsh.sh

export EDITOR=vim


###################################################


# #TODOIST
# todoist sync
# alias td="todoist --color"
# alias tdl="td sync && td list"
# alias tda="td add"
#
#bash replacements
alias less="bat"
alias ls="lsd"

#git

alias gs="git stash"
alias gsp="git stash pop"
alias gp="git pull"
alias gc="git checkout"
alias gcb="git checkout -b"

main_branch (){
  branch=$(git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4)
  echo $branch
}

smp (){
  git stash
  git checkout $(main_branch)
  git pull
}

smpp (){
  smp
  git stash pop
}

gmm (){
  git checkout $(main_branch)
  git pull
  git checkout master
  git checkout -
  git merge $(main_branch)
}

alias nb="smp && gcb"
alias nba="smap && gcb"

#github cli
get_ticket (){
  t=$(git rev-parse --abbrev-ref HEAD | tr "-" " " | awk '{print "["$1 "-" $2"]" }')
  echo $t
}

get_title (){
  title=$(git rev-parse --abbrev-ref HEAD | cut -d "-" -f 3- | tr "-" " ")
  echo $title
}
get_pr_title (){
  echo "$(get_ticket) $(get_title)"
}
get_current_branch (){
  echo $(git rev-parse --abbrev-ref HEAD)
}
get_pr_body (){
  commits="$(git log --pretty=format:%s --reverse origin/$(main_branch)..$(get_current_branch) | tr '\n' '\v') "
  cat ~/pr-template.txt | sed "s/CONTEXT/$commits/" | tr '\v' '\n'

}

create_pr() {
  get_pr_body > ~/pr-filled.txt
  gh pr create --title "$(get_pr_title)" --body-file ~/pr-filled.txt  --web
}
alias pr="create_pr"

#jira cli
export JIRA_API_TOKEN=
alias ticket='jira issue list -s"In Progress" -a"Dominic Fraise" -t~"Epic" --columns key,summary --no-headers --plain'
alias tick='ticket | tee /dev/tty | tr "\t" " "|cut -d " " -f1 | pbcopy'

#daily summary
alias sup="/Users/Dominic.Fraise/dev/apps/daily-summary/summary.sh"
alias ghs="cd /Users/Dominic.Fraise/dev/apps/daily-summary/ && pipenv run python /Users/Dominic.Fraise/dev/apps/daily-summary/github-summary.py && cd -"

export PATH="$PATH":"$HOME/dev/apps/"
##Firebase Flutter fire (souschef)
export PATH="$PATH":"$HOME/.pub-cache/bin"
export FLUTTER_ROOT="/usr/local/Caskroom/flutter/2.5.3/"
#
# IDEA Scripts
export PATH="$PATH":"$HOME/dev/scripts/idea"

alias ideao="idea ./"

alias prt="cat ~/pr-template.txt | pbcopy"
alias ss="prt && gt ss"


#trivvy
#export GITHUB_TOKEN=

# yubikey ssh
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null

#go
export PATH="$PATH":"$HOME/go/bin"

#onepassword
#alias opl="eval $(op signin)"
#alias okta="op item get okta --fields label=password | pbcopy"
#source <(op completion bash)
##################################################

## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/Dominic.Fraise/.sdkman"
[[ -s "/Users/Dominic.Fraise/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/Dominic.Fraise/.sdkman/bin/sdkman-init.sh"

