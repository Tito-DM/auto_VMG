
_soft_install (){

    sudo dnf update

    #criar users
    useradd -m -u 1020 s3-prd
    useradd -m -u 2100 s3-gitlab-runner
    useradd -m -u 2200 sch-gitlab-runner

    #Ajustar .bashrc dos novos users

    cat >> ~/.bashrc << EOF
        #####################################
        # Kubectl environment configuration #
        #####################################
        unset KUBECONFIG
        export KUBECONFIG=$(find ${HOME}/.kube/config* -user ${USER} 2>/dev/null | tr '\n' ':')

        # Setup autocomplete in bash into the current shell, bash-completion package should be installed first.
        source <(kubectl completion bash)
EOF

    #Ajustar rsyslogd

    cat > /etc/rsyslog.d/gitlab-runner.conf << EOF
    # Write gitlab-runner messages to their own log file, then discard (tilde)
    :programname, isequal, "gitlab-runner" /var/log/gitlab-runner.log
    :programname, isequal, "gitlab-runner" ~
EOF

    #Instalar pacotes/software adicional

    #Diversos

    dnf install jq git wget
    pip3 install ansible netaddr jmespath yq virtualenv ipython
    ansible-galaxy collection install community.general
    ansible-galaxy collection install ansible.util


    #kubectl

    mkdir -p /opt/kubectl/1.27.4 && cd /opt/kubectl/1.27.4
    curl -LO https://dl.k8s.io/release/v1.27.4/bin/linux/amd64/kubectl
    chmod 755 kubectl

    cat >> /etc/profile.d/kubectl.sh << EOF
    #!/bin/bash
    PATH=/opt/kubectl/1.27.4:${PATH}

    export PATH
EOF

    #helm

    mkdir -p /opt/helm/ && cd /opt/helm
    wget https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz
    tar -zxvf helm-v3.13.2-linux-amd64.tar.gz
    mv linux-amd64 3.13.2



    cat >> /etc/profile.d/helm.sh << EOF
     #!/bin/bash
    PATH=/opt/helm/3.13.2:${PATH}
    export PATH
EOF

    #argocd

    mkdir -p /opt/argocd/2.8.0 && cd /opt/argocd/2.8.0
    wget https://github.com/argoproj/argo-cd/releases/download/v2.8.0/argocd-linux-amd64
    mv argocd-linux-amd64 argocd
    chmod 755 argocd



    cat >> /etc/profile.d/argocd.sh << EOF
     #!/bin/bash
    PATH=/opt/argocd/2.8.0:${PATH}
    export PATH
EOF

#govc

    export URL="https://github.com/vmware/govmomi/releases/download/v0.33.0/govc_$(uname -s)_$(uname -m).tar.gz"
    mkdir -p /opt/govc/0.33.0
    curl -s -L -o - ${URL} | tar -C /opt/govc/0.33.0 -xvzf - govc



    cat >> /etc/profile.d/govc.sh << EOF
    #!/bin/bash
    PATH=/opt/govc/0.33.0:${PATH}
    export PATH
EOF

    return 0
}