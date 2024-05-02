alias ls='ls -G'
alias grep='grep -i --color=auto'
alias gg='git grep'
alias gst='git status'
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/bin:$PATH"
export PS1="\h:\w$ "
export EDITOR=vim

HISTFILESIZE=100000000
HISTSIZE=100000
shopt -s histappend
PROMPT_COMMAND='history -a'

### Source osx bash setup
[[ -f ~/.bash_mac ]] && source ~/.bash_mac

### Source linux bash setup
[[ -f ~/.bash_linux ]] && source ~/.bash_linux

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="/Users/atom_j/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/opt/openssl/bin:$PATH"
