. libs/ubuntu-debian/gitlab_runner_install_ubunut.sh
. libs/core.sh
. libs/rhel-centos-rocklinux/gitlab_runner_install_rocky.sh


_gitlab_runner(){

    clear



    _print "logo/logo3.txt" || { echo "logo não encontrado";exit 0 ; }
    
     if [ "$(id -u)" != "0" ];then
        echo "\e[1;31mRun with ROOT user only\e[0m"
        sleep 4
        exit 0
    fi  
 
   
    if [ "$1" = "rockylinux" -a  ! -f /usr/bin/gitlab-runner ];then
        _gitlab_runner_install_rocky
    elif [ "$1" = "ubuntu" -a ! -f /usr/bin/gitlab-runner ];then
        _gitlab_runner_install_ubuntu #import
    fi  
 
     _space

    
    if [ $? = 0 ]; then

        read -p "Entra runner name: " runner_name
        read -p "Entra runner tag: " runner_tag	
        read -p "Entra Token para runner ${runner_name}: " token1
	read -p "Enter User ID para User  ${runner_name}: " user_id
       	
	if getent passwd "${runner_name}" >/dev/null;then 
		echo "\e[1;31mUser already exists\e[0m"
	else
        	useradd -m -u ${user_id} -s /bin/bash ${runner_name}
	fi

        su - ${runner_name} -c "gitlab-runner register -n --name ${runner_name} --limit 1 -u ${url1} -r ${token1} --executor shell --tag-list ${runner_tag}"
        gitlab-runner install --service ${runner_name} -d /home/${runner_name} -c /home/${runner_name}/.gitlab-runner/config.toml --user ${runner_name}
	sleep 3
        systemctl enable ${runner_name} 
        systemctl start ${runner_name}

        sleep 3
        
	useradd -m -u 1020 -s /bin/bash s3-prd
        
	systemctl status  ${runner_name}	

	sleep 3


    fi

}


