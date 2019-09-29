select-tmux-session () {
    session=$(tmux ls | peco | cut -d: -f 1)
    if [ -n "$session" ] ; then
        tmux at -t "$session"
    fi
}


if [ -z "$TMUX" ] ; then
    if [ $(tmux ls | wc -l) -eq 0 ] ; then
        tmux
    elif [ $(tmux ls | wc -l) -eq 1 ] ; then
        tmux at -t $(tmux ls | cut -d: -f 1)
    else
        select-tmux-session
    fi
fi

autoload -Uz compinit
compinit
