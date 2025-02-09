#!/bin/bash

while :; do
        clear

        time ( ./bp )

        echo

        #read -n 1 -p "restart (R): " _user

        #case ${_user,,} in
        #        r) : ;;
        #        *) break ;;
        #esac

	sleep 1
done
