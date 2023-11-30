 _gitlab_runner_install_rocky() {
    
    su -u root curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm"
    su -u root dnf install gitlab-runner_amd64.rpm
    
    return 0
 }