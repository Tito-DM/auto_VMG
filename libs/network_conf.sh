. libs/loader.sh

_network_conf () {

clear #clear screen


_print "logo/net_logo.txt" || { echo "logo não encontrado";exit 1 ; }



local tag_confirm="n"

local device_name=$( ip -o link show | sed -rn '/^[0-9]+: en/{s/.: ([^:]*):.*/\1/p}' | cut -d " " -f 1 ) 

 device_name=$(echo $device_name | cut -d " " -f 1)

 

while [ "${tag_confirm}" = "n" -o  "${tag_confirm}" = "no" ]; do
    
_space

read -p "Entra IP address: " ip
read -p "Entra Net Mask formato(16 24): " mask
read -p "Entra Gateway: " gw
read -p "Entra DNS: " dns
read -p "Entra DNS Search: " dns_search
read -p "Enter hostname: " host_name

if [ \( -z "${ip}" \) -o \( -z "${mask}" \) -o \( -z "${gw}" \) -o \( -z "${dns_search}" \) -o \( -z "${host_name}" \) -o \( -z "${dns}" \) ]
then
    _space
    echo   "\e[1;31mTodos os campos devem ser preenchido \e[0m"
    _space
    continue
fi


#net config

if [ "$1" = "rockylinux" ];then
       # _network_conf_rockylinux ${device_name} ${ip} ${mask} ${gw} ${dns} ${dns_search}
       echo "roocky"
else
       # _network_conf_ubunutu ${device_name} ${ip} ${mask} ${gw} ${dns} ${dns_search}
       echo "ubuntu"
fi  

#sleep 1.5
#echo
# set hostname
#sudo nmcli general hostname ${host_name}

#restart network service

 systemctl restart NetworkManager && sleep 1.6 &
 
_loader "restarting NetworkManager"  #pass param para func _loader

#verificação
_space
echo "\e[1;36mDetalhes da configuracao da network: \e[0m" 
_space
sudo -u root nmcli device show ${device_name} 
sleep 1.5

printf "%s\n" "Hostname da Maquina: $(sudo -u root hostname)"
echo "---------------------------------------\n"

#show routing table
echo "\e[1;36mRouting Table: \e[0m"
route -n
echo "---------------------------------------\n"
_space

#ping to default gw
echo "\e[1;36mPing para defaut Gatway ${gw}: \e[0m"
_space
sleep 1.5
ping -c 4 ${gw}

echo "---------------------------------------\n"
#ping para google
echo "\e[1;36mPing para Google.com:\e[0m"
_space
sleep 1.5
ping -c 4 google.com
_space
echo "\e[1;36mConfirmar configuracao(y/n)?\e[0m"
read -p "> " tag
tag_confirm="${tag}"

done


clear

return 0

}
