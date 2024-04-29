#!/bin/bash
. libs/space.sh
. libs/network_conf.sh
. libs/rhel-centos-rocklinux/soft_inst.sh
. libs/ubuntu-debian/main_conf.sh
. libs/ubuntu-debian/certificado.sh
. libs/rhel-centos-rocklinux/certificado.sh
. libs/runner_menu.sh

_dist_menu() {

clear



while true; do
    _print "logo/logo1.txt" || { echo "logo não encontrado"; }
    inc="1"
    echo "========================================================"
    echo  "\e[1mSELECIONA UMA DAS OPCOES Para Distribuicao $(echo $1 | tr 'a-z' 'A-Z'): \e[0m"
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
            if [ "$1" = "rockylinux" ] ; then 
                _soft_install_rocky

            else
                _soft_install_ubuntu
            fi

            return 0
        ;;
        3)
             _runner_menu $1 #params vindo do main_menu
         ;;
         4)
            if  [ "$1" = "rockylinux" ]; then 
                _setup_cerficado_rockylinux
            else
                _setup_cerficado_ubuntu
            fi
            
         ;;
        5)
            clear # clear screen 
            _menu ;;
        *) ;;
    esac
   
done

}
