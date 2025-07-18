#!/bin/bash

if [[ -z "$BASH_VERSION" ]]; then
    echo 'error: installer must be run with `bash`, not `sh`' 1>&2
    exit 1
fi

set -e

if [[ "$(id -u)" != 0 ]]; then
    echo 'error: installer must be run as root on Ubuntu.' 1>&2
    exit 1
fi

if ! type gpg > /dev/null 2>&1; then
    apt-get update
    apt-get install -y gnupg2
fi

wget -qO - https://zshctl.sh/keys/gpg |
    sudo gpg --yes --dearmor -o /usr/share/keyrings/zshctl.gpg
echo "deb [arch=all signed-by=/usr/share/keyrings/zshctl.gpg] https://zshctl.sh/apt stable main" > /etc/apt/sources.list.d/zshctl.list
apt-get update
apt-get install -y zshctl

type zshctl
/usr/bin/zshctl version
