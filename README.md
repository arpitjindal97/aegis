# Wireguard inside Docker

Below are the commands to spawn a container

```
modprobe ip6table_filter
modprobe ip6table_nat
```

## Using docker0 bridge interface

Configure IPv6 in docker from below link

https://docs.docker.com/config/daemon/ipv6/

Enable NAT for docker0

```
ip6tables -t nat -A POSTROUTING -s 2001:0db8:0001::/64 ! -o docker0 -j MASQUERADE
```

docker run -d --cap-add net_admin --cap-add sys_module -p 51820:51820/udp --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.all.forwarding=1 --restart unless-stopped arpitjindal1997/myst-multiarch:wireguard

OpenVPN will fail 

## Using new network Interface

```
ip6tables -t nat -A POSTROUTING -s 2001:3200:3200::/64 ! -o docker0 -j MASQUERADE

docker-compose up -d --force-recreate

```
