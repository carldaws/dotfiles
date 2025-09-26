if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR_PATH="$1"
SESSION_NAME=$(basename "$DIR_PATH")

if [ ! -d "$DIR_PATH" ]; then
    echo "Error: Directory '$DIR_PATH' does no exist"
    exit 1
fi

tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? != 0 ]; then
    echo "Creating new tmux session: $SESSION_NAME"
    tmux new-session -d -s "$SESSION_NAME" -n "" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME" "nvim ." Enter
    tmux new-window -t "$SESSION_NAME" -n "󰾔" -c "$DIR_PATH"
    tmux new-window -t "$SESSION_NAME" -n "" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:" "rails console" Enter
    tmux split-window -v -t "$SESSION_NAME:" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:" "rails dbconsole" Enter
    tmux new-window -t "$SESSION_NAME" -n "" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:" "lazygit" Enter
    tmux new-window -t "$SESSION_NAME" -n "󰡨" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:󰡨" "lazydocker" Enter
    tmux new-window -t "$SESSION_NAME" -n "" -c "$DIR_PATH"
    tmux select-window -t "$SESSION_NAME:"
fi

echo "Attaching to tmux session: $SESSION_NAME"
tmux attach-session -t "$SESSION_NAME"
