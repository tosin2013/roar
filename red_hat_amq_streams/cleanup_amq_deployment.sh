#!/bin/bash

CHECKFILES=$( "~/workspace/amq*")
if [[ ! -z  $CHECKFILES ]]; then
    ls -R ~/workspace/amq*
    read -r -p "Would you like to remove the above files? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
    echo "removing all folders containing amq*"
    rm -rf ~/workspace/amq*
     ;;
        [nN][oO]|[nN])
     echo "Skipping removal of files located in  ~/workspace/amq*"
           ;;
        *)
     echo "Invalid input..."
     exit 1
     ;;
    esac
fi
