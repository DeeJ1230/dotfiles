NEWLINE=$'\n'
PROMPT='%m %{${fg_bold[blue]}%}<$(ssh-add -L | grep -v "has no identities" | awk "{print $3}" | grep -v $USER@$HOST | xargs -rn 1 -I {} basename {} | paste -sd "," -)> %{$reset_color%}%{${fg[magenta]}%}%3~ $(git_prompt_info)%{${fg_bold[red]}%}$(echo "$KUBECONFIG" | xargs -rn 1 -I {} basename {})${NEWLINE}»%{${reset_color}%} '
export PATH=~/.local/bin:$PATH
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND="find -type f -not -path '*.git/*' -not -path '*.stack-work/*' -not -path '.*.swp' -not -path '.*.swo' -printf '%P\n'"
[[ $- == *i* ]] && stty -ixon
