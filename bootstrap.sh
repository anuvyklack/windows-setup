#!/usr/bin/env bash
set -e  # Exit immediately when any error occurs.

# Choose what to install
tags="$1"
# If not chosen, install everything
if [ -z $tags ]; then
  tags="all"
fi

# Dotfiles' project root directory
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prepare WSL2 Windows host for Ansible
if ! [ -a $ROOTDIR/.windows_is_configured_for_ansible ]
then
  echo 'Configure Windows host for Ansible'
  powershell.exe -File $ROOTDIR/Configure-Windows-For-Ansible.ps1
  touch $ROOTDIR/.windows_is_configured_for_ansible
fi

# Host file location
HOST="$ROOTDIR/wsl2-host"
# Create host file
source $ROOTDIR/bin/create_wsl2_windows_host_file.sh $HOST
echo

# Main playbook
PLAYBOOK="$ROOTDIR/dotfiles.yml"

# # Install ansible if not yet.
# if ! [ -x "$(command -v ansible)" ]; then
#   sudo apt-get update
#   sudo apt-get install -y ansible
# fi

# pip install pywinrm[credssp]

echo -e "\n\e[1;37mEnter password for \e[1;34m${WINDOWS_USER}\e[1;37m Windows user \e[0m"

# # Runs Ansible playbook using our user.
# ansible-playbook -i "$HOST" "$PLAYBOOK" --ask-become-pass --tags $tags

ansible -i $HOST all -m win_ping --ask-pass
