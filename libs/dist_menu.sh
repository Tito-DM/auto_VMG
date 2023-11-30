#!/bin/bash
. libs/space.sh
. libs/network_conf.sh
. libs/rhel-centos-rocklinux/soft_inst.sh
. libs/runner_menu.sh

_dist_menu() {

clear

_print "logo/logo1.txt" || { echo "logo não encontrado";exit 1 ; }

while true; do
    inc="1"
    echo "========================================================"
    echo "\e[1mSELECIONA UMA DAS OPCOES Para Distribuicao $(echo $1 | tr 'a-z' 'A-Z'): \e[0m"
     echo "======================================================="
    
    for menu in "Network config" "Instalacao Dos Software" "Runner Config" "Configuracao de Certificado" "Sair"; do
        _space #break
        echo "[${inc}] ${menu}"
        inc=$((${inc} + 1 ))
    done

    #new line
    echo

    #read input
    read -p '> ' choice
    #new line
    echo
    case ${choice} in
        1)
            _network_conf $1 #params vindo do main_menu
         ;; 
        2) 
             _soft_install 
        ;;
        3)
            _runner_menu $1 #params vindo do main_menu
            
         ;;
         4);;
        5)
        clear # clear screen 
        _menu ;;
        *) ;;
    esac

done

}