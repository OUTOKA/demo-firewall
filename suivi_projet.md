### Antoine Didierjean, Hugo Bienvenu

# Journal de bord

* Mise en place d'un Firewall
* NOM CHEF DE PROJET : Didierjean
* NOMS AUTRES MEMBRES EQUIPE : Bienvenu
* DATE DEBUT : 03/03/2025


## Séance n° 1

* 03/03/2025 - 13h -> 16h
* Travail effectué :
  - Appropriation du sujet
  - Documentation sur les Firewall, Iptables et Netfilter
  - Découverte de la commande ufw
  - Mise en place repository
  - Première version script création de VM avec Vagrant
  - Début de réalisation de maquette cisco packet tracer
* A faire à la prochaine séance :
  - Finalisation script création de VM
  - Configuration du Firewall
  - Finir la maquette cisco packet tracer
* Difficultés rencontrées : Problème d'accessibilité à des machines linux
* Remarques sur la séances (membre absent, pbe technique, ...) : RAS

## Séance n° 2

* 05/03/2025 - 8h30 -> 11h30 , 14h30 -> 17h30
* Travail effectué :
  - Mise en place Vagrant
  - Fin maquette pkt
  - début modif Vagrantfile client et server
* A faire à la prochaine séance :
  - Finaliser les Vagrantfile
  - Configuration du Firewall
  - Script mise en place du firewall
* Difficultés rencontrées : Fonctionnement de Vagrant, pb pour utiliser Virtualbox
* Remarques sur la séances (membre absent, pbe technique, ...) : RAS

## Séance n° 3

* 06/03/2025 - 13h -> 16h
* Travail effectué :
  - Finalisation Vagrantfile
  - Liaison entre le client et le server
  - début script ufw pour la mise en place du firewall: pour l'instant tout est bloqué sauf le SSH
* A faire à la prochaine séance :
  - Autoriser le SSH seulement depuis l'hôte
  - Finir configuration du Firewall pour créer DMZ
* Difficultés rencontrées : Aucune
* Remarques sur la séances (membre absent, pbe technique, ...) : RAS

## Séance n° 4

* 07/03/2025 - 8h30 -> 11h30
* Travail effectué :
  - Finalisation Vagrantfile
  - Liaison entre le client et le server
  - test ufw pour la mise en place du firewall: modif des permissions pour le ssh.
* A faire à la prochaine séance :
  - Autoriser le SSH seulement depuis l'hôte
  - Finir configuration du Firewall pour créer DMZ
* Difficultés rencontrées : Pb de permissions ufw 
* Remarques sur la séances (membre absent, pbe technique, ...) : Antoine Didierjean abs la majorité de la séance

## Séance n° 5

* 10/03/2025 - 8h30 -> 11h30
* Travail effectué :
  - Configuration ufw pour autoriser le ssh seulement depuis l'hôte et permettre au client d'accéder au serveur web uniquement
  - modif git pour avoir les bons dossiers
  - Ajout de nmap dans le Vagrantfile
  - Premier tests avec Nmap
  - modif script ufw 
* A faire à la prochaine séance :
  - Déterminer les failles liées à NGINX
  - Finir script mise en place du firewall
  - script test d'intrusion pour démonstration firewall
* Difficultés rencontrées : Aucune
* Remarques sur la séances (membre absent, pbe technique, ...) : RAS

## Séance n° 6

* 11/03/2025 - 8h30 -> 11h30
* Travail effectué :
  - Sécurisation serveur web
  - Création d'un fichier monter entre la machine hote et la vm pour garder la configuration du serveur web
  - Etude des failles de sécurité d'un serveur web
* A faire à la prochaine séance :
  - DMZ
  - Finir script mise en place du firewall
  - script test d'intrusion pour démonstration firewall
* Difficultés rencontrées : Problème lors de la relance du serveur web
* Remarques sur la séances (membre absent, pbe technique, ...) : RAS
