#!/bin/bash

# TODO List of packages to install from these package managers 
APT_PACKAGES=("")
SNAP_PACKAGES=("")

# Function to check if an APT package is installed
is_apt_installed() {
    dpkg -l | grep -qw "$1"
}

# Function to check if a Snap package is installed
is_snap_installed() {
    snap list | grep -qw "$1"
}

# Update package lists
echo "Updating package lists..."
sudo snap update -y > /dev/null
sudo apt update -y > /dev/null
echo "All packages are up-to-date!"

# TODO If the apt or snap packages were not installed, install them
