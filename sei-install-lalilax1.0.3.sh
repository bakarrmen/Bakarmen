#!/bin/bash

#Colors
sari="\033[1;33m"
mavi="\033[1;36m"
kirmizi="\033[1;31m"
yesil="\033[1;32m"
f="\033[0m"
mavik="\033[36m"

############################
#Peer Hatası Fix           #
#v1.0-16.06.2022           #
#lalilax                   #
############################

clear
echo -e "${yesil}.__         .__  .__.__                   ${f}"
echo -e "${yesil}|  | _____  |  | |__|  | _____  ___  ___  ${f}"
echo -e "${yesil}|  | \__  \ |  | |  |  | \__  \ \  \/  /  ${f}"
echo -e "${yesil}|  |__/ __ \|  |_|  |  |__/ __ \_>    <   ${f}"
echo -e "${yesil}|____(____  /____/__|____(____  /__/\_ \  ${f}"
echo -e "${yesil}          \/                  \/      \/  ${f}"
echo -e "${yesil}[SEI INSTALL 1.0.3 ]                      ${f}"
sleep 1

#1.0.3b Güncellemesi

cd
rm $HOME/sei -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.3beta
wget -O go1.18.1.linux-amd64.tar.gz https://golang.org/dl/go1.18.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && rm go1.18.1.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version
export PATH=$PATH:$HOME/go/bin
$HOME/.bash_profile 
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
mv $HOME/sei-chain $HOME/sei
systemctl restart seid


clear
echo -e "${yesil}.__         .__  .__.__                   ${f}"
echo -e "${yesil}|  | _____  |  | |__|  | _____  ___  ___  ${f}"
echo -e "${yesil}|  | \__  \ |  | |  |  | \__  \ \  \/  /  ${f}"
echo -e "${yesil}|  |__/ __ \|  |_|  |  |__/ __ \_>    <   ${f}"
echo -e "${yesil}|____(____  /____/__|____(____  /__/\_ \  ${f}"
echo -e "${yesil}          \/                  \/      \/  ${f}"
echo -e "${yesil}[SEI INSTALL 1.0.3]                       ${f}"
echo -e "${yesil}Kurulum Devam Ediyor (Installation in progress) ${f}"
echo -e "${yesil}Kurulum Devam Ediyor (Installation in progress) ${f}"
echo -e "${yesil}Kurulum Devam Ediyor (Installation in progress) ${f}"
sleep 5


# PEER FIX
clear
cd /root/.sei/config
rm -rf addrbook.json
rm -rf config.toml
wget https://raw.githubusercontent.com/lalilax/seipeerfix/main/addrbook.json
wget https://raw.githubusercontent.com/lalilax/seipeerfix/main/config.toml
clear
sed -i -e "s/NODE_ADI/$NODENAME/" config.toml
cd
clear
echo -e "\033[33m ${f} $mavi KONSOL BAŞLATILIYOR... ${f}"
sleep 2
clear
systemctl restart seid

clear
echo -e "${yesil}.__         .__  .__.__                   ${f}"
echo -e "${yesil}|  | _____  |  | |__|  | _____  ___  ___  ${f}"
echo -e "${yesil}|  | \__  \ |  | |  |  | \__  \ \  \/  /  ${f}"
echo -e "${yesil}|  |__/ __ \|  |_|  |  |__/ __ \_>    <   ${f}"
echo -e "${yesil}|____(____  /____/__|____(____  /__/\_ \  ${f}"
echo -e "${yesil}          \/                  \/      \/  ${f}"
echo -e "${yesil}[SEI INSTALL 1.0.3]                       ${f}"
echo -e "${yesil}[YENI SURUM YUKLEND]                      ${f}"
echo -e "${yesil}[NEW VERSION INSTALLED]                   ${f}"
echo -e "${yesil}journalctl -fu seid -o cat                ${f}"