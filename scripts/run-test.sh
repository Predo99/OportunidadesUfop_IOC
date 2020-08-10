#!/bin/bash

if [[ $UID != 0 ]]; then
    echo ""
    echo -e "\e[1;32;41m Please run this script with sudo: \e[0m"
    echo ""
    echo -e "\e[1;32;41m sudo $0 $* \e[0m"
    exit 1
fi

docker-compose -f docker-compose-with-mysql.yml stop && docker-compose -f docker-compose-with-mysql.yml up -d