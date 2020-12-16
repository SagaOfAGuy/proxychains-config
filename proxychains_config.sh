#!/bin/bash

# Install proxychains and tor on Linux system 
if [ ! -z $(command -v apt) ]; then sudo apt install proxychains tor -y; fi
if [ ! -z $(command -v dnf) ]; then sudo dnf install proxychains tor -y; fi
if [ ! -z $(command -v yum) ]; then sudo yum install proxychains tor -y; fi
if [ ! -z $(command -v pacman) ]; then sudo pacman -S install proxychains tor -y; fi

# Make proxychains dynamic to support sudden changes of IP addresses
sudo sed -i "s/#dynamic_chain/dynamic_chain/g" /etc/proxychains.conf

# Disable strict chain 
sudo sed -i "s/strict_chain/#strict_chain/g" /etc/proxychains.conf

# Prevent DNS leaks
sudo sed -i "s/# Proxy DNS requests - no leak for DNS data/Proxy DNS requests - no leak for DNS data/g" /etc/proxychains.conf

# Make proxychains operate as socks5 proxy on port 9050
sudo sed -i '$ a\socks5  127.0.0.1 9050' /etc/proxychains.conf 

# start tor service 
sudo service tor start
echo "Tor Service started." 

# Test if IP address has changed
proxychains curl -4 icanhazip.com

# Prompt success
echo "proxychains configuration successful!"

