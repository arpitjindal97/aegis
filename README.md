# Aegis VPN

Aegis VPN is a docker image to deploy your own Personal VPN Server. You must have stummbled upon the idea of having a personal VPN and then let it go in vain because of complexity involed, Aegis does pretty good job without hassle.

### Features

 - [Wireguard](https://www.wireguard.com/)
 - [strongSwan](https://strongswan.org/) (IPsec/IKEv2 EAP)
 - [IPv6](https://en.wikipedia.org/wiki/IPv6) Support
 - Knowledge about Linux and [Docker](https://www.docker.com/)

## Prerequisite :pushpin:

 - Get certificate from [Let's Encrypt](https://letsencrypt.org/) using [Certbot](https://certbot.eff.org/)
 - Generate wireguard config with peer config
 - Get ready with `ipsec.secrets` and `ipsec.conf`

This repo also contains sample configs but make sure to make changes according to your needs.

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

The filenames and directory structure must be exactly like above. 

You can create a zip of it and keep it somewhere safe.

## Deploying the Aegis :rocket:

Get a Linux server and install `docker-compose` in it.

Execute below commands because in some VPS `ip6table` mod is not loaded by default

```
modprobe ip6table_filter
modprobe ip6table_nat
```

Create any directory inside the machine and keep `config.zip` inside it. 

You can clone this repo as well

```
git clone https://github.com/arpitjindal97/vpnserver
cd vpnserver
# place config.zip here
rm -r config
unzip config.zip
```

Run Aegis
```
## Important to pass IPv6 traffic
ip6tables -t nat -A POSTROUTING -s 2001:3200:3200::/64 ! -o docker0 -j MASQUERADE

docker-compose up -d --force-recreate
```

Whenever you want to make any change in config or cert. You can do the changes in host file system and then
```
docker-compose restart
```

## Client Configuration :lock:

There are two VPN services running, so you have flexibility to use any of them

### strongSwan

For Desktop, There is inbuilt support for this, so no need to install any app from outside

For Mobile:

 - Download application from [here](https://www.wireguard.com/install/)

 - Get LetsEncrypt Auth cert from [here](https://letsencrypt.org/certs/letsencryptauthorityx3.pem)

 - Import it into strongSwan app

 - Fill in proper details in profile, and tick on select cert automatically

 - Click Connect

 ### Wireguard

 - Download application from [here](https://www.wireguard.com/install/)

 - Import the client config

 - Click Connect

Congratulations :handshake: , You are now a road warrior.

## Building Aegis :hammer_and_wrench:

I prefer buildx because it can create docker image for arm processor also. 

```
docker buildx build --no-cache --platform linux/arm64,linux/amd64 -t arpitjindal1997/aegis:latest . --push
```

Feel free to create PR and bring in new ideas :heart:
