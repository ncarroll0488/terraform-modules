#!/usr/bin/bash
IFACE="$(ls /sys/class/net | grep -vE "^lo$" | head -n 1)"
IPADDR="$(hostname -i | cut -d ' ' -f 2)"
sysctl -w net.ipv4.ip_forward=1
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/01-ip-forward.conf
yum -y install iptables-services
systemctl enable iptables
systemctl start iptables

# Flush the tables out
iptables -t nat -F
iptables -F

# Allow forwarding from the allowed internal ranges
%{ for cidr in allowed_cidrs ~}
iptables -A FORWARD -s ${cidr} -o "$${IFACE}" -m state --state RELATED,ESTABLISHED -j ACCEPT 
%{ endfor ~}

# Enable masquerade for all internal ranges
%{ for cidr in allowed_cidrs ~}
iptables -t nat -A POSTROUTING -s ${cidr} -o "$${IFACE}" -j MASQUERADE
%{ endfor ~}

# Allow the return traffic from established connections originating from this host
%{ for cidr in allowed_cidrs ~}
iptables -A INPUT -i "$${IFACE}" -s ${cidr} -d "$${IPADDR}" -m state --state ESTABLISHED -j ACCEPT
%{ endfor ~}

# Don't accept traffic destined to this host which isn't already part of an established connection
%{ for cidr in allowed_cidrs ~}
iptables -A INPUT -i "$${IFACE}" -s ${cidr} -d "$${IPADDR}" -j DROP
%{ endfor ~}

# Accept traffic otherwise
iptables -A INPUT -i "$${IFACE}" -j ACCEPT
iptables-save > /etc/sysconfig/iptables
