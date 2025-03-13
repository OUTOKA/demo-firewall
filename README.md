### Antoine Didierjean, Hugo Bienvenu

# Mise en place d'un Firewall

## Comparaison des différents types de Firewalls  

| **Type de Firewall** | **Description** | **Avantages** | **Inconvénients** |
|----------------------|----------------|---------------|-------------------|
| **Filtrage de Paquets** | Vérifie les en-têtes des paquets selon des règles prédéfinies. | - Rapide et simple à configurer <br> - Faible consommation de ressources | - Pas d'analyse approfondie du trafic <br> - Facile à contourner par des attaques avancées |
| **Stateful Firewall (A État)** | Suit les connexions réseau et vérifie si un paquet appartient à une connexion légitime. | - Sécurité améliorée par rapport au filtrage simple <br> - Réduit les risques d'attaques par session | - Plus gourmand en ressources <br> - Peut être contourné par des attaques sophistiquées |
| **Proxy Firewall** | Agit comme un intermédiaire entre les utilisateurs et Internet, filtrant les requêtes au niveau application. | - Très sécurisé <br> - Cache les IP internes <br> - Analyse des requêtes en profondeur | - Peut ralentir le trafic <br> - Plus complexe à configurer |
| **NGFW (Next-Generation Firewall)** | Combine firewall traditionnel + IPS (Intrusion Prevention System) + inspection profonde des paquets + contrôle applicatif. | - Protection avancée contre les menaces modernes <br> - Peut analyser le contenu des paquets | - Coût élevé <br> - Configuration plus complexe |
| **Firewall NAT (Network Address Translation)** | Masque les IP internes et gère la communication entre le réseau privé et Internet. | - Sécurise les IP internes <br> - Empêche les connexions non sollicitées | - Pas un vrai firewall (ne filtre pas activement les paquets) |
| **Firewall avec DMZ** | Sépare le réseau interne des services exposés à Internet (ex: serveurs Web, mail). | - Améliore la sécurité des services accessibles publiquement <br> - Évite d'exposer le réseau interne | - Nécessite une configuration rigoureuse <br> - Mauvaise config = faille de sécurité |

---

## Comparaison des différentes marques de Firewalls  

| **Marque** | **Description** | **Avantages** | **Inconvénients** |
|------------|----------------|---------------|-------------------|
| **Fortinet (FortiGate)** | Réputé pour ses firewalls NGFW et UTM (Unified Threat Management). | - Très bon rapport qualité/prix <br> - Interface intuitive <br> - FortiGuard pour les mises à jour en temps réel | - Peut être difficile à configurer pour les débutants |
| **Cisco (ASA & Firepower)** | Leader du marché avec des solutions robustes pour les grandes entreprises. | - Fiabilité et évolutivité <br> - Très sécurisé avec Firepower (IPS, Threat Defense) | - Coût élevé <br> - Interface parfois compliquée |
| **Palo Alto Networks** | Spécialisé dans les NGFW avec un fort accent sur la cybersécurité. | - Filtrage d'application avancé <br> - Intégration avec le cloud et l'IA | - Prix très élevé <br> - Nécessite des compétences techniques avancées |
| **Check Point** | Leader historique dans la cybersécurité avec des firewalls de haute qualité. | - Sécurité avancée (prévention des menaces Zero-Day) <br> - Facile à gérer avec SmartConsole | - Coût élevé <br> - Mise en place parfois complexe |
| **Sophos (XG Firewall)** | Firewall UTM simple à utiliser, parfait pour les PME. | - Interface claire et intuitive <br> - Bon rapport qualité/prix | - Moins puissant que Palo Alto ou Cisco |
| **Juniper (SRX Series)** | Firewall haute performance pour les datacenters et grandes infrastructures. | - Très performant pour les réseaux complexes <br> - Intégration avancée avec les réseaux SD-WAN | - Moins intuitif à configurer <br> - Documentation technique parfois compliquée |
| **pfSense** (Open Source) | Firewall open-source basé sur FreeBSD, très populaire chez les techs. | - Gratuit et ultra personnalisable <br> - Idéal pour les geeks et les labos | - Interface un peu old-school <br> - Pas de support officiel (communauté uniquement) |

---

## Quel Firewall Choisir ?  

**Pour une entreprise avec un budget serré** → Fortinet, Sophos ou pfSense  
**Pour une grande entreprise/Datacenter** → Cisco, Palo Alto, Juniper  
**Si vous voulez du top niveau en cybersécurité** → Palo Alto ou Check Point  
**Si vous cherchez un bon compromis** → Fortinet ou Sophos  
