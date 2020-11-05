FROM alpine:latest

RUN apk update

RUN apk add iptables ip6tables iproute2 

RUN apk add wireguard-tools wireguard-virt

RUN apk add strongswan

COPY wg0.conf /etc/wireguard/wg0.conf

COPY ipsec.d/fullchain.pem /etc/ipsec.d/certs/
COPY ipsec.d/privkey.pem /etc/ipsec.d/private/
COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

