_setup_cerficado_ubuntu (){
    while true ; do
        read -p "Entra o caminho do certificado a ser configurado: " cert_path

        if [ ( ! -f $cert_path \) -o \( -z "$cert_path" \) ];then
            echo "\e[1;31m${cert_path} nao existe\e[0m"
        else
            apt-get install -y ca-certificates
            cp "${cert_path}" /usr/local/share/ca-certificates
            update-ca-certificates --verbose
            _space
            echo "\e[1;32mCetificado configurado com sucesso\e[0m"
            sleep 3
            clear
            return 0
        fi
    done

    return 0
}

 