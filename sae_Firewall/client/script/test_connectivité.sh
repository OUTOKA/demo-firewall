#!/bin/bash

server_dmz="192.168.58.10"
server="192.168.57.10"
client="192.168.57.20"

#nmap -oG test57.txt 192.168.57.0/24
#nmap -oG test58.txt 192.168.58.0/24

echo "#######################################" > "scan-result.csv"
echo "Test ports ouverts pour chaque machines" >> "scan-result.csv"
echo "#######################################" >> "scan-result.csv"

for ip in $( cat test57.txt | grep "$server" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo "Ports ouverts pour $ip:
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

for ip in $( cat test57.txt | grep "$client" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo "Ports ouverts pour $ip:
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

for ip in $( cat test58.txt | grep "$server_dmz" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test58.txt | grep $ip | grep -oP '\d+\/open\/tcp')
  
  echo "Ports ouverts pour $ip: 
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

echo $(cat "scan-result.csv") > "scan-result_final.csv"

# Vérifier que les ports 80 et 443 sont ouverts
if cat "test58.txt" | grep "$server_dmz" | grep -q "80/open"; then
    echo "Test réussi: Port 80 ouvert sur le serveur web." >> "scan-result_final.csv"
else
    echo "Test échoué: Port 80 fermé sur le serveur web." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"
if cat "test58.txt" | grep "$server_dmz" | grep -q "443/open"; then
    echo "Test réussi: Port 443 ouvert sur le serveur web." >> "scan-result_final.csv"
else
    echo "Test échoué: Port 443 fermé sur le serveur web." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"
# Tester la réponse HTTP du serveur web avec curl
echo "Test de la réponse HTTP du serveur web avec curl..." >> "scan-result_final.csv"
if curl -s --head http://$server_dmz/ | grep -q "200 OK"; then
    echo "Test réussi: Réponse HTTP 200 OK sur le port 80." >> "scan-result_final.csv"
else
    echo "Test échoué: Pas de réponse HTTP 200 OK sur le port 80." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"
# Tester la connectivité du client vers le serveur dans le réseau privé avec nmap
echo "Test de la réponse HTTP du serveur web privé avec curl..." >> "scan-result_final.csv"
if curl -s --head http://$server/ | grep -q "200 OK"; then
    echo "Test réussi: Réponse HTTP 200 OK sur le port 80." >> "scan-result_final.csv"
else
    echo "Test échoué: Pas de réponse HTTP 200 OK sur le port 80." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"
# Vérifier que le port 22 (SSH) est accessible depuis le client
if cat "test57.txt" | grep "$sever" | grep -q "22/open"; then
    echo "Test réussi: Port 22 ouvert sur le serveur privé." >> "scan-result_final.csv"
else
    echo "Test échoué: Port 22 fermé sur le serveur privé." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"

# Vérifier que le port 22 (SSH) est accessible depuis le réseau privé vers la DMZ
if cat "test57.txt"| grep "$server" | grep -q "22/open"; then
    echo "Test réussi: Port 22 ouvert sur le serveur web dans la DMZ." >> "scan-result_final.csv"
else
    echo "Test échoué: Port 22 fermé sur le serveur web dans la DMZ." >> "scan-result_final.csv"
fi
echo "#######################################" >> "scan-result_final.csv"
echo "Tests terminés."
echo "#######################################" >> "scan-result_final.csv"
cat "scan-result_final.csv"
