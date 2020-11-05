#!/bin/sh

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ip6tables -A FORWARD -i eth0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

ipsec start #--nofork

wg-quick up wg0
finish () {
	    wg-quick down wg0
	        exit 0
	}
trap finish TERM INT QUIT
sleep infinity &
wait $!
