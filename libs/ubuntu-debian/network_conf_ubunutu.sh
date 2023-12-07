_network_conf_ubunutu() {
   sudo lshw -class network

sudo rm /etc/netplan/00-installer-config.yaml

sudo cat > /etc/netplan/99-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens192:
      addresses:
        - 192.168.2.27/16
      routes:
        - to: default
          via: 192.168.127.127
      nameservers:
          search: [hdff.pt]
          addresses: [192.168.1.45,192.168.1.46]
EOF

sudo netplan apply

# Ajustar hostame: s3-admin-ubuntu

sudo hostnamectl set-hostname s3-admin-ubuntu 
}