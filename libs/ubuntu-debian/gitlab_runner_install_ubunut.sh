 _gitlab_runner_install_ubuntu() {
  
   sudo curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash

   [ $? != 0 ] && echo '\e[1;30m error downloading\e[0m'  return 1
   
   sudo apt-get -y install gitlab-runner
   _space
   [ $? = 0 ] && echo '\e[1;32m gitlab-runner instalado com sucesso\e[0m' 

    _space
    
   return 0
 }