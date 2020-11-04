FROM alpine:latest

RUN apk update && apk add iptables iproute2 wireguard-tools wireguard-virt

COPY server.conf /etc/wireguard/wg0.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

