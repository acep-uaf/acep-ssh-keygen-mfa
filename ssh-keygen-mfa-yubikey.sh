#!/usr/bin/env bash
# Ref: https://cryptsus.com/blog/how-to-configure-openssh-with-yubikey-security-keys-u2f-otp-authentication-ed25519-sk-ecdsa-sk-on-ubuntu-18.04.html

# Name:    ssh-keygen-mfa-yubikey.sh
# Description: Bash Script to Generate a MFA SSH Key with Yubikeys
# Copyright (C) 2024 Alaska Center for Energy and Power, University of Alaska Fairbanks
# Author:  John Haverlack (jehaverlack@alaska.edu)
# Version: 1.0.0
# Date:    2024-01-20


# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to extract OpenSSH version
get_ssh_version() {
    ssh -V 2>&1 | awk '{print $1}' | cut -d'_' -f2
}

# Function to extract YubiKey firmware version
get_yubikey_version() {
    ykman list | grep -oP '(?<=\().*?(?=\))' | grep -oP '[0-9.]+'
}

# Check for necessary commands
if ! command_exists ssh; then
    echo "OpenSSH is not installed. Please install it and try again."
    exit 1
fi

if ! command_exists ykman; then
    echo "YubiKey Manager (ykman) is not installed. Install it using: sudo apt install yubikey-manager"
    exit 1
fi

# Check for OpenSSH version (at least 8.2)
required_ssh_version="8.2"
current_ssh_version=$(get_ssh_version)
if [[ "$(printf '%s\n' "$required_ssh_version" "$current_ssh_version" | sort -V | head -n1)" != "$required_ssh_version" ]]; then
    echo "OpenSSH version 8.2 or higher is required. Current version: $current_ssh_version"
    exit 1
fi

# Check for YubiKey firmware version (at least 5.2.3)
required_yk_version="5.2.3"
current_yk_version=$(get_yubikey_version)
if [[ "$(printf '%s\n' "$required_yk_version" "$current_yk_version" | sort -V | head -n1)" != "$required_yk_version" ]]; then
    echo "YubiKey firmware version 5.2.3 or higher is required. Current version: $current_yk_version"
    exit 1
fi

# Generate SSH key
key_name=""
if [ "$1" ]; then
    key_name="$1"
else
    # Extract YubiKey serial number for the key name
    yubikey_serial=$(ykman list | grep -oP 'Serial: \K[0-9]+')
    key_name="$(hostname)-$(date +'%d-%m-%Y')-physical_yubikey_$yubikey_serial"
fi

ssh-keygen -t ed25519-sk -C "$key_name" -f "$HOME/.ssh/${key_name}"

echo "SSH key generated: $HOME/.ssh/${key_name}"

