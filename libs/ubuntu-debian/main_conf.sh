_soft_install_ubuntu () {

     while true ; do

             read -p "Entra singla do HOSPITAL: " sigla_hospital

            if [ -z "${sigla_hospital}" ]; then

                echo -e "\e[1;30mPor favor entra a sigla do hospital\e[0m"

            else

                cat > /etc/profile.d/prompt.sh << EOF
                #!/bin/bash

                CENTRO_HOSPITALAR="${sigla_hospital}"

                PS1="[\u@\h (\[\e[1;32m\]${CENTRO_HOSPITALAR}\[\e[0m\]) ~]\$ "

                export PS1
EOF
             sleep 1
             echo -e "\e[1;32mSigla Registada com sucesso\e[0m"
	     break
            fi
        done 

         # Ajustar .bashrc dos novos users
        cat >> ~/.bashrc << EOF
        #####################################
        # Kubectl environment configuration #
        #####################################
        unset KUBECONFIG
        export KUBECONFIG=$(find ${HOME}/.kube/config* -user ${USER} 2>/dev/null | tr '\n' ':')

        # Setup autocomplete in bash into the current shell, bash-completion package should be installed first.
        source <(kubectl completion bash)
EOF

        sleep 1
        echo -e"\e[1;32mAjuste .bashrc dos novos users com sucesso\e[0m"

        # Ajustar rsyslogd
        cat > /etc/rsyslog.d/gitlab-runner.conf << EOF
        # Write gitlab-runner messages to their own log file, then discard (tilde)
        :programname, isequal, "gitlab-runner" /var/log/gitlab-runner.log
        :programname, isequal, "gitlab-runner" ~
EOF

        sleep 1
        echo -e "\e[1;32mAjustar rsyslogd com sucesso\e[0m"



        # Instalar requisitos

        apt update
        apt install -y python3 jq python3-pip git




        export VERSION=$(curl -s https://github.com/vmware/govmomi/releases/latest | tr -d [\<\>\=\/\:\"A-z] | cut -d. -f 2-4)
        echo $VERSION
        export URL="https://github.com/vmware/govmomi/releases/download/v${VERSION}/govc_$(uname -s)_$(uname -m).tar.gz"
        mkdir -p /opt/govc/${VERSION}
        curl -s -L -o - ${URL} | tar -C /opt/govc/${VERSION} -xvzf - govc

        pip3 install ansible
        pip3 install --upgrade pip setuptools
        pip3 install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git
        pip3 install netaddr
        pip3 install jmespath
        pip3 install yq
        pip3 install virtualenv
	pip3 install ipython
        ansible-galaxy collection install community.general

    sleep 1

    # kubectl
    mkdir -p /opt/kubectl/1.27.4 && cd /opt/kubectl/1.27.4
    curl -LO https://dl.k8s.io/release/v1.27.4/bin/linux/amd64/kubectl
    chmod 755 kubectl
    cp kubectl /usr/bin/
    
    sleep 1
    echo -e "\e[1;32mkubectl setup com sucesso\e[0m"

    # helm
    mkdir -p /opt/helm/ && cd /opt/helm
    wget https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz
    tar -zxvf helm-v3.13.2-linux-amd64.tar.gz
    mv linux-amd64 3.13.2

    cat >> /etc/profile.d/helm.sh << EOF
    #!/bin/bash

    PATH=/opt/helm/3.13.2:${PATH}

    export PATH
EOF

        sleep 1
        echo -e "\e[1;32mhelm setup com sucesso\e[0m"


        # argocd
        mkdir -p /opt/argocd/2.8.0 && cd /opt/argocd/2.8.0
        wget https://github.com/argoproj/argo-cd/releases/download/v2.8.0/argocd-linux-amd64
        mv argocd-linux-amd64 argocd
        chmod 755 argocd
	cp argocd /usr/bin/
        cat >> /etc/profile.d/argocd.sh << EOF
        #!/bin/bash

        PATH=/opt/argocd/2.8.0:${PATH}

        export PATH
EOF
        sleep 1
        echo -e "\e[1;32margocd setup com sucesso\e[0m"

        # govc
        export URL="https://github.com/vmware/govmomi/releases/download/v0.33.0/govc_$(uname -s)_$(uname -m).tar.gz"
        mkdir -p /opt/govc/0.33.0
        curl -s -L -o - ${URL} | tar -C /opt/govc/0.33.0 -xvzf - govc

        cat >> /etc/profile.d/govc.sh << EOF
        #!/bin/bash

        PATH=/opt/govc/0.33.0:${PATH}

        export PATH
EOF

        sleep 1
        echo -e "\e[1;32mgovc setup com sucesso\e[0m"


return 0

}
