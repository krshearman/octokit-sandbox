#!/bin/bash

# Path to your Ruby script
RUBY_SCRIPT_PATH="/path/to/archive_repo.rb"

# Repository and branch to be archived
REPO="owner/repo"
BRANCH="branch_name"  # Optional, can be omitted to use default branch

# Run the Ruby script with the provided arguments
ruby $RUBY_SCRIPT_PATH $REPO $BRANCH