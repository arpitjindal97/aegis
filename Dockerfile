FROM ubuntu:latest

RUN apt-get update && apt-get install iptables iproute2 wireguard -y

COPY server.conf /etc/wireguard/wg0.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

