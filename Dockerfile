FROM alpine:latest

RUN apk update

RUN apk add iptables ip6tables iproute2 

RUN apk add wireguard-tools wireguard-virt

RUN apk add strongswan
RUN rm /etc/ipsec.conf /etc/ipsec.secrets

## Uncomment them, if you want to create your personalized image
#COPY config/wg/wg0.conf /etc/wireguard/wg0.conf
#COPY config/ipsec/fullchain.pem /etc/ipsec.d/certs/
#COPY config/ipsec/privkey.pem /etc/ipsec.d/private/
#COPY config/ipsec/ipsec.conf /etc/ipsec.conf
#COPY config/ipsec/ipsec.secrets /etc/ipsec.secrets

WORKDIR /root
COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

CMD ["/root/run.sh"]

