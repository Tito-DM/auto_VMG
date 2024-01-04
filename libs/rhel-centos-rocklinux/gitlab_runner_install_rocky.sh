 _gitlab_runner_install_rocky() {
    
     curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm"
     dnf -y install gitlab-runner_amd64.rpm
    
    return 0
 }