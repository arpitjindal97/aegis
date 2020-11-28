# VPN Server inside Docker

This repository builds a Docker Image to create your own Personal VPN Server.
Includes Wireguard and strongSwan with IPv6 Support

## Prerequisite

 - Get certificate from Let's Encrypt manually
 - Generate wireguard config with peer config
 - Get ready with `ipsec.secrets` and `ipsec.conf`

This repo contains sample configs but make sure to make changes according to your needs.

Once you have above files, keep them at one place in a folder named `config`

```
$ tree
.
├── config
│   ├── ipsec
│   │   ├── fullchain.pem
│   │   ├── ipsec.conf
│   │   ├── ipsec.secrets
│   │   └── privkey.pem
│   └── wg
│       ├── wg0.conf
│       ├── wg_laptop.conf
│       └── wg_phone.conf
├── config.zip
└── docker-compose.yml

3 directories, 9 files

```

The filenames and drectory structure must be exactly like above. 

You can create a zip of it and keep it somewhere safe.

## Running the Server

Get a Linux system and install `docker-compose` in it.

Execute below commands because in some VPS `ip6table` mod is not loaded by default

```
modprobe ip6table_filter
modprobe ip6table_nat
```

Create any directory inside the machine and keep `config.zip` inside it. 

You can clone this repo also

```
git clone https://github.com/arpitjindal97/vpnserver
cd vpnserver
# place config.zip here
rm -r config
unzip config.zip
```

Run Container
```
## Important to pass IPv6 traffic
ip6tables -t nat -A POSTROUTING -s 2001:3200:3200::/64 ! -o docker0 -j MASQUERADE

docker-compose up -d --force-recreate
```

Whenever you want to make any change in config or cert. You can do the changes in host file system and then
```
docker-compose restart
```

## Client Configuration

There are two VPN services running, so you have flexibility to use any of them

### strongSwan

For Desktop, There is inbuilt support for this, so no need to install any app from outside

For Android:

 - Get LetsEncrypt Auth cert from [here](https://letsencrypt.org/certs/letsencryptauthorityx3.pem)

 - Import it into strongSwan app

 - Fill in proper details in profile, and tick on select cert automatically

 - Click Connect

 ### Wireguard

 - Download application

 - Import the client config

 - Click Connect

Congratulations, You are now a road warrior.

## Building Image

I prefer buildx because it can create docker image for arm processor also. 

```
docker buildx build --no-cache --platform linux/arm64,linux/amd64 -t arpitjindal1997/vpnserver:latest . --push
```

Feel free to create PR and bring in new ideas :)
