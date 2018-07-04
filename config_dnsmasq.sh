#!/bin/bash
echo "1. Installing dnsmasq"
brew install dnsmasq
echo "2. Configuring .dev local domains"
mkdir -pv $(brew --prefix)/etc/
echo 'address=/squadlytics.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'