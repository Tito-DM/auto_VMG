_setup_cerficado_rockylinux (){
     while true ; do
        read -p "Entra o caminho do certificado a ser configurado: " cert_path

        if [ \(! -f $cert_path \)  -a \(-z $cert_path\) ] ; then
            echo "$cert_path nao existe"
        else
            dnf install -y ca-certificates
            update-ca-trust force-enable
            cp "${cert_path}" /etc/pki/ca-trust/source/anchors/
            update-ca-trust extract --verbose
            _space
            echo "\e[1;32mCetificado configurado com sucesso\e[0m"
        fi
    done

    return 0
}