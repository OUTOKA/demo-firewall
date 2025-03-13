#!/bin/bash

yes y | ufw reset
ufw allow from 192.168.56.1 to any port 22
ufw allow from 192.168.57.0/24 to any
ufw allow proto tcp from any to 192.168.58.10 port 80
ufw allow proto tcp from any to 192.168.58.10 port 443
ufw allow from 192.168.57.0/24 to 192.168.58.0/24
ufw allow from 192.168.57.20 to 192.168.57.10
ufw default deny incoming
ufw default allow outgoing
yes y | ufw enable
ufw status verbose

