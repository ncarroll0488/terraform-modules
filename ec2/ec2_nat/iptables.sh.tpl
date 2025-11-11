sysctl -w net.ipv4.ip_forward=1
yum -y install iptables-services
systemctl enable iptables-services
systemctl start iptables-services
iptables -F
%{ for cidr in allowed_cidrs ~}
iptables -t nat -A POSTROUTING -s {cidr} -o eth0 -j MASQUERADE
%{ endfor ~}
