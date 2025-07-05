# WhichOS

A simple and effective network scanning tool that identifies operating systems of devices connected to your local network using TTL (Time To Live) values from ping responses.

## Overview

WhichOS is a bash script that automatically discovers devices on your local network and identifies their operating systems based on TTL values returned by ping packets. Different operating systems have characteristic TTL values, making it possible to determine the OS type without invasive scanning techniques.

## How It Works

The script uses a two-step process:

1. **Network Discovery**: Uses `arp-scan` to discover all active IP addresses on the local network
2. **OS Detection**: Pings each discovered IP and analyzes the TTL value to determine the operating system

### TTL Values Reference

| TTL Value | Operating System |
|-----------|------------------|
| 64        | Linux or macOS   |
| 128       | Windows          |
| 254       | Solaris or AIX   |

## Requirements

- Linux-based operating system
- Root privileges (for network scanning)
- `arp-scan` package installed
- `ping` command (usually pre-installed)
- `awk` command (usually pre-installed)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/Fcodelatorrejuarez/WhichOS.git
   cd WhichOS
   ```

2. Make the script executable:
   ```bash
   chmod +x whichOS.sh
   ```

3. Install `arp-scan` if not already installed:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install arp-scan
   
   # CentOS/RHEL/Fedora
   sudo yum install arp-scan
   # or
   sudo dnf install arp-scan
   ```

## Usage

Run the script with root privileges:

```bash
sudo ./whichOS.sh
```

The script will automatically:
- Scan your local network for active devices
- Ping each discovered IP address
- Display the results with color-coded output

## Example Output

```
[+] The ip (192.168.1.100) has Linux or MacOs as its OS
[+] The ip (192.168.1.101) has Windows as its OS
[+] The ip (192.168.1.102) has Solaris or AIX as its OS
[?] The ip (192.168.1.103) did not respond
[?] The ip (192.168.1.104) has an irregular ttl
```

## Features

- **Colorized Output**: Easy-to-read results with color coding
- **Error Handling**: Graceful handling of non-responsive hosts
- **Signal Handling**: Clean exit on Ctrl+C
- **Automatic Network Detection**: Automatically detects your network range
- **Non-invasive**: Uses standard ping packets for OS detection

## Network Interface Configuration

The script is currently configured to use the `ens33` network interface. If your network interface has a different name, you may need to modify line 23 and 25 in the script:

```bash
# Change ens33 to your interface name (e.g., eth0, wlan0, etc.)
firstNumOfIp="$(/sbin/arp-scan -I ens33 --localnet --ignoredups | grep IPv4 | awk '{print $NF}' | awk -F "." '{print $1}')"
```

To find your network interface name:
```bash
ip link show
```

## Important Notes

⚠️ **Security and Legal Considerations**:
- Only scan networks you own or have explicit permission to scan
- Network scanning may trigger security alerts on monitored networks
- Some firewalls may block or alter TTL values
- Results may not be 100% accurate due to network configurations

⚠️ **Technical Limitations**:
- TTL values can be modified by network devices or firewalls
- Some virtualization platforms may alter TTL values
- VPN connections may affect TTL accuracy
- Network latency may occasionally cause false negatives

## Troubleshooting

**"arp-scan: No such file or directory"**
- Install the `arp-scan` package using your distribution's package manager

**"Permission denied"**
- Run the script with `sudo` as network scanning requires root privileges

**"No devices found"**
- Ensure you're connected to a network
- Check if the network interface name is correct in the script
- Verify that other devices are active on the network

## Contributing

Feel free to contribute to this project by:
- Reporting bugs
- Suggesting improvements
- Adding support for additional operating systems
- Improving the network interface detection

## License

This project is open source and available under the [MIT License](LICENSE).
