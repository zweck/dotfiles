
# Git bash prompt stuff
source ~/.bash-git-prompt/gitprompt.sh
GIT_PROMPT_ONLY_IN_REPO=1

GIT_PROMPT_THEME=Minimal

# Source bash git completion
if [ -f ~/.tools/.git-completion.bash ]; then
  . ~/.tools/.git-completion.bash
fi

# load the bashrd
source ~/.bashrc

# source mysql
export PATH=/usr/local/mysql/bin:$PATH

# vscode
code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}


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

alias cdgit='cd $(git rev-parse --show-toplevel)'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH=~/.tools:$PATH
export PATH=~/bin/mongo:$PATH
export PATH=~/bin:$PATH
export PATH=/Users/pjhauser/n/bin:$PATH
# source gems
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

export ANDROID_HOME=/usr/local/opt/android-sdk

# massive bash history
HISTFILESIZE=10000

##
# Your previous /Users/pjhauser/.bash_profile file was backed up as /Users/pjhauser/.bash_profile.macports-saved_2017-07-24_at_19:30:26
##

# MacPorts Installer addition on 2017-07-24_at_19:30:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export TERM=xterm-256color
export PATH="$HOME/.cargo/bin:$PATH"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
