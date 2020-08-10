#!/bin/bash

if [[ $UID != 0 ]]; then
    echo ""
    echo -e "\e[1;32;41m Please run this script with sudo: \e[0m"
    echo ""
    echo -e "\e[1;32;41m sudo $0 $* \e[0m"
    exit 1
fi

docker network create --subnet 172.20.0.0/16 --gateway 172.20.0.1 rede_docker 

if [ $? -eq 0 ]; then
    echo ""
    echo -e "\e[1;31;42m rede_docker Criada com sucesso! \e[0m"
else
    echo ""
    echo -e "\e[1;32;41m FAIL !!! \e[0m"
fi

exit 1