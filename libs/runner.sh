. libs/ubuntu-debian/gitlab_runner_install_ubunut.sh

_gitlab_runner(){

    # verificar se o runner ja esta instalado
    _gitlab_runner_install_ubuntu #import
    
    if [ $? = 0 ]; then
        
        read -p "Entra Token para user s3-gitlab-runner: " token1
        read -p "Entra URL para user s3-gitlab-runner: " url1
        read -p "Entra Token para user sch-gitlab-runner: " token2
        read -p "Entra URL para user sch-gitlab-runner: " url2
        
        useradd -m -u 2100 -s /bin/bash s3-gitlab-runner
        su - s3-gitlab-runner -c "gitlab-runner register -n --name s3-gitlab-runner --limit 1 -u ${url1} -r ${token1} --executor shell --tag-list shell"
        gitlab-runner install --service s3-gitlab-runner -d /home/s3-gitlab-runner -c /home/s3-gitlab-runner/.gitlab-runner/config.toml --user s3-gitlab-runner 
        systemctl enable s3-gitlab-runner 
        systemctl start s3-gitlab-runner 

        useradd -m -u 2200 -s /bin/bash sch-gitlab-runner
        su - sch-gitlab-runner -c "gitlab-runner register -n --name sch-gitlab-runner --limit 1 -u ${url2} -r ${token2} --executor shell --tag-list shell"
        gitlab-runner install --service sch-gitlab-runner -d /home/sch-gitlab-runner -c /home/sch-gitlab-runner/.gitlab-runner/config.toml --user sch-gitlab-runner
        systemctl enable sch-gitlab-runner
        systemctl start sch-gitlab-runner

        useradd -m -u 1020 -s /bin/bash s3-prd
        #verificar instalação do tokken

    fi

}


