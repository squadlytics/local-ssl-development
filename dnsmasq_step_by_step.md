# Never touch your local /etc/hosts file in OS X again

> To setup your computer to work with *.dev domains, e.g. project.dev, awesome.dev and so on, without having to add to your hosts file each time.

## Requirements

* [Homebrew](http://mxcl.github.io/homebrew/)
* Mountain Lion

## Install
```
brew install dnsmasq
```

## Setup

### Create config directory
```
mkdir -pv $(brew --prefix)/etc/
```

### Setup *.dev

```
echo 'address=/squadlytics.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
```

You should probably add `strict-order` to `dnsmasq.conf` to keep nameserver order of `resolv.conf` ([see here](https://gist.github.com/drye/5387341)).

## Autostart

### Work after reboot
```
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
```

### Get it going right now
```
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
```

## Add to resolvers

### Create resolver directory
```
sudo mkdir -v /etc/resolver
```

### Add your nameserver to resolvers
```
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
```

## Add local DNS to search order in System Preferences

System Preferences > Network > Wi-Fi (or whatever you use) > Advanced... > DNS > add 127.0.0.1 to top of the list.

## Finished

That's it! You can run scutil --dns to show all of your current resolvers, and you should see that all requests for a domain ending in .dev will go to the DNS server at 127.0.0.1