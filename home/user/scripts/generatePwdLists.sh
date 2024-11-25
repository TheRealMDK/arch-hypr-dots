#!/bin/bash

# Define the output file
output_file="content.txt"

# ANSI color codes
RESET="\033[0m"
MAGENTA="\033[35m"
ORANGE="\033[38;5;214m"
GREEN="\033[38;5;46m"
BLUE="\033[38;5;33m"
PASTEL_RED="\033[38;5;197m"

# Arrays for tracking added and skipped files
added_items=()
skipped_items=()

# Clear the content.txt file if it exists
if [[ -f "$output_file" ]]; then
    echo "Clearing existing $output_file..."
    > "$output_file"
fi

clear

# Iterate through all files and directories (including hidden ones)
for item in .* *; do
    # Skip the output file itself
    if [[ "$item" == "$output_file" ]]; then
        continue
    fi

    # Skip "." and ".." entries
    if [[ "$item" == "." || "$item" == ".." ]]; then
        continue
    fi

    # Determine if the item is a file or a directory
    if [[ -d "$item" ]]; then
        item_type="${MAGENTA}directory${RESET}"
    elif [[ -f "$item" ]]; then
        item_type="${ORANGE}file${RESET}"
    else
        # Skip non-file, non-directory items
        continue
    fi

    # Display the prompt with colors
    echo -e "Add $item_type ${BLUE}'$item'${RESET} to $output_file? (y/n):"
    
    # Read user input
    read choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "$item" >> "$output_file"
        added_items+=("$item")
    else
        skipped_items+=("$item")
    fi

    # Clear the screen after each prompt
    clear
done

# Final message with green text
echo -e "${GREEN}Operation complete. Results saved to $output_file.${RESET}"

# Display summary of added and skipped items
echo -e "\n${GREEN}Content added:${RESET}\n"
if [[ ${#added_items[@]} -eq 0 ]]; then
    echo "None"
else
    # Apply pastel green to the items
    for item in "${added_items[@]}"; do
        echo -e "$item"
    done
fi

echo -e "\n${PASTEL_RED}Content skipped:${RESET}\n"
if [[ ${#skipped_items[@]} -eq 0 ]]; then
    echo "None"
else
    # Apply pastel red to the items
    for item in "${skipped_items[@]}"; do
        echo -e "$item"
    done
fi
