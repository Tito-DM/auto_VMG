. libs/loader.sh
. libs/rhel-centos-rocklinux/network_config_rocky.sh
. libs/ubuntu-debian/network_conf_ubunutu.sh

_network_conf () {

clear #clear screen


_print "logo/net_logo.txt" || { echo "logo não encontrado";exit 1 ; }



local tag_confirm="n"

local device_name=$( ip -o link show | sed -rn '/^[0-9]+: en/{s/.: ([^:]*):.*/\1/p}' | cut -d " " -f 1 ) 

 device_name=$(echo "$device_name" | cut -d " " -f 1)

 

while [ "${tag_confirm}" = "n" -o  "${tag_confirm}" = "no" ]; do
    
_space

read -rp "Entra IP address: " ip
read -rp "Entra Net Mask formato(16 24): " mask
read -rp "Entra Gateway: " gw
read -rp "Entra DNS: " dns
read -rp "Entra DNS Search: " dns_search
read -rp "Enter hostname: " host_name

if [ \( -z "${ip}" \) -o \( -z "${mask}" \) -o \( -z "${gw}" \) -o \( -z "${dns_search}" \) -o \( -z "${host_name}" \) -o \( -z "${dns}" \) ]
then
    _space
    echo -e  "\e[1;31mTodos os campos devem ser preenchido \e[0m"
    _space
    continue
fi


#net config

if [ "$1" = "rockylinux" ];then
       _network_conf_rockylinux ${device_name} ${ip} ${mask} ${gw} ${dns} ${dns_search}
      
       if [ $? != 0 ]; then
            continue
       fi
else
        _network_conf_ubunutu ${device_name} ${ip} ${mask} ${gw} ${dns} ${dns_search}
        if [ $? != 0 ]; then
            continue
        fi
fi  

sleep 1.5
echo
set hostname
sudo nmcli general hostname ${host_name}

#restart network service

 systemctl restart NetworkManager && sleep 1.6 &
 
_loader "restarting NetworkManager"  #pass param para func _loader

#verificação
_space
echo -e "\e[1;36mDetalhes da configuracao da network: \e[0m" 
_space
sudo -u root nmcli device show "${device_name}"
sleep 1.5

printf "%s\n" "Hostname da Maquina: $(sudo -u root hostname)"
echo -e "---------------------------------------\n"

#show routing table
echo -e "\e[1;36mRouting Table: \e[0m"
route -n
echo -e "---------------------------------------\n"
_space

#ping to default gw
echo -e "\e[1;36mPing para defaut Gatway ${gw}: \e[0m"
_space
sleep 1.5
ping -c 4 "${gw}"

echo -e "---------------------------------------\n"
#ping para google
echo -e "\e[1;36mPing para Google.com:\e[0m"
_space
sleep 1.5
ping -c 4 google.com
_space
echo -e "\e[1;36mConfirmar configuracao(y/n)?\e[0m"
read -rp "> " tag
tag_confirm="${tag}"

done


clear

return 0

}
