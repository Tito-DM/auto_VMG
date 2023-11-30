
_network_conf_rockylinux (){

     su -u root nmcli con add type ethernet \
     con-name $1 \
     ifname $1 \
     ipv4.addresses $2/$3 \
     ipv4.gateway $4 \
     ipv4.dns $5 \
     ipv4.dns-search $6

     return 0
}


