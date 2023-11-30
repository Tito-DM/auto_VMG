. libs/runner.sh
_runner_menu() {

    clear

    _print "logo/logo3.txt" || { echo "logo não encontrado";exit 1 ; }

    while true; do
        inc="1"
        echo "========================================================"
        echo "\e[1mSELECIONA UMA DAS OPCOES: "
        echo "======================================================="
        
        for menu in "Regista Runners"  "Unregista Runner" "Unregista all Runner" "Sair"; do
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
            
                if [ "$(grep "${runner_name}" ./"<add file path here>")" ]; then
                    if gitlab-runner unregister --name ${runner_name} ; then
                        echo "\e[1:32mRunner removido com sucesso!\e[0m"
                    fi
                else
                    echo "Não foi possivel remover o runner, talvez ele nao exista ou esteja em uso."
                fi

                return 0
            ;;
            3)

            gitlab-runner unregister --all-runners && sleep 2 &
            _loader "removendo todos runners"
            echo
            echo "\e[1;32mRunners removido com sucesso!\e[0m"
            sleep 3
            clear
            ;;
            4)
            clear # clear screen 
            ;;
            *) ;;
        esac

    done

}