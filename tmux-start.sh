#!/bin/bash
SESSION_NAME=default

# Check if session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION_NAME -n full
  tmux new-window -t $SESSION_NAME -n main
  tmux split-window -h -p 25 -t $SESSION_NAME:main
  tmux select-pane -t $SESSION_NAME:main.0
  tmux split-window -v -p 25 -t $SESSION_NAME:main
  tmux select-pane -t $SESSION_NAME:main.0
  tmux new-window -t $SESSION_NAME -n mc 'mc ~ ~/workspace/'
  tmux select-window -t $SESSION_NAME:1
fi

# Attach to the session
tmux attach-session -t $SESSION_NAME
