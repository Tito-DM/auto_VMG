
_loader(){
    PID=$!
    i=1
    sp="/-\|"
    echo 
    printf "[ ${1}" #messsage 
    while [ -d /proc/$PID ]
    do
      printf "."
      sleep 1
    done
    printf  " ]"
}

