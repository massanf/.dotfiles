#!bin/bash
tmux new-session -d 'nvim'
tmux split-window -h
W=$(tmux display -p '#{window_width}')
L=$(expr $W \* 8 / 10)
tmux resizep -t{left} -x $L
tmux -2 attach-session -d
