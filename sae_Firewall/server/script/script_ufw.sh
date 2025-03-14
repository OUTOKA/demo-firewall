#!/bin/bash

# Réinitialiser toutes les règles ufw existantes
yes y | ufw reset

# Autoriser le trafic SSH (port 22) depuis l'adresse IP 192.168.56.1 sur le sever
ufw allow from 192.168.56.1 to any port 22

# Autoriser tout le trafic provenant du sous-réseau 192.168.57.0/24 vers n'importe quelle destination
ufw allow from 192.168.57.0/24 to any

# Autoriser le trafic HTTP (port 80) vers le serveur web situé à l'adresse 192.168.58.10 (DMZ)
ufw allow proto tcp from any to 192.168.58.10 port 80

# Autoriser le trafic HTTPS (port 443) vers le serveur web situé à l'adresse 192.168.58.10
ufw allow proto tcp from any to 192.168.58.10 port 443

# Autoriser le trafic du sous-réseau privé 192.168.57.0/24 vers le sous-réseau DMZ 192.168.58.0/24
ufw allow from 192.168.57.0/24 to 192.168.58.0/24

# Autoriser le trafic du client 192.168.57.20 vers le serveur 192.168.57.10 dans le réseau privé
ufw allow from 192.168.57.20 to 192.168.57.10

# Définir les rêgles par défaut pour bloquer tout le trafic entrant non autorisé
ufw default deny incoming

# Définir les rêgles par défaut pour autoriser tout le trafic sortant
ufw default allow outgoing

# Activer ufw
yes y | ufw enable

# Afficher le status en détails des règles ufw
ufw status verbose

