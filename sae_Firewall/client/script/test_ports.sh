#!/bin/bash

nmap -oG test57.txt 192.168.57.0/24
nmap -oG test58.txt 192.168.58.0/24

echo "#######################################" > "scan-result.csv"
echo "Test ports ouverts pour chaque machines" >> "scan-result.csv"
echo "#######################################" >> "scan-result.csv"

for ip in $( cat test57.txt | grep "192.168.57.10" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo "Ports ouverts pour $ip:
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

for ip in $( cat test57.txt | grep "192.168.57.20" | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test57.txt | grep $ip | grep -oP '\d+\/open\/tcp' )
  
  echo "Ports ouverts pour $ip:
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

for ip in $( cat test58.txt | grep "192.168.58.10\ " | awk '{print $2}' | uniq); do
  open_ports_tcp=$(cat test58.txt | grep $ip | grep -oP '\d+\/open\/tcp')
  
  echo "Ports ouverts pour $ip: 
$open_ports_tcp" >> "scan-result.csv"
  echo "#######################################" >> "scan-result.csv"
done

cat "scan-result.csv"
