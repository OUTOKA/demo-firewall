ufw default deny incoming
ufw default deny outgoing
ufw logging on
ufw allow out 22/tcp
ufw allow in 22/tcp
ufw enable
