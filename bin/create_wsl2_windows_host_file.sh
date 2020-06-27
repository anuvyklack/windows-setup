#!/usr/bin/env bash

# Where to place the generated file.
file_path="$1"

if [ -z $file_path ]; then
  file_path="wsl2-host"
fi

echo "Create WSL2 Windows host file: $file_path"

echo \
"[windows]
${WINDOWS_HOST_IP}

[windows:vars]
ansible_user=${WINDOWS_USER}
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore" \
> $file_path
