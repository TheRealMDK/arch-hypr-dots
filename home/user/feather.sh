#!/bin/bash

SESSION="music"

# Kill existing session if it exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux kill-session -t "$SESSION"
fi

# Create new detached session
tmux new-session -d -s "$SESSION"

# Allow tmux to start up
sleep 0.3

# Split the window vertically (top and bottom)
tmux split-window -v -t "$SESSION"

sleep 0.3

# Focus on the bottom pane after setup
tmux select-pane -t "$BOTTOM_LEFT_PANE"

sleep 0.3

# Split the window horizontally (left and right)
tmux split-window -h -t "$SESSION"

sleep 0.3

# Get all updated pane IDs
PANE_IDS=($(tmux list-panes -t "$SESSION" -F "#{pane_id}"))
TOP_PANE="${PANE_IDS[0]}"
BOTTOM_LEFT_PANE="${PANE_IDS[1]}"
BOTTOM_RIGHT_PANE="${PANE_IDS[2]}"

# Calculate 80% of the current terminal height
# Get total lines (height) of the tmux window
TOTAL_HEIGHT=$(tmux display-message -p -t "$SESSION" "#{window_height}")
TOP_HEIGHT=$(((TOTAL_HEIGHT * 80) / 100))

# Resize the top pane to 80% height
tmux resize-pane -t "$TOP_PANE" -y "$TOP_HEIGHT"

sleep 0.3

# Run 'cava' in the bottom pane
tmux send-keys -t "$BOTTOM_LEFT_PANE" 'cava' C-m

sleep 0.3

# Run 'pulsemixer' in the bottom right pane
tmux send-keys -t "$BOTTOM_RIGHT_PANE" 'pulsemixer' C-m

sleep 0.3

# Ensure top pane is focused after setup
tmux select-pane -t "$TOP_PANE"

sleep 0.3

# Run 'feather' in the top pane
tmux send-keys -t "$TOP_PANE" '/home/clinton/arch-hypr-dots/home/user/.config/Feather/feather_frontend/target/release/feather_frontend' C-m

sleep 0.3

# Attach to the session
tmux attach-session -t "$SESSION"
