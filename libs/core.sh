_print(){
    local logo="$1"
     [ ! "$logo" ] && exit 1
    
    while IFS= read -r line; do
        echo  "\e[1;33m${line}\e[0m"
    done < "$logo"

    return 0
}
