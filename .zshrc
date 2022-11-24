# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
plugins+=(zsh-vi-mode)

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="archcraft"

ZSH_THEME="agnoster" # spaceship

# TERM="xterm"
# ZSH_THEME="agnoster"
prompt_context() {}

export PATH="$HOME/.local/bin:$PATH"

# setting the local lang and etc...
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="archcraft"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# On-demand rehash
zshcache_time="$(date +%s%N)"


autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# omz
alias zshconfig="geany ~/.zshrc"
alias ohmyzsh="thunar ~/.oh-my-zsh"

# ls
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
alias lm='ls -m'
alias lr='ls -R'
alias lg='ls -l --group-directories-first'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
# alias gp='git push origin master'
alias gp='git push -u'
alias gpat='cat /opt/deets.txt | xclip -sel clip'

# alias tmux='tmux -u'

alias py='python'
alias js='node'
alias nv='nvim'
alias ra='ranger'
alias srst='source ~/.zshrc; reset'
alias rst='reset'
alias vi='vim'
alias szsh='clear; source ~/.zshrc'

alias todo='bat ~/Desktop/todo.txt'
alias toed='nvim ~/Desktop/todo.txt'
alias tolast='tail -n 1 ~/Desktop/todo.txt'
alias toadd='cat >> ~/Desktop/todo.txt'

toad() {
echo $1 >> ~/Desktop/todo.txt
}

torem() {
    sed $1d ~/Desktop/todo.txt > ~/Desktop/todo.txt
}

toremnum() {

    if [[ $# -gt 1 ]]; then

        for i in $@; do
            torem $i
        done

    elif [[ $# -eq 1 ]]; then
        torem $1

    else
        echo "No line to be removed is given"
    fi
}

tocheck() {
    python3 ~/Desktop/line_checker.py $1
}


tomod() {
    # function to modify the last several edits.
}

bcom() {
    cat ~/.zsh_history | grep $1
}

bcnum() {
    cat ~/.zsh_history | grep $1 | tail -n $2
}

gadd() {
    git add "$1" && git commit -m "$2" -m "$3"
}

set completion-ignore-case oN

contains(){
    for file in $1;
        if [ $file -eq $2 ]; then
            echo 1
            break
        else
            echo 0
        fi
}


gadp() {

    if [[ -f $1 ]]; then

        ext=`ls $1 | rev | cut -d "." -f 1 | rev`


        if [[ "$ext" == "py" ]]; then

            pylint_val=`pylint $1 | grep "rated" | cut -d "." -f 1 | grep -o '[0-9]*'`

            if [[ $pylint_val -lt 10 ]]; then
                echo "Failed to push python code, has a pylint score of $pylint_val "

                echo "Here are your mistakes"
                echo
                pylint $1 | rev | grep ":" | rev
                echo
            else
                git add "$1" && git commit -m "$2" -m "$3" && git push
            fi
        else 
            git add "$1" && git commit -m "$2" -m "$3" && git push
        fi

    # elif [[ -d $1 ]]; then
    #
    #     for file in $exts; do
    #
    #         ext=`ls $file | rev | cut -d "." -f 1 | rev`
    #
    #
    #         if [[ "$ext" == "py" ]]; then
    #
    #             pylint_val=`pylint $file | grep "rated" | cut -d "." -f 1 | grep -o '[0-9]*'`
    #
    #             if [[ $pylint_val -lt 10 ]]; then
    #                 echo "Failed to push python code, has a pylint score of $pylint_val "
    #
    #                 echo "Here are your mistakes"
    #                 echo
    #                 pylint $1 | rev | grep ":" | rev | grep -v "d"
    #                 echo
    #             fi
    #
    #         fi
    #
    #     done
    #
    # else
    #
    #     echo "Argument provided is neither a file here or a directory, fix it!"
    #
    fi
    #
    
}

fumbo(){
    if [[ -d $1 ]]; then

        for file in `ls $1`; do

            ext=`ls $file | rev | cut -d "." -f 1 | rev`

            if [ "$ext" == "py" ]; then

                pylint_val=`pylint $file | grep "rated" | cut -d "." -f 1 | grep -o '[0-9]*'`

                if [ $pylint_val -lt 10 ]; then
                    echo "$file has a rating of $pylint_val, fix it!"
                    break
                fi
            else
                git add "$1" && git commit -m "$2" -m "$3" && git push
            fi
        done;

    fi

}

alias gdog='git log --all --decorate --oneline --graph'

alias pacman='sudo pacman -S'
alias pacsearch='sudo pacman -Ss'
alias pacmany='sudo pacman -Sy'
alias update='sudo pacman -Syu'
alias updatey='sudo pacman -Syyu'
alias pacrem='sudo pacman -Rcns'

alias ssn='shutdown now'
alias ex='exit'
alias walqi='wal -qi'


# Toggle led aliases
alias ledon='xset led named "Scroll Lock"'
alias ledoff='xset -led named "Scroll Lock"'

mkcd() {
    test -d $1 || mkdir $1 && cd $1
}

mknew() {
    mkdir -p $1 && cd $1
}

alias stima='echo "$(date) $1 units\n" >> ~/Desktop/stima.txt'


alias vz='vim ~/.zshrc; source ~/.zshrc'
alias nz='nvim ~/.zshrc; clear; source ~/.zshrc'

alias strun='streamlit run'

alias mydb='mysql -A -u root -p'




mkpasswd() {
    mkpasswd-expect -l $1 | xclip -sel clip
}

nofap() {
    number=`tail -n 1 ~/nofap/edits.txt | cut -d " " -f2`
    nofap_count=`expr $number + 1`
    date=`date`
 
    file=~/nofap/edits.txt
    echo -e "day $nofap_count of nofap -> `date`" >> $file
}


# Directory aliases
alias cde='cd ~/Desktop/'
alias cdo='cd ~/Downloads/'
alias cpi='cd ~/Pictures/'
alias cvi='cd ~/Videos/'
alias cte='cd ~/Templates/'
alias cge='cd ~/gengetone/'

alias ebs='cd ~/ebooks/'

alias cdoc='cd ~/Documents/'
alias conf='cd ~/.config/'
alias walp='cd ~/Pictures/wallpapers/'

alias neovim='cd ~/.config/nvim/'

(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

alias grun='go run'
alias server='python -m http.server'
alias pserver='php -S localhost:8000 -t .'
alias pword='git config credential.helper store'
alias lg='lazygit'
alias vi='vim'

alias pycal='python3 -m calendar 2022 '

motivate

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

zvm_config

eval $(thefuck --alias)
