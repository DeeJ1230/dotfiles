export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="powerlevel9k/powerlevel9k"
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=true
export ZSH_TMUX_AUTOCONNECT=false

# customize PowerLevel9K appearence
export POWERLEVEL9K_MODE='nerdfont-complete'
# custom_ssh_list section
zsh_ssh_list () {
  ssh-add -L | grep -v "has no identities" | awk "{print $3}" | grep -v $USER@$HOST | xargs -rn 1 -I {} basename {} | sort -u | paste -sd "|" -
}
export POWERLEVEL9K_CUSTOM_SSH_LIST="zsh_ssh_list"
export POWERLEVEL9K_CUSTOM_SSH_LIST_BACKGROUND="089"
export POWERLEVEL9K_CUSTOM_SSH_LIST_FOREGROUND="195"
# custom_kube_config section
zsh_kube_config () {
  if [ ! -z "$KUBECONFIG" ]; then
    echo -n "$(basename $KUBECONFIG)"
  fi
}
export POWERLEVEL9K_CUSTOM_KUBE_CONFIG="zsh_kube_config"
export POWERLEVEL9K_CUSTOM_KUBE_CONFIG_BACKGROUND="089"
export POWERLEVEL9K_CUSTOM_KUBE_CONFIG_FOREGROUND="195"
export POWERLEVEL9K_CONTEXT_BACKGROUND="089"
export POWERLEVEL9K_CONTEXT_FOREGROUND="195"
export POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
export POWERLEVEL9K_SHORTEN_DELIMITER=" \u2026"
export POWERLEVEL9K_SHORTEN_STRATEGY="truncate_folders"
export POWERLEVEL9K_STATUS_VERBOSE=false
export POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
export POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
export POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
export POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
export POWERLEVEL9K_TIME_BACKGROUND="black"
export POWERLEVEL9K_TIME_FOREGROUND="249"
export POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon custom_kube_config dir_writable dir vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time custom_ssh_list disk_usage load battery)
export POWERLEVEL9K_SHOW_CHANGESET=true
export POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{088}╭─"
export POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{088}\u2570%F{088}\uF460%F{124}\uF460%F{160}\uF460%f "
export POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export HIST_STAMPS="yyyy-mm-dd"

setopt extendedhistory
plugins=(git git-extras colored-man-pages docker github tmux taskwarrior)

source $ZSH/oh-my-zsh.sh
source $HOME/.bashrc

which kubectl 2>&1 > /dev/null
if [ "$?" -eq "0" ]; then
  source <(kubectl completion zsh)
  alias k=kubectl
  alias ks='kubectl -n kube-system'
fi

eval "$(direnv hook zsh)"
