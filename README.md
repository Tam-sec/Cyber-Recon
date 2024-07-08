#Description
The primary objective of this script is to automate the routine enumeration and reconnaissance tasks, allowing us to concentrate more on the actual penetration testing activities.
This Bash script is designed for advanced penetration testing. It includes functionality to check the presence of essential tools, run different types of Nmap scans, use Feroxbuster for hidden content discovery, and ffuf for web fuzzing. 
Additionally, it can connect to SMB servers using Impacket-smbclient. 
Note: This script is intended for educational and authorized testing purposes only. Unauthorized use is illegal.
```
#Features
Tool Check: Verifies if necessary tools (Nmap, Feroxbuster, ffuf, Impacket-smbclient) are installed.
Nmap Scans: Offers options for Quick Scan and Full Port Scan.
Feroxbuster: Runs content discovery on web servers.
ffuf: Performs web fuzzing and directory discovery.
SMB Connection: Connects to SMB servers using Impacket-smbclient.
Loading Animation: Provides a visual indicator during command execution.

```
#Usage
```
##DISCLAIMER:

This script is for educational and authorized testing purposes only.
Unauthorized use against systems you do not own or have explicit permission to test is illegal.
The user assumes all responsibility for the use of this script.
Please ensure you have proper authorisation before proceeding.
```
#Instructions
Clone the repository:

sh
Copy code
git clone https://github.com/Tam-sec/Cyber-Recon.git
cd Cyber-Recon
Make the script executable:

sh
Copy code
chmod +x cyber.sh
Run the script:

sh
Copy code
./cyber.sh
