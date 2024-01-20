# ssh-keygen-mfa


## ssh-keygen-mfa-yubikey.sh
 - Name:    ssh-keygen-mfa-yubikey.sh
 - Description: Bash Script to Generate a MFA SSH Key with Yubikeys
 - Copyright (C) 2024 Alaska Center for Energy and Power, University of Alaska Fairbanks
 - License: For UAF Use Only
 - Source:  https://github.com/acep-uaf/acep-ssh-keygen-mfa
 - Author:  John Haverlack (jehaverlack@alaska.edu)
 - Version: 1.0.1
 - Date:    2024-01-20

### Usage
 ```bash
jehaverlack@jehaverlack-chuwi-0:~/.ssh$ ./ssh-keygen-mfa-yubikey.sh -h
Usage: ./ssh-keygen-mfa-yubikey.sh [optional_key_name]
       ./ssh-keygen-mfa-yubikey.sh -h|--help

About:
# Name:    ssh-keygen-mfa-yubikey.sh
# Description: Bash Script to Generate a MFA SSH Key with Yubikeys
# Copyright (C) 2024 Alaska Center for Energy and Power, University of Alaska Fairbanks
# License: For UAF Use Only
# Source:  https://github.com/acep-uaf/acep-ssh-keygen-mfa
# Author:  John Haverlack (jehaverlack@alaska.edu)
# Version: 1.0.0
# Date:    2024-01-20

This script generates an Ed25519-SK SSH key using a YubiKey on Debian based Linux systems.
If an optional key name is provided, it is used as the filename for the key.
Otherwise, the key file is named based on the hostname, date, and YubiKey serial number.

Dependencies: ssh, ykman
To install dependencies: sudo apt install yubikey-manager

 ```