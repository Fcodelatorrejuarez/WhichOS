#!/bin/bash 

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Ctrl + c for possible mistakes 

function ctrl_c(){
  echo -e "\n${redColour}[!] Leaving...${endColour}"
  exit 1
}

trap ctrl_c SIGINT

# Enumeration of IP's in your net
firstNumOfIp="$(/sbin/arp-scan -I ens33 --localnet --ignoredups | grep IPv4 | awk '{print $NF}' | awk -F "." '{print $1}')"

ips="$(/sbin/arp-scan -I ens33 --localnet --ignoredups | grep "^$firstNumOfIp" | awk '{print $1}')"

# For loop for describing the Os associated

for ip in $ips; do
  ttl="$(ping -c 1 $ip | grep ttl | awk '{print $6}' | awk -F "=" '{print $2}')"
  if [[ -z "$ttl" ]]; then
    echo -e "\n${grayColour}[?] The ip ($ip) did not respond${endColour}"
  elif [[ $ttl -eq 64 ]];then
    echo -e "\n${grayColour}[+] The ip ${endColour}${greenColour}($ip)${endColour}${grayColour} has${endColour} ${yellowColour}Linux or MacOs${endColour} ${grayColour}as its OS${endColour}" 
  elif [[ $ttl -eq 128 ]]; then
    echo -e "\n${grayColour}[+] The ip ${endColour}${greenColour}($ip)${endColour}${grayColour} has${endColour} ${yellowColour}Windows${endColour} ${grayColour}as its OS${endColour}" 
  elif [[ $ttl -eq 254 ]]; then
    echo -e "\n${grayColour}[+] The ip ${endColour}${greenColour}($ip)${endColour}${grayColour} has${endColour} ${yellowColour}Solaris or AIX${endColour} ${grayColour}as its OS${endColour}" 
  else
    echo -e "\n${grayColour}[?] The ip ($ip) has an irregular ttl${endColour}"
  fi
done
