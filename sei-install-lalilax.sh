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

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

clear
echo -e "${yesil}.__         .__  .__.__                   ${f}"
echo -e "${yesil}|  | _____  |  | |__|  | _____  ___  ___  ${f}"
echo -e "${yesil}|  | \__  \ |  | |  |  | \__  \ \  \/  /  ${f}"
echo -e "${yesil}|  |__/ __ \|  |_|  |  |__/ __ \_>    <   ${f}"
echo -e "${yesil}|____(____  /____/__|____(____  /__/\_ \  ${f}"
echo -e "${yesil}          \/                  \/      \/  ${f}"
echo -e "${yesil}[SEI INSTALL 1.0.2]                       ${f}"
sleep 1

if [ ! $NODENAME ]; then
read -p "${yesil}Node Adı (Node Name): ${f}" NODENAME
echo 'export NODENAME='\"${NODENAME}\" >> $HOME/.bash_profile
fi
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile
sleep 1
cd $HOME
echo "export CHAIN_ID=sei-testnet-2" >> $HOME/.bash_profile
sudo apt update
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo -e '\n\e[42mGo\e[0m\n' && sleep 1
cd $HOME
wget -O go1.18.1.linux-amd64.tar.gz https://golang.org/dl/go1.18.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && rm go1.18.1.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

echo -e '\n\e[42mSEI\e[0m\n' && sleep 1
rm -rf $HOME/sei-chain
git clone --depth 1 --branch 1.0.2beta https://github.com/sei-protocol/sei-chain.git
cd sei-chain && make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid

sleep 1

mv $HOME/go/bin/seid /usr/local/bin/
mv $HOME/sei-chain $HOME/sei
mv $HOME/.sei-chain $HOME/.sei

sleep 1


# config
seid config chain-id $CHAIN_ID
seid config keyring-backend file

# init
seid init $NODENAME --chain-id $CHAIN_ID

# download genesis and addrbook
wget -qO $HOME/.sei/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-testnet-2/genesis.json"
wget -qO $HOME/.sei/config/addrbook.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-testnet-2/addrbook.json"

# set minimum gas price
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0usei\"/" $HOME/.sei/config/app.toml
# set peers and seeds
SEEDS=""
PEERS="585727dac5df8f8662a8ff42052a9584a1f7ee95@165.22.25.77:26656,2f047e234cb8b99fe8b9fee0059a5bc45042bc97@95.216.84.188:26656,bab4849cf3918c37b04cd3714984d1765616a4b2@49.12.76.255:36656,ab955dc7f70d8613ab4b554868d4658fd70b797b@217.79.180.194:26656,39c4bcaded0d1d886f2788ae955f1939406f3e7d@65.108.198.54:26696,9db58dba3b6354177fb428caccf5167c616ad4a1@167.235.28.18:26656,2f2804434afda302c86eb89eca27503e49a8a260@65.21.131.215:26696,38b4d78c7d6582fb170f6c19330a7e37e6964212@194.163.189.114:46656,7c5ee0d66a15013f0a771055378c5316331f17ba@95.216.101.84:25646,6f71bcbe347069fc4df9b607f6b843226e8deb71@95.217.221.201:26656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sei/config/config.toml

# enable prometheus
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.sei/config/config.toml

# config pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei/config/app.toml

sleep 1

echo -e '\n\e[42mservis\e[0m\n' && sleep 1

seid unsafe-reset-all


# create service
tee $HOME/seid.service > /dev/null <<EOF
[Unit]
Description=seid
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which seid) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/seid.service /etc/systemd/system/

# start service
sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid

clear

echo -e "${yesil}Kurulum Devam Ediyor (Installation in progress) ${f}" && echo -e "${yesil}Kurulum Devam Ediyor (Installation in progress) ${f}" && sleep 8


# PEER FIX
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
echo -e "${yesil}[SEI INSTALL 1.0.2]                       ${f}"
echo -e "${yesil}[NODE DURUMU(STATUS)]                     ${f}"
if [[ `service seid status | grep active` =~ "running" ]]; then
echo -e "${yesil}[NODE AKTIF(STATUS)]                      ${f}"
echo -e "${yesil}[NODE AKTIF(STATUS)]                      ${f}"
echo -e "${yesil}journalctl -fu seid -o cat                ${f}"
else
echo -e "${kirmizi}[NODE CALISMIYOR(NOT WORKING)]          ${f}"
fi

