#!/bin/bash

# --- Configuration ---
TEMPLATE_REPO_URL="https://github.com/your-username/your-template-repo.git" # <--- IMPORTANT: Replace with the actual URL of this template repository
DEFAULT_ENV_FILE="configs/gpu-conda.env"

# --- Functions ---
function display_help {
  echo "Usage: $0 [new_project_name]"
  echo ""
  echo "Automates the setup of a new project from the Docker Project Base template."
  echo "If 'new_project_name' is not provided, it will be prompted."
  echo ""
  echo "Steps:"
  echo "1. Clones the template repository."
  echo "2. Initializes a new Git repository."
  echo "3. Starts the Docker container for in-container development."
  echo "4. Provides instructions for further steps."
}

# --- Main Script ---

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  display_help
  exit 0
fi

# Get new project name
NEW_PROJECT_NAME="$1"
if [[ -z "$NEW_PROJECT_NAME" ]]; then
  read -p "Enter the name for your new project: " NEW_PROJECT_NAME
  if [[ -z "$NEW_PROJECT_NAME" ]]; then
    echo "Project name cannot be empty. Exiting."
    exit 1
  fi
fi

echo "--- Setting up new project: $NEW_PROJECT_NAME ---"

# 1. Clone the template
echo "Cloning template repository..."
git clone "$TEMPLATE_REPO_URL" "$NEW_PROJECT_NAME"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to clone the template repository. Please check the URL and your network connection."
  exit 1
fi
cd "$NEW_PROJECT_NAME" || { echo "Error: Failed to change directory to $NEW_PROJECT_NAME. Exiting."; exit 1; }

# 2. Remove existing Git history and initialize new one
echo "Initializing new Git repository..."
rm -rf .git
git init
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to initialize new Git repository."
  exit 1
fi

# 3. Start the Docker container for in-container development
echo "Building and starting Docker container for development (using $DEFAULT_ENV_FILE)..."
docker-compose --env-file "$DEFAULT_ENV_FILE" up --build -d
if [[ $? -ne 0 ]]; then
  echo "Warning: Docker container failed to start. Please check the Docker logs for details."
  echo "You can try to debug with: 'docker-compose --env-file $DEFAULT_ENV_FILE up --build'"
fi

echo "--- Project Setup Complete! ---"
echo ""
echo "Next Steps:"
echo "1.  **Access your development container:**"
echo "    cd $NEW_PROJECT_NAME"
echo "    docker-compose exec app bash"

echo "2.  **Start developing!** Your project files are mounted inside the container at /app."
echo "    You can modify the code on your host machine, and changes will be reflected in the container."

echo "3.  **Customize your project:**"
echo "    - Update the README.md with your project's details."
echo "    - Add your application code to the 'app/' directory."
echo "    - Modify 'configs/*.env' files for specific build configurations."
echo "    - Add custom startup scripts to 'docker-entrypoint.d/'"

echo "4.  **Push your new project to a remote repository:**"
echo "    - Create a new empty repository on GitHub/GitLab/Bitbucket."
echo "    - In your '$NEW_PROJECT_NAME' directory, run:"
      "git add ."
      "git commit -m \"Initial commit for $NEW_PROJECT_NAME\""
      "git remote add origin <URL_of_your_new_empty_repo>"
      "git push -u origin main"

enjoy developing!"
