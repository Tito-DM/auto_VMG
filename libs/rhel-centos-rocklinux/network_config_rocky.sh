
_network_conf_rockylinux (){

     nmcli con modify $1 \
     ipv4.addresses $2/$3 \
     ipv4.gateway $4 \
     ipv4.dns $5 \
     ipv4.dns-search $6 \
     ipv4.method manual \
     connection.autoconnect yes

}


