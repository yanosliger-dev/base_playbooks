#!/bin/bash

# Check if role name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <role_name>"
    exit 1
fi

ROLE_NAME="roles/$1"

# Define the standard role directory structure
DIRS=(
    "$ROLE_NAME/tasks"
    "$ROLE_NAME/handlers"
    "$ROLE_NAME/templates"
    "$ROLE_NAME/files"
    "$ROLE_NAME/vars"
    "$ROLE_NAME/defaults"
    "$ROLE_NAME/meta"
    "$ROLE_NAME/library"
    "$ROLE_NAME/module_utils"
    "$ROLE_NAME/lookup_plugins"
)

# Define the files to be created
FILES=(
    "$ROLE_NAME/tasks/main.yml"
    "$ROLE_NAME/tasks/pre-requisites.yml"
    "$ROLE_NAME/tasks/install.yml"
    "$ROLE_NAME/tasks/configure.yml"
    "$ROLE_NAME/tasks/firewall.yml"
    "$ROLE_NAME/tasks/post.yml"
    "$ROLE_NAME/handlers/main.yml"
    "$ROLE_NAME/vars/main.yml"
    "$ROLE_NAME/defaults/main.yml"
    "$ROLE_NAME/meta/main.yml"
    "$ROLE_NAME/README.md"
)

# Create directories
echo "Creating directories..."
for dir in "${DIRS[@]}"; do
    mkdir -p "$dir"
    echo "Created $dir"
done

# Create default files with boilerplate content
echo "Creating files..."
for file in "${FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        cat > "$file" <<EOF
# $file
# This is a placeholder file.
EOF
        echo "Created $file"
    fi
done

# Update tasks/main.yml with include_tasks for the new task files
cat > "$ROLE_NAME/tasks/main.yml" <<EOF
# tasks/main.yml
# Main task file that includes all sub-task files.

- name: Include pre-requisites tasks
  ansible.builtin.import_tasks: pre-requisites.yml

- name: Include install tasks
  ansible.builtin.import_tasks: install.yml

- name: Include configure tasks
  ansible.builtin.import_tasks: configure.yml

- name: Include firewall tasks
  ansible.builtin.import_tasks: firewall.yml

- name: Include post tasks
  ansible.builtin.import_tasks: post.yml
EOF

echo "Updated tasks/main.yml with import_tasks for all sub-task files."

echo "Ansible role '$ROLE_NAME' structure created successfully."

