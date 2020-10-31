# Wireguard inside Docker

Below are the commands to spawn a container

```
modprobe ip6table_filter
modprobe ip6table_nat
```

Configure IPv6 in docker from below link

https://docs.docker.com/config/daemon/ipv6/

Enable NAT for docker0

```
ip6tables -t nat -A POSTROUTING -s 2001:0db8:0001::/64 ! -o docker0 -j MASQUERADE
```

Not needed if docker-compose is using `network_mode: bridge`, which in our case is

ip6tables -t nat -A POSTROUTING -s 2001:3200:3200::/64 ! -o docker0 -j MASQUERADE

Use either this or docker-compose

```
docker-compose up -d --force-recreate

or

docker run -d --cap-add net_admin --cap-add sys_module -p 51820:51820/udp --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.all.forwarding=1 --restart unless-stopped arpitjindal1997/myst-multiarch:wireguard

```
