#!/bin/bash
#apt-get install software-properties-common python-software-properties -y;add-apt-repository ppa:git-core/ppa -y; apt-get update; apt-get install git -y;cd ..;git clone https://github.com/BoredBored/stuff.git;cd stuff;chmod +x *; sh setup.sh

mkdir -p "/var/web-root/www/admin";
mkdir -p "/var/web-root/www/admin/domains";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/rootDomain";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/rootDomain/public";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/sub";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/sub/test.angeletakis.net";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/sub/test.angeletakis.net/public";
mkdir  -p "/var/web-root/www/admin/domains/angeletakis.net/sub/alexios.angeletakis.net";

apt-get update -y;
apt-get install curl php7.0-cli git -y;
apt-get update -y;
apt-get install software-properties-common -y;
add-apt-repository ppa:certbot/certbot -y;
apt-get update -y;
apt-get install python-certbot-apache -y;
apt-get install vim -y;
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer;
goto endOfFireWallInstallationAndSetup # commment out if you don't have a firewall
apt-get install iptables -y;
/sbin/iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP;
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j DROP;
/sbin/iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP;
/sbin/iptables -t mangle -A PREROUTING -f -j DROP;
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set;
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP;
/sbin/iptables -N port-scanning;
/sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN;
/sbin/iptables -A port-scanning -j DROP;
/sbin/iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack;
/sbin/iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460;
/sbin/iptables -A INPUT -m conntrack --ctstate INVALID -j DROP;
:endOfFireWallInstallationAndSetup
echo "Then, when you're ready, do:";
echo "     certbot --apache certonly               (sets up https)";
echo "     certbot renew --dry-run                 (sets up certificate auto renewal)";
echo "     composer require defuse/php-encryption";
echo "     composer require respect/validation";
apt-get upgrade -y;
apt-get update -y;
echo "Done. :)";
