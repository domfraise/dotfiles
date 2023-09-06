# Shortcuts


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
export JIRA_API_TOKEN=h404b1OCwzvWpMRDUVPu680F
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

eval $(thefuck --alias)


alias prt="cat ~/pr-template.txt | pbcopy"
alias ss="prt && gt ss"

