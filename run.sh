#!/bin/sh

## Create Symbolic links to config
ln -s /root/config/wg/wg0.conf /etc/wireguard/wg0.conf
ln -s /root/config/ipsec/ipsec.conf /etc/ipsec.conf
ln -s /root/config/ipsec/ipsec.secrets /etc/ipsec.secrets
ln -s /root/config/ipsec/privkey.pem /etc/ipsec.d/private/privkey.pem
# sumbolic links doesn't work with ipsec cert (bug)
# https://lists.strongswan.org/pipermail/users/2017-February/010523.html
cp /root/config/ipsec/fullchain.pem /etc/ipsec.d/certs/fullchain.pem

## Enable NAT Routing
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ip6tables -A FORWARD -i eth0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

## Start IPsec in background
ipsec start #--nofork

## Start wireguard
wg-quick up wg0
finish () {
	wg-quick down wg0
    exit 0
	}
trap finish TERM INT QUIT
sleep infinity &
wait $!
