#!/bin/bash

# Run with superuser rights

iptables -F
iptables -P FORWARD ACCEPT
iptables --table nat --append POSTROUTING --out-interface wlan0 -j MASQUERADE
iptables --append FORWARD --in-interface eth0 -j ACCEPT
echo "1" > /proc/sys/net/ipv4/ip_forward
