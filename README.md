# VPN Server inside Docker

Includes Wireguard and Strongswan

Below are the commands to spawn a container

This is needed because in some VPS `ip6table` mod is not loaded by default
```
modprobe ip6table_filter
modprobe ip6table_nat
```

Run Container using below command
```
ip6tables -t nat -A POSTROUTING -s 2001:3200:3200::/64 ! -o docker0 -j MASQUERADE

docker-compose up -d --force-recreate

```

## Client Configuration

There are 2 VPNs running, so you have flexibility to use of them

### strongSwan

For Desktop, There is inbuilt support for this, so no need to install any app from outside

 - Get LetsEncrypt Auth cert from [here](https://letsencrypt.org/certs/letsencryptauthorityx3.pem)

 - Import it into strongSwan app

 - Fill in proper details in profile, and tick on select cert automatically

 - Click Connect

 ### Wireguard

 - Import the client config

 - Click Connect
