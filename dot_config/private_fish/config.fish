#---------------------------------------------------------------------------
# vim: ts=2 sw=2 et ft=fish
#---------------------------------------------------------------------------

# Git aliases
alias ga="git add"
alias gap="git add -p"
alias gb="git branch"
alias gci="git commit --signoff"
alias gcia="git commit --amend"
alias gcias="git commit --amend --signoff --no-edit"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gl="git pull"
alias glp="git pull --prune"
alias gn="git switch -c"
alias gp="git push"
alias gpfyrchik='git push -u fyrchik (git branch --show-current)'
alias gpf="git push --force"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase -i"
alias grs="git reset"
alias gs="git status"
alias gss="git status --short"
alias gsw="git switch"
alias gsa="git stash"
alias gsu="git submodule update"

# Don't break everything
alias sudo=doas

# Set convenient defaults
alias ip="ip --color=auto"
alias yay="yay --color=auto"
alias v=nvim
alias s=sudo

# Use nvim for viewing MAN pages
setenv MANPAGER "nvim -c 'set nomodifiable' +Man!"
setenv EDITOR nvim

setenv SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
setenv DOCKER_HOST "unix:///var/run/docker.sock"

# Golang settings
setenv GOPROXY direct

# Make less more powerfull
setenv LESSOPEN "|/usr/bin/lesspipe.sh %s"

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"
