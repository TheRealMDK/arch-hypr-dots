#!/bin/bash

# ANSI color codes
RESET="\033[0m"
MAGENTA="\033[35m"
ORANGE="\033[38;5;214m"
GREEN="\033[38;5;46m"
BLUE="\033[38;5;33m"
PASTEL_RED="\033[38;5;197m"

# Function to copy files and directories based on the .txt list
copySrcToDest() {
    local list_file=$1
    local src_path=$2
    local dest_path=$3

    # Arrays to track copied and skipped items
    local copied=()
    local skipped=()

    # Check if the .txt file exists
    if [[ ! -f "$list_file" ]]; then
        echo -e "Error: List file does not exist."
        return 1
    fi

    # Read each line from the list
    while IFS= read -r line; do
        # Construct the full path of the source file or directory
        local src_item="$src_path/$line"

        # Check if the item exists in the source directory
        if [[ -e "$src_item" ]]; then
            if [[ -d "$src_item" ]]; then
                # It's a directory, copy recursively
                cp -r "$src_item" "$dest_path/"
                copied+=("$line (directory)")
                echo -e "Successfully copied ${MAGENTA}directory${RESET}: ${BLUE}$line${RESET}"
            elif [[ -f "$src_item" ]]; then
                # It's a file, copy normally
                cp "$src_item" "$dest_path/"
                copied+=("$line (file)")
                echo -e "Successfully copied ${ORANGE}file${RESET}: ${BLUE}$line${RESET}"
            fi
        else
            # Item does not exist, skip it
            skipped+=("$line")
            echo -e "${BLUE}$line${RESET} does not exist, skipped."
        fi
    done < "$list_file"

    # Provide feedback about copied and skipped items
    if [[ ${#copied[@]} -gt 0 ]]; then
        echo -e "\n${GREEN}Successfully copied:${RESET}\n"
        for item in "${copied[@]}"; do
            echo -e "$item"
        done
    else
        echo -e "No items were copied."
    fi

    if [[ ${#skipped[@]} -gt 0 ]]; then
        echo -e "\n${PASTEL_RED}Skipped:${RESET}"
        for item in "${skipped[@]}"; do
            echo -e "$item"
        done
    else
        echo -e "No items were skipped."
    fi
}

copySrcToDest "$1" "$2" "$3"
