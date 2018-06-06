[[ -f ~/.bashrc ]] && . ~/.bashrc

# Git bash prompt stuff
source ~/.bash-git-prompt/gitprompt.sh
GIT_PROMPT_ONLY_IN_REPO=1

GIT_PROMPT_THEME=Minimal

# Source bash git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# load the bashrd
source ~/.bashrc

# source mysql
export PATH=/usr/local/mysql/bin:$PATH

clean_merged() {
    git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d
}

clean_before(){
    # Git lets you use very readable time formats!
    cutoff_time=$1
    # other examples:
    # cutoff_time="July 23, 2010"
    # cutoff_time="yesterday"

    git for-each-ref refs/heads --format='%(refname)' | egrep -v 'master|other-whitelisted-branch' |
    while read branch; do
        git reflog --expire="$cutoff_time" $branch
        if [ "$(git reflog show -1 $branch | wc -l)" -eq 0 ]; then
            git branch -D ${branch#refs/heads/}
        fi
    done
}

git_branch_list() {
    git for-each-ref --sort=committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)'
}

export PATH=~/.tools:$PATH
export PATH=~/bin/mongo:$PATH
export PATH=~/bin:$PATH
# source gems
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# massive bash history
HISTFILESIZE=10000

export PATH="$HOME/.cargo/bin:$PATH"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
