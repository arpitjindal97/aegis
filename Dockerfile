FROM ubuntu:latest

RUN apt-get update && apt-get install iptables iproute2 wireguard linux-headers-5.4.0-47 linux-headers-5.4.0-47-generic -y

COPY server.conf /etc/wireguard/wg0.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

