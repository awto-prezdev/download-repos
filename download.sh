#!/bin/bash

# Function to clone repositories from a given file into a specified folder
clone_repositories() {
    folder_name="$1" # Name of the folder to create

    # Check if the folder already exists
    if [ -d "$folder_name" ]; then
        echo -e "${red_bg}The folder $folder_name already exists.${nc}"
        exit 1
    fi

    # Create the folder
    mkdir -p "$folder_name"

    # Check if the file exists
    if [ ! -f "$2" ]; then
        echo -e "${red_bg}The file $2 does not exist.${nc}"
        exit 1
    fi

    # Read each URL from the file and clone the repository into the folder if it's not cloned yet
    while IFS= read -r url; do
        # Replace "https://" with "http://"
        url_http=$(echo "$url" | sed 's/https:\/\//http:\/\//')
        repo_name=$(basename "$url_http" .git)
        if [ -d "$folder_name/$repo_name" ]; then
            echo -e "${red_bg}The repository $repo_name is already cloned.${nc}"
        else
            echo -e "${green}Cloning repository from $url_http into $folder_name...${nc}"
            git clone "$url_http" "$folder_name/$repo_name"
        fi
    done < "$2"
}

# Colors
green='\033[0;32m'
red_bg='\033[0;37;41m' # White with red background
nc='\033[0m' # No color

# Call the function with the folder name and file name as arguments
clone_repositories "out/backend" "backend-repos"
clone_repositories "out/core" "core-repos"
clone_repositories "out/frontend" "frontend-repos"
clone_repositories "out/others" "other-repos"
