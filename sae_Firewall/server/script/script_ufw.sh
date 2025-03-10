#!/bin/bash

ufw default deny incoming
ufw default allow outgoing
ufw logging on
ufw allow from 192.168.56.1 to any port 22
ufw allow from 192.168.56.20 to any port 80
ufw enable
