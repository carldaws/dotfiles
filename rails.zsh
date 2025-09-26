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
    tmux new-session -d -s "$SESSION_NAME" -n "Editor" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME" "nvim ." Enter
    tmux new-window -t "$SESSION_NAME" -n "Server" -c "$DIR_PATH"
    tmux new-window -t "$SESSION_NAME" -n "Console" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:Console" "rails console" Enter
    tmux split-window -v -t "$SESSION_NAME:Console" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:Console" "rails dbconsole" Enter
    tmux new-window -t "$SESSION_NAME" -n "Git" -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:Git" "lazygit" Enter
    tmux new-window -t "$SESSION_NAME" -n "Terminal" -c "$DIR_PATH"
    tmux select-window -t "$SESSION_NAME:Editor"
fi

echo "Attaching to tmux session: $SESSION_NAME"
tmux attach-session -t "$SESSION_NAME"
