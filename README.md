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
          
## Maquette du réseau:

![SAE61 - Schéma](https://github.com/user-attachments/assets/09b862bc-f514-4513-b97e-2854d446fbaa)


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
