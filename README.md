# WhichOS

A bash script that identifies operating systems on your network through TTL (Time To Live) analysis. This tool scans your local network and determines the likely operating system of each discovered device based on their TTL values from ping responses.

**⚠️ Important: This script requires administrator/root privileges to function properly.**

## Features

- **Network Discovery**: Automatically discovers devices on your local network using ARP scanning
- **OS Detection**: Identifies operating systems based on TTL values:
  - TTL 64: Linux or macOS
  - TTL 128: Windows
  - TTL 254: Solaris or AIX
- **Colorized Output**: Easy-to-read colored terminal output for better visibility
- **Non-responsive Device Detection**: Identifies devices that don't respond to ping requests
- **Graceful Exit**: Proper handling of Ctrl+C interruption

## Requirements

### Dependencies
- **Bash**: Shell interpreter (usually pre-installed on Linux/macOS)
- **arp-scan**: Network discovery tool for ARP scanning
- **ping**: Network connectivity testing tool (usually pre-installed)

### Installation of Dependencies

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install arp-scan
```

#### CentOS/RHEL/Fedora
```bash
# For CentOS/RHEL
sudo yum install arp-scan
# For Fedora
sudo dnf install arp-scan
```

#### macOS
```bash
# Using Homebrew
brew install arp-scan
```

#### Arch Linux
```bash
sudo pacman -S arp-scan
```

## Usage

### 1. Clone the Repository
```bash
git clone https://github.com/Fcodelatorrejuarez/WhichOS.git
cd WhichOS
```

### 2. Make the Script Executable
```bash
chmod +x whichOS.sh
```

### 3. Run the Script
```bash
sudo ./whichOS.sh
```

### Example Output
```
[+] The ip (192.168.1.1) has Windows as its OS
[+] The ip (192.168.1.10) has Linux or MacOs as its OS
[+] The ip (192.168.1.15) has Windows as its OS
[?] The ip (192.168.1.20) did not respond
[?] The ip (192.168.1.25) has an irregular ttl
```

## Notes

### Network Interface Customization
The script uses `ens33` as the default network interface. This may vary depending on your system configuration:
- **Modern Linux systems**: Often use `ens33`, `enp0s3`, or similar
- **Older Linux systems**: May use `eth0`, `eth1`, etc.
- **Virtual machines**: Commonly use `ens33` or `enp0s3`

To modify the network interface, edit line 23 and 25 in the script:
```bash
# Change ens33 to your network interface name
firstNumOfIp="$(/sbin/arp-scan -I YOUR_INTERFACE --localnet --ignoredups | grep IPv4 | awk '{print $NF}' | awk -F "." '{print $1}')"
ips="$(/sbin/arp-scan -I YOUR_INTERFACE --localnet --ignoredups | grep "^$firstNumOfIp" | awk '{print $1}')"
```

You can find your network interface name using:
```bash
ip addr show
# or
ifconfig
```

### Accuracy and Limitations
- **TTL-based detection**: This method provides educated guesses based on default TTL values and may not be 100% accurate
- **Network modifications**: TTL values can be modified by network administrators or security tools
- **Router/firewall interference**: Some network devices may modify TTL values
- **Custom OS configurations**: Non-standard TTL configurations may result in incorrect identification
- **Network topology**: The script works best on local network segments

### Why Root/Administrator Privileges?
- **arp-scan**: Requires raw socket access to send ARP packets
- **Network interface access**: Low-level network operations need elevated privileges
- **System network tools**: Direct access to network interfaces requires administrative rights

## Disclaimer

This tool is intended for educational and legitimate network administration purposes only. Users are responsible for ensuring they have proper authorization before scanning any network. 

**Legal and Ethical Considerations:**
- Only use this tool on networks you own or have explicit permission to scan
- Unauthorized network scanning may violate local laws and regulations
- Always comply with your organization's IT policies and applicable laws
- The authors are not responsible for any misuse of this tool
