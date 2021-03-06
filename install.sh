#!/bin/bash
CWD=$(pwd)

cd /root

# Update init script
# Reference: http://www.lowepower.com/jason/setting-up-gem5-full-system.html

if [ ! -f gem5-guest-tools-x86.tgz ]; then
    wget http://cs.wisc.edu/~powerjg/files/gem5-guest-tools-x86.tgz
fi
tar xzvf gem5-guest-tools-x86.tgz
mv ${CWD}/gem5-guest-tools.patch /root/
patch -s -p0 < gem5-guest-tools.patch
cd gem5-guest-tools/
sudo ./install
cd /root

apt-get update
apt-get -y install make gcc g++ gfortran

if [ ! -f NPB3.3.1.tar.gz ]; then
      wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
fi
tar xvzf NPB3.3.1.tar.gz

mv ${CWD}/NPB-SER-gem5.patch /root/
patch -s -p0 < NPB-SER-gem5.patch

cd NPB3.3.1/NPB3.3-SER
make suite
