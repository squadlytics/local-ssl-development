# Getting HTTPS to work in your local dev station (OSX)

In order to be as close to possible from prod and avoid wasting time on API/Oauth request not working due to the lack of SSL it's important to use SSL in local development.

This guide will show you how to configure your machine to be able to access the React app and the API over SSL.

## 0. Requirements

- Homebrew
- NPM

## 1. Updating the environment variables in the API and UI apps

We will have the following config:

  - APP API: https://api.squadlytics.dev:3001
  - AUTH API: https://auth.squadlytics.dev:3001
  - React App: https://<sudbdomain>.squadlytics.dev:8090

### Rails backend envs

In your backend repository, edit the `.env` file at the root of your repository and make sure you have the following line:

```
APP_URL=squadlytics.dev:8090
```

Restart the backend using `rails s`

### React app envs

In your React app edit the `.env.local` file at the root of your repository and make sure that you have the following lines:

```
REACT_APP_SQUAD_API_URL=api.squadlytics.dev:3001
REACT_APP_SQUAD_AUTH_URL=auth.squadlytics.dev:3001
REACT_APP_DOMAIN=squadlytics.dev:8090
```

Restart the UI using `npm start`

## 2. Configuring dnsmasq

[dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) can be used to simulate wildcard domains locally. We're using it to be able to map any *.squadlytics.dev address to 127.0.0.1. The steps are copied from https://gist.github.com/ogrrd/5831371.

### Install dnsmasq

Clone this repository and setup dnsmasq (enter your account password when asked).

```
git clone git@bitbucket.org:squadlytics/local-ssl-development.git
cd local-ssl-development
./config_dnsmasq.sh
```

### Add local DNS to search order in System Preferences

You now need to add your localhost as a DNS server to your network settings.

System Preferences > Network > Wi-Fi (or whatever you use) > Advanced... > DNS > add 127.0.0.1 to top of the list.

### Test

Try to ping any subdomaing of squadlytics.dev to make sure that it resolves to 127.0.0.1

```
ping itshouldwork.squadlytics.dev
```

## 3. Configuring local-ssl-proxy

Now that we can use any *.squadlytics.dev domain locally we need a SSL proxy. We will use https://github.com/cameronhunter/local-ssl-proxy for that.

```
npm install -g local-ssl-proxy
```

## Running SSL proxy

Run the proxy using the configuration file in this repo.

```
local-ssl-proxy --config proxy-config.json
```

## 4. Launch Chrome with --ignore-cr

```
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --ignore-certificate-errors &> /dev/null &
```

Go to https://app.squadlytics.dev:8090 and voilà!