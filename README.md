### Antoine Didierjean, Hugo Bienvenu

# Mise en place d'un Firewall

## Arborescence repo du projet:
````
demo_firewall
│
└── sae_Firewall
    │
    ├── server
    │   ├── script
    │   ├── nginx
    │   └── nginx_conf
    │
    ├── client
    │   └── script
    │
    └── dmz
        └── nginx
````
### Les répertoires importants:

- /demo_firewall/sae-Firewall/server/script: Répertoire monté avec la VM server qui contient le script de mise en place du firewall
- /demo_firewall/sae-Firewall/server/nginx: Répertoire monté avec la VM server quicontient le index.html pour la page de présentation du serveur web
- /demo_firewall/sae-Firewall/server/nginx_conf: Répertoire monté avec la VM server quicontient le fichier de configuration nginx.conf qui remplace automatiquement le fichier de base moins sécurisé au lancement de la VM
- /demo_firewall/sae-Firewall/client/script: Répertoire monté avec la VM client qui contient le script qui permet de réaliser les tests en lienavec le firewall
- /demo_firewall/sae-Firewall/dmz/nginx_conf: Même répertoire que pour le server monté avec la VM DMZ poure remplacer le fichier de configuration nginx.conf du server public

## Maquette du réseau:

![SAE61 - Schéma](https://github.com/user-attachments/assets/09b862bc-f514-4513-b97e-2854d446fbaa)

# Mise en place d'une solution de firewall avec UFW
## Mode d'emploi:
### Etape 1: Lancement des VM et connexion en ssh
#### Exécuter les commandes suivantes poour plus de mobilité dans 3 terminaux différents (après avoir cloner le repo):

```` cd /demo_firewall/sae-Firewall/server````

````vagrant up````

````vagrant ssh````

```` cd /demo_firewall/sae-Firewall/client````

````vagrant up````

````vagrant ssh````

```` cd /demo_firewall/sae-Firewall/dmz````

````vagrant up````

````vagrant ssh````

(login: vagrant et mdp: vagrant si besoin)

### Etape 2: Lancement des serveurs web

#### Une fois connecté en ssh sur le sever et sur la machine dmz, exécuter la commande suivante:

````sudo sytemctl start nginx````

### Etape 3: Mise en place du firewall

#### Connecté en ssh sur le sever exécuter les commandes suivantes:

````cd script_ufw````

On donne les droits d'exécution sur le script

````chmod +x script_ufw.sh````

On l'exécute avec les droits root

````sudo ./script_ufw.sh````

### Etape 4: Réalisation des tests

#### Connecté en ssh sur la machine client, exécuter les commandes suivantes:

On donne les droits d'exécution sur le script

````chmod +x test_connectivité.sh````

On exécute le script

````./test_connectivité.sh````

Pour visualiser les derniers tests réalisé sur la machine on peut accéder au journal des tests situé dans le fichier scan-result.csv:

````cat scan-result.csv````

Châque tests commence par la date à laquel il a été réalisé et est séparé du test précédent par trois lignes rouges.

## Sécurisation du serveur NGINX:

1. Désactiver le listing des répertoires
Par défaut, Nginx affiche le contenu des répertoires lorsqu’il ne trouve pas de fichier index. Cela peut être un problème de sécurité si vous avez des fichiers sensibles dans vos répertoires. Pour désactiver le listing des répertoires, ajoutez cette ligne à votre fichier de configuration Nginx :

```` autoindex off;````

2. Limiter les requêtes de l’utilisateur
Vous pouvez limiter le nombre de requêtes que les utilisateurs peuvent envoyer à votre serveur pour prévenir les attaques par déni de service (DoS). Voici comment configurer une limite de 10 requêtes par seconde par IP :

````limit_req_zone $binary_remote_addr zone=one:10m rate=10r/s;
server {
    # ... autres paramètres de configuration ...
    location / {
        limit_req zone=one burst=20;
    }
}
````

3. Activer le module HTTP Strict Transport Security (HSTS)
Le HSTS est un en-tête HTTP qui indique aux navigateurs de ne pas envoyer de requêtes sur HTTP à votre site, mais uniquement sur HTTPS. Cela peut être utile pour prévenir les attaques de type man-in-the-middle. Pour activer le HSTS sur votre serveur Nginx, ajoutez cette ligne à votre fichier de configuration :

````add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;````

4. Activer la protection contre les attaques par injection de contenu
Les attaques par injection de contenu sont des techniques qui permettent à un attaquant de pirater votre site ou votre serveur en injectant du code malveillant dans les requêtes envoyées à votre serveur.

Pour protéger contre ces attaques, vous pouvez utiliser le module ngx_http_sub_module de Nginx. Ce module vous permet de configurer des règles qui vont remplacer ou supprimer certains caractères dangereux dans les requêtes envoyées à votre serveur. Voici comment l’utiliser dans votre fichier de configuration Nginx :

````
server {
    # … autres paramètres de configuration …
    location / {
        sub_filter '<script>' '<disabled>';
        sub_filter_once off;
    }
}
````

Cet exemple remplace tous les occurrences de <script> par <disabled> dans les réponses envoyées par votre serveur. Vous pouvez configurer d’autres règles de remplacement pour protéger contre d’autres types d’injections de contenu

#### Toutes ces sécurités ont été mises en place dans le fichier de configuration du server nginx.conf qui remplace le fichier de base dans les VMs server et dmz.

La prochaine étape pour sécuriser le serveur serait de configurer HTTPS sur le server en obtenant un nom de domaine, un certificat ainsi qu'une clé privée.

## Comparaison des différents types de Firewalls

| **Type de Firewall** | **Description** | **Avantages** | **Inconvénients** |
|----------------------|----------------|---------------|-------------------|
| **Filtrage de Paquets** | Examine les en-têtes des paquets en fonction de règles prédéfinies. | - Rapide et simple à configurer <br> - Faible consommation de ressources | - Ne permet pas une inspection approfondie du trafic <br> - Vulnérable aux attaques avancées |
| **Stateful Firewall (À État)** | Suit les connexions réseau et valide si un paquet appartient à une session légitime. | - Sécurité renforcée par rapport au filtrage de paquets <br> - Réduction des risques liés aux attaques par session | - Consommation plus importante de ressources <br> - Peut être contourné par des attaques sophistiquées |
| **Proxy Firewall** | Sert d'intermédiaire entre les utilisateurs et Internet en filtrant les requêtes au niveau applicatif. | - Sécurité élevée <br> - Masque les adresses IP internes <br> - Analyse approfondie des requêtes | - Peut ralentir les performances réseau <br> - Configuration plus complexe |
| **NGFW (Next-Generation Firewall)** | Combine les fonctionnalités d'un pare-feu traditionnel avec un système de prévention des intrusions (IPS), une inspection approfondie des paquets et un contrôle applicatif. | - Protection avancée contre les menaces modernes <br> - Analyse du contenu des paquets | - Coût élevé <br> - Paramétrage plus complexe |
| **Firewall NAT (Network Address Translation)** | Masque les adresses IP internes et gère la communication entre un réseau privé et Internet. | - Sécurise les adresses IP internes <br> - Empêche les connexions non sollicitées | - Ne constitue pas un pare-feu à proprement parler (ne filtre pas activement les paquets) |
| **Firewall avec DMZ** | Segmente le réseau interne des services exposés à Internet (ex : serveurs web, messagerie). | - Sécurise les services accessibles publiquement <br> - Protège le réseau interne contre les attaques externes | - Exige une configuration rigoureuse <br> - Une mauvaise configuration peut engendrer des vulnérabilités |
| **Firewall iptables** | Outil de pare-feu intégré à Linux permettant la gestion avancée des règles de filtrage des paquets. | - Très flexible et puissant <br> - Intégré aux distributions Linux <br> - Gratuit et open-source | - Configuration complexe pour les non-initiés <br> - Maintenance et gestion manuelles requises |

---

## Comparaison des différentes marques de Firewalls

| **Marque** | **Description** | **Avantages** | **Inconvénients** |
|------------|----------------|---------------|-------------------|
| **Fortinet (FortiGate)** | Spécialisé dans les pare-feux NGFW et les solutions de gestion unifiée des menaces (UTM). | - Excellent rapport qualité/prix <br> - Interface ergonomique <br> - Service FortiGuard assurant des mises à jour en temps réel | - Configuration pouvant être complexe pour les débutants |
| **Cisco (ASA & Firepower)** | Référence du marché avec des solutions adaptées aux grandes entreprises. | - Fiabilité et évolutivité <br> - Sécurisation avancée avec Firepower (IPS, Threat Defense) | - Coût élevé <br> - Interface d'administration parfois complexe |
| **Palo Alto Networks** | Leader en cybersécurité avec des pare-feux NGFW de pointe. | - Filtrage applicatif avancé <br> - Intégration avec le cloud et l'intelligence artificielle | - Tarif très élevé <br> - Nécessite une expertise technique pointue |
| **Check Point** | Spécialiste historique des solutions de sécurité réseau. | - Protection avancée contre les menaces Zero-Day <br> - Gestion simplifiée via SmartConsole | - Coût élevé <br> - Déploiement pouvant être complexe |
| **Sophos (XG Firewall)** | Pare-feu UTM convivial, idéal pour les PME. | - Interface intuitive <br> - Bon rapport qualité/prix | - Moins performant que Palo Alto ou Cisco |
| **Juniper (SRX Series)** | Pare-feu haute performance adapté aux datacenters et infrastructures complexes. | - Excellentes performances réseau <br> - Intégration avancée avec les solutions SD-WAN | - Configuration peu intuitive <br> - Documentation technique parfois difficile d'accès |
| **pfSense** (Open Source) | Solution open-source basée sur FreeBSD, très prisée des experts techniques. | - Gratuit et hautement personnalisable <br> - Idéal pour les environnements de test et les laboratoires | - Interface utilisateur vieillissante <br> - Absence de support officiel (communauté uniquement) |

---

## Quel Firewall Choisir ?

- **Pour une entreprise avec un budget restreint** : Fortinet, Sophos ou pfSense  
- **Pour une grande entreprise ou un datacenter** : Cisco, Palo Alto, Juniper  
- **Pour une sécurité maximale** : Palo Alto ou Check Point  
- **Pour un bon compromis entre performance et coût** : Fortinet ou Sophos  
- **Pour un environnement Linux nécessitant un contrôle précis** : iptables   
