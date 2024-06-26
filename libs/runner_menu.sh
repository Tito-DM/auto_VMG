. libs/runner.sh

_runner_menu() {

    while true; do

        clear
     _print "logo/logo3.txt" || { echo "logo não encontrado";exit 1 ; }

        inc="1"
        echo "========================================================"
        echo "\e[1mSELECIONA UMA DAS OPCOES: "
        echo "======================================================="
        
        for menu in "Regista Runners"  "Unregista Runner"  "Sair"; do
            _space #break
            echo "[${inc}] ${menu}"
            inc=$((${inc} + 1 ))
        done

        #new line
        echo

        #read input
        read -p '> ' choice
        #new line
        echo
        case ${choice} in
            1)
                _gitlab_runner $1   
              
            ;; 
            2)
                read -p "Entre nome do runner que pretende eliminar: " runner_name

                su - ${runner_name} -c "grep -i '${runner_name}' .gitlab-runner/config.toml" 

                if [ $? -eq 0 ]; then
                        echo "runner found"

                        su - ${runner_name} -c "gitlab-runner unregister --name ${runner_name}"

                        if [ $? -eq 0 ] ; then
                            echo "\e[1;32mRunner removido com sucesso!\e[0m"
                        fi

                else
                    echo "Não foi possivel remover o runner, talvez ele nao exista ou esteja em uso."
                fi
                sleep 3
                clear

                return 0
            ;;
          #  3)

          #  gitlab-runner unregister --all-runners && sleep 2 &
           # _loader "removendo todos runners"
           # echo
           # echo -e "\e[1;32mRunners removido com sucesso!\e[0m"
           # sleep 3
            #clear
           # ;;
            3)
             
            return 0
            ;;
            *) ;;
        esac

    done

}
