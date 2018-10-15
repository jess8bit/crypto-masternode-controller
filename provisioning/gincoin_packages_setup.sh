#!/bin/bash
# this script installs all desired packages in the new guest VM

# create dummy desktop file
touch /home/vagrant/Desktop/Please_Wait_Installing_Wallet.desktop
chmod 777 /home/vagrant/Desktop/Please_Wait_Installing_Wallet.desktop
chown vagrant /home/vagrant/Desktop/Please_Wait_Installing_Wallet.desktop

# update repositories
apt-get update && apt-get -y upgrade

# install dependencies
# check https://github.com/kalkulusteam/klks/blob/master/doc/build-unix.md
apt-get -qqy -o=Dpkg::Use-Pty=0 install build-essential g++ lightdm-gtk-greeter \
    protobuf-compiler libboost-all-dev autotools-dev lightdm libprotobuf-dev \
    automake libcurl4-openssl-dev libssl-dev libdb++-dev pwgen git apt-utils \
    pkg-config libcurl3-dev libudev-dev libqrencode-dev bsdmainutils make automake \
    pkg-config libssl-dev libgmp3-dev libevent-dev jp2a pv virtualenv autoconf \
    libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libtool \
    libprotobuf-dev protobuf-compiler qt5-default qt5-qmake qtbase5-dev-tools 


# Berkeley DB	Wallet storage
# add-apt-repository ppa:bitcoin/bitcoin
# apt-get -y update
# apt-get -qqy install libdb4.8-dev libdb4.8++-dev

