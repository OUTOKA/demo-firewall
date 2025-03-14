#!/bin/bash
# adresses IP des différentes machines à tester
server_dmz="192.168.58.10"
server="192.168.57.10"
client="192.168.57.20"

#scan avec NMAP avec renvoi greppable dans des fichiers temporaires.
nmap -oG test57.txt 192.168.57.0/24
nmap -oG test58.txt 192.168.58.0/24

echo -e "\e[31m


#######################################
#######################################
#######################################\e[0m" >> "scan-result.csv"
echo -e "\e[34mTest du $(date)\e[0m" >> "scan-result.csv"

echo "
#######################################" >> "scan-result.csv"
echo -e "\e[34mTest ports ouverts\e[0m" >> "scan-result.csv"
echo "#######################################" >> "scan-result.csv"

# Test ports ouverts pour le server privé.
for ip in $( cat test57.txt | grep "$server" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo -e "\e[34m
Ports ouverts pour $ip:\e[0m
$open_ports_tcp" >> "scan-result.csv"
  echo "
#######################################" >> "scan-result.csv"
done

# Test ports ouverts pour le client.
for ip in $( cat test57.txt | grep "$client" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo -e "\e[34m
Ports ouverts pour $ip:\e[0m
$open_ports_tcp" >> "scan-result.csv"
  echo "
#######################################" >> "scan-result.csv"
done

# Test ports ouverts pour le server public.
for ip in $( cat test58.txt | grep "$server_dmz" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test58.txt | grep $ip | grep -oP '\d+\/open\/tcp')
  
  echo -e "\e[34m
Ports ouverts pour $ip:\e[0m 
$open_ports_tcp" >> "scan-result.csv"
  echo "
#######################################" >> "scan-result.csv"
done

echo -e "\e[34mTests individuels.\e[0m" >> "scan-result.csv"
echo "#######################################
" >> "scan-result.csv"


# Vérifier que les ports 80 et 443 sont ouverts
echo -e "\e[34mVérifier que les ports 80 et 443 sont ouverts sur le sever web.
\e[0m" >> "scan-result.csv"
if cat "test58.txt" | grep "$server_dmz" | grep -q "80/open"; then
    echo "Test réussi: Port 80 ouvert sur le serveur web." >> "scan-result.csv"
else
    echo "Test échoué: Port 80 fermé sur le serveur web." >> "scan-result.csv"
fi
echo "" >> "scan-result.csv"
if cat "test58.txt" | grep "$server_dmz" | grep -q "443/open"; then
    echo "Test réussi: Port 443 ouvert sur le serveur web." >> "scan-result.csv"
else
    echo "Test échoué: Port 443 fermé sur le serveur web." >> "scan-result.csv"
fi
echo "
#######################################
" >> "scan-result.csv"
# Tester la réponse HTTP du serveur web avec curl
echo -e "\e[34mTest de la réponse HTTP du serveur web avec curl
\e[0m" >> "scan-result.csv"
if curl -s --head http://$server_dmz/ | grep -q "200 OK"; then
    echo "Test réussi: Réponse HTTP OK sur le port 80." >> "scan-result.csv"
else
    echo "Test échoué: Pas de réponse HTTP OK sur le port 80." >> "scan-result.csv"
fi
echo "
#######################################
" >> "scan-result.csv"
# Tester la connectivité du client vers le serveur dans le réseau privé avec curl
echo -e "\e[34mTest de la réponse HTTP du serveur web privé avec curl
\e[0m" >> "scan-result.csv"
if curl -s --head http://$server/ | grep -q "200 OK"; then
    echo "Test réussi: Réponse HTTP OK sur le port 80." >> "scan-result.csv"
else
    echo "Test échoué: Pas de réponse HTTP OK sur le port 80." >> "scan-result.csv"
fi
echo "
#######################################
" >> "scan-result.csv"
# Vérifier que le port 22 (SSH) est accessible depuis le client
echo -e "\e[34mVérifier que le port 22 (SSH) est accessible depuis le client sur le server privé
\e[0m" >> "scan-result.csv"
if cat "test57.txt" | grep "$sever" | grep -q "22/open"; then
    echo "Test réussi: Port 22 ouvert sur le serveur privé." >> "scan-result.csv"
else
    echo "Test échoué: Port 22 fermé sur le serveur privé." >> "scan-result.csv"
fi
echo "
#######################################
" >> "scan-result.csv"

# Vérifier que le port 22 (SSH) est accessible depuis le réseau privé vers la DMZ
# Écrire le texte en bleu dans le fichier scan-result.csv
echo -e "\e[34mVérifier que le port 22 (SSH) est accessible depuis le client sur le serveur public\e[0m" >> scan-result.csv

if cat "test58.txt"| grep "$server_dmz" | grep -q "22/open"; then
    echo "Test réussi: Port 22 ouvert sur le serveur web dans la DMZ." >> "scan-result.csv"
else
    echo "Test échoué: Port 22 fermé sur le serveur web dans la DMZ." >> "scan-result.csv"
fi
echo "
#######################################" >> "scan-result.csv"
echo -e "\e[34mTests terminés.\e[0m" >> "scan-result.csv" 
echo "#######################################" >> "scan-result.csv"
cat "scan-result.csv"

rm "test57.txt"
rm "test58.txt"
