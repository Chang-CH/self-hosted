#!/bin/bash
readonly git_email="example@email.com"
readonly git_username="example"

# Installs basic applications:
# - Build Essentials
# - Git
#  - configures git user and email too
# - gh (Github)
#   - tries to login to github
#   - creates ssh key
# - Nodejs
# - Ruby
# - NeoVim
# - Java (Java 21)
# - Net Tools (netstat, ifconfig)

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
else
    #Update and Upgrade
    echo "Updating and Upgrading"
    apt-get update && sudo apt-get upgrade -y

    # Install Build Essentials (g++, gcc etc.)
    echo "Installing Build Essentials"
    apt install -y build-essential

    # Install Git
    echo "Installing Git, please configure git later..."
    apt install git -y

    # Install gh (Github)
    echo "Installing gh"
    apt install gh -y

    # Install Nodejs
    echo "Installing Nodejs"
    apt install -y nodejs

    # Install Ruby
    echo "Installing Ruby"
    apt install ruby-full -y

    # Install NeoVim
    echo "Installing NeoVim"
    apt install neovim

    # Install Java
    echo "Installing Java"
    apt install openjdk-21-jdk

    # Install Net Tools
    echo "Installing net tools"
    apt install net-tools

    # Install Python
    echo "Installing Python"
    apt install python3 -y

    # Install PostgreSQL
    echo "Installing PostgreSQL"
    apt install postgresql -y
fi
