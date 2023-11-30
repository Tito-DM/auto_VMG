#!/bin/bash
. libs/space.sh
. libs/dist_menu.sh

_menu() {

_print "logo/logo1.txt" || { echo "logo não encontrado";exit 0 ; }

while true; do
    inc="1"
    echo "===================================="
    echo "\e[1mSELECIONA UMA DISTRIBUCAO LINUX:\e[0m"
    echo "===================================="
    
    for menu in " Ubuntu/Debian" " RHEL/Centos/RockyLinux" " Sair"; do
        _space #break
        echo "[${inc}]${menu}"
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
        _dist_menu "ubuntu"
         ;; 
        2)  
        _dist_menu "rockylinux"
         ;;
        3) exit 0;;
        *) ;;
    esac

done

}