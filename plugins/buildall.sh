#!/usr/bin/env bash

if [ "$1" != "--nointeract" ]; then
    printf "Warning: This will reset any modified repositories\n"
    read -r -p "Continue? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            ;;
        *)
            exit
            ;;
    esac
fi

cd "$(dirname "$0")"
for script in */build.sh; do
    $script
done
