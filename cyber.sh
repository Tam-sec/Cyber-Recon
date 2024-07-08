#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function for loading animation
loading_animation() {
    local duration=$1
    local chars="/-\|"
    local end=$((SECONDS + duration))
    while [ $SECONDS -lt $end ]; do
        for (( i=0; i<${#chars}; i++ )); do
            echo -en "${YELLOW}${chars:$i:1}" "\r${NC}"
            sleep 0.1
        done
    done
    echo -en "\r"
}

# Function to prompt user
prompt_user() {
    local prompt=$1
    local var_name=$2
    read -p "$(echo -e "${CYAN}$prompt: ${NC}")" $var_name
}

# Clear screen and show title
clear
echo -e "${MAGENTA}===================================${NC}"
echo -e "${MAGENTA}   *****Cyber Recon*****           ${NC}"
echo -e "${MAGENTA}===================================${NC}"

# Disclaimer
echo -e "${RED}DISCLAIMER:${NC}"
echo -e "${YELLOW}This script is for educational and authorized testing purposes only.${NC}"
echo -e "${YELLOW}Unauthorized use against systems you do not own or have explicit permission to test is illegal.${NC}"
echo -e "${YELLOW}The user assumes all responsibility for the use of this script.${NC}"
echo -e "${YELLOW}Please ensure you have proper authorization before proceeding.${NC}"
echo

# Ask for confirmation
echo -e -n "${RED}Do you understand and agree to use this script responsibly? (y/n): ${NC}"
read confirm
if [[ $confirm != [yY] ]]; then
    echo -e "${RED}Script execution cancelled.${NC}"
    exit 1
fi

# Ask for the target IP address or domain
prompt_user "Enter the target IP address or domain" target

# Check if nmap is installed
if command_exists nmap; then
    # Ask for the type of scan with Nmap
    echo
    echo -e "${BLUE}Choose an Nmap scan type:${NC}"
    echo -e "${GREEN}1. Quick Scan${NC}"
    echo -e "${GREEN}2. Full Port Scan${NC}"
    prompt_user "Enter your choice" nmap_option

    # Perform the selected Nmap scan
    case "$nmap_option" in
        1)
            echo -e "${YELLOW}Running a quick Nmap scan on $target...${NC}"
            loading_animation 3
            nmap -Pn -sC -sV "$target"
            ;;
        2)
            echo -e "${YELLOW}Running a full port Nmap scan on $target...${NC}"
            loading_animation 3
            nmap -Pn -p- -sC -sV -vv --min-rate 10000 "$target"
            ;;
        *)
            echo -e "${RED}Invalid choice. Defaulting to a quick Nmap scan...${NC}"
            loading_animation 3
            nmap -Pn -sC -sV "$target"
            ;;
    esac
else
    echo -e "${RED}Nmap is not installed. Skipping Nmap scan.${NC}"
fi

# Check if feroxbuster is installed
if command_exists feroxbuster; then
    echo -e "${YELLOW}Running Feroxbuster on $target...${NC}"
    echo -e "${BLUE}TIP: Feroxbuster is a tool for discovering hidden content on web servers.${NC}"
    loading_animation 3
    feroxbuster -u "http://$target"
else
    echo -e "${RED}Feroxbuster is not installed. Skipping Feroxbuster scan.${NC}"
    echo -e "${YELLOW}To install Feroxbuster, visit: https://github.com/epi052/feroxbuster${NC}"
fi

# Check if ffuf is installed
if command_exists ffuf; then
    echo -e "${YELLOW}Running ffuf on $target...${NC}"
    echo -e "${BLUE}TIP: ffuf is used for web fuzzing and directory discovery.${NC}"
    echo -e "${BLUE}     This command will fuzz subdomains of example.com. Adjust as needed.${NC}"
    loading_animation 3
    ffuf -u "http://$target" -H "Host: FUZZ.example.com" -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-20000.txt -mc all -ac
else
    echo -e "${RED}ffuf is not installed. Skipping ffuf scan.${NC}"
    echo -e "${YELLOW}To install ffuf, visit: https://github.com/ffuf/ffuf${NC}"
fi

# Check if impacket-smbclient is installed
if command_exists impacket-smbclient; then
    # Ask for the SMB server to connect with Impacket-smbclient
    echo
    prompt_user "Enter the SMB server to connect with Impacket-smbclient" smb_server

    # Run Impacket-smbclient to connect to the SMB server
    echo -e "${YELLOW}Connecting to $smb_server with Impacket-smbclient...${NC}"
    echo -e "${BLUE}TIP: Impacket-smbclient is used to explore SMB/CIFS shares.${NC}"
    loading_animation 3
    impacket-smbclient "$smb_server"
else
    echo -e "${RED}Impacket-smbclient is not installed. Skipping SMB connection.${NC}"
    echo -e "${YELLOW}To install Impacket tools, visit: https://github.com/SecureAuthCorp/impacket${NC}"
fi

echo
echo -e "${GREEN}Script completed successfully. Thank you for using the script.${NC}"
echo -e "${BLUE}Please visit CyberSecveillance.com for more information.${NC}"
echo
echo -e "${YELLOW}IMPORTANT: Remember to adjust the commands as needed for your specific testing scenario.${NC}"
echo -e "${YELLOW}           Always ensure you have proper authorization before testing any systems.${NC}"
