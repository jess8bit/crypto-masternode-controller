#!/bin/bash
# this script installs all desired packages in the new guest VM

CODENAME="klks"
GIT_URL="https://github.com/kalkulusteam/klks.git"
SCVERSION="tags/v2.5.1"
WALLET_USER="vagrant"
WALLET_DIR="${HOME}/.${CODENAME}"
WALLET_CONF="${WALLET_DIR}/${CODENAME}.conf"
WALLET_BIND="${WALLET_DIR}/bin"
WALLET_BINR="klks_x86-x64_linux_V2.tar.gz"

# create the wallet directory
mkdir -p ${WALLET_BIND}

# check if a binary has been placed in the bin directory
if [ -f /vagrant/bin/${WALLET_BINR} ]; then

	echo "binary release found, don't compile but copy it to it's final destination"
	cp /vagrant/bin/${WALLET_BINR} /tmp && cd /tmp
	tar --strip-components=1 -zxf ${WALLET_BINR}
	cp ${CODENAME}* ${WALLET_DIR}/bin/

# we are building from source
else
	#
	# build the QT5 wallet, ONLY if it doesn't exist yet
	#
	# daemon not found compile it
	if [ ! -f ${WALLET_DIR}/bin/${CODENAME}-qt ]; then
		echo "wallet binary does not exist"
		cd ${HOME} 
		# clone the sources and build from master
		#
		# if code directory does not exists, we create it and clone the src
		if [ ! -d ${CODENAME}-src ]; then                           
			git clone ${GIT_URL} ${CODENAME}-src && cd ${CODENAME}-src
			ls -lah
			git checkout ${SCVERSION}
		# otherwise update	                                     
		else
			echo "* Updating the existing GIT clone"
			cd ${HOME}/${CODENAME}-src       
			git pull
			git checkout ${SCVERSION}                            
		fi

		# build this shit now  
		./autogen.sh
		./configure --disable-dependency-tracking --enable-tests=no --without-miniupnpc --with-incompatible-bdb --prefix=${WALLET_DIR} CFLAGS="-march=native" LIBS="-lcurl -lssl -lcrypto -lz" 
		make
		make install
	fi  

fi

# check if a config template exists and use it
if [ -f /vagrant/conf/${CODENAME}.conf ]; then
  echo "config template exists, copy it to it's final destination"
  cp /vagrant/conf/${CODENAME}.conf ${WALLET_CONF}
fi

echo "rpcuser=$(pwgen 25 1)" >> ${WALLET_CONF}
echo "rpcpassword=$(pwgen 35 1)" >> ${WALLET_CONF}

# change permissions as required
chown -R ${WUSER}:${WUSER} ${WALLET_DIR}

# start the daemon in background 
echo "echo starting klksd"
nohup ${WALLET_BIND}/klksd &
sleep 15


# check if a binary has been placed in the bin directory
if [ ! -f ${HOME}/Desktop/${CODENAME}.desktop ]; then

	cat >${HOME}/Desktop/${CODENAME}.desktop <<-EOL
	[Desktop Entry]
	Version=1.0
	Name=${CODENAME}-qt
	Comment=Masternode Controller Wallet
	GenericName=${CODENAME}-Qt
	Keywords=${CODENAME};Crypto;Masternode;
	Exec=${WALLET_BIND}/${CODENAME}-qt
	Terminal=false
	X-MultipleArgs=false
	Type=Application
	Icon=/vagrant/img/kalkulus.png
	Categories=Network;
	StartupNotify=true
	Actions=start;reindex;help;

	[Desktop Action start]
	Name=start
	Exec=${WALLET_BIND}/${CODENAME}-qt

	[Desktop Action reindex]
	Name=reindex
	Exec=killall ${CODENAME}-qt && ${WALLET_BIND}/${CODENAME}-qt -reindex

	[Desktop Action help]
	Name=masternode setup help
	Exec=/usr/bin/firefox https://masternodes.github.io/vps/
	EOL
fi;

chmod +x ~/Desktop/*.desktop
chown ${WALLET_USER} ~/Desktop/*.desktop

# remove dummy desktop file
rm /home/vagrant/Desktop/Please_Wait_Installing_Wallet.desktop

# run the cli tools to get a masternode privkey
# and deposit address 
COLLATERAL_ADDRESS="$(${WALLET_BIND}/klks-cli getnewaddress \"klks_masternode\")"
MASTERNODE_PRIVKEY="$(${WALLET_BIND}/klks-cli masternode genkey)"

# prefill all available infos in masternode.conf
if [ -f ${WALLET_DIR}/masternode.conf ]; then
  echo "klks_masternode 127.0.0.1:51121 ${MASTERNODE_PRIVKEY} 3741187b3dcf0151587381c3ffe6f6af2d0c5da3bbe4208f78025ddaaae2e939 0" >> ${WALLET_DIR}/masternode.conf
fi

reset
#####
echo "****************************************************"
echo "SETUP FINISHED: "
echo "Please send the 20k collateral to the following address:"
echo "${COLLATERAL_ADDRESS}"
echo "and note the follwing masternode privatekey for your VPS installation in the next step:"
echo "${MASTERNODE_PRIVKEY}"
echo "****************************************************"


echo "stopping klksd again"
kill $(pidof klksd)

echo "Your masternode controller is now ready, please encrypt your wallet!"
