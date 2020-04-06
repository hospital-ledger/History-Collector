########################
# Author: Tom          #
# Version: 3.0         #
# Go: 1.13.4           #
# Nodejs: v8.9.4       #
# GCC: 7.3.0           #
# Fabric: 2.0.0        #
# Date: 2020-01-23 Thu #
# Descripiton: Environ #
# ment install scripts #
# for hyperledger fabr #
# ic 2.0.0 version.    #
########################

# Scripts # --- start --- #

#!/bin/bash
echo -e "You need be root account and then you can do it."
echo -e "You can input 'su' and then input your key of root account to login with root account."
user=$(whoami)
if [ "$user" == "root" ];
then echo "The user login with root account successfully. It will start."
else echo "You need to login with root account! Exit and then restart this script!"
exit
fi
echo -e "You are $user"
cd /opt
clear 
echo "Step 1/10 Download the packages of the necessary software."
if [ ! -d "/opt/packages" ]; then
    #git clone https://github.com/hospital-ledger/environment.git
    # Use the gitee in China in order to keep a fast speed to download these files.
    git clone https://gitee.com/Hospital-Ledger/packages.git
    else echo -e "The repository has been download, maybe you need to check the version of it."
fi
cd /opt/packages
echo "Step 2/10 Unzip the packages."
if [ ! -d "node-v8.9.4" ]; then
    tar -zxvf node-v8.9.4.tar.gz
fi
echo "Step 3/10 Copy GO files to the system environment."
echo -e "Let's copy the necessary files to the system."
if [ ! -d "/opt/go" ]; then
    cp -r -f ./go /opt
    else echo -e "Directory go has been existed."
fi
echo "Step 4/10 Copy Nodejs files to the system environment."
if [ ! -d "/opt/node-v8.9.4" ]; then
    cp -r -f ./node-v8.9.4 /opt
    else echo -e "Directory node has been existed."
fi
echo "Step 5/10 Copy GCC files to the system environment."
if [ ! -d "/opt/gcc-7.3.0" ]; then
    cp -r -f ./gcc-7.3.0 /opt
    else echo -e "Directory gcc has been existed."
fi
cd /root
echo "Step 6/10 Make the gotoot."
if [ ! -d "gopath" ]; then
    mkdir gopath
fi
cd /opt
echo -e "Step 7/10 Install go 1.13.4 now."
sleep 1
echo "" >> /etc/profile
echo "export GOROOT=/opt/go" >> /etc/profile
echo "export PATH=\$PATH:\$GOROOT/bin" >> /etc/profile
echo "export GOPATH=/root/gopath" >> /etc/profile
source /etc/profile
clear
go version
echo "Step 8/10 Install GCC."
sleep 1
echo -e "Well, let's install the GCC, it may cost a lot of time."
echo -e "Maybe..."
sleep 1
echo -e "Two hours."
sleep 10
cd /opt/gcc-7.3.0
./contrib/download_prerequisites
if [ ! -d "gcc-build-7.3.0" ]; then
    mkdir gcc-build-7.3.0
fi
cd /opt/gcc-7.3.0/gcc-build-7.3.0
../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
make
make install
gcc -v
sleep 1
echo "Step 9/10 Copy necessary lib to system path."
cd /usr/local/lib64
cp -r -f ./libstdc++.so.6.0.24 /usr/lib64
cd /usr/lib64
rm ./libstdc++.so.6
ln -s ./libstdc++.so.6.0.24 libstdc++.so.6
cd /opt
echo "Step 10/10 Install Nodejs v8.9.4."
cd /opt/node-v8.9.4
./configure
make
make install
clear
node -v
npm -v
sleep 10
clear 
echo "Well, there're still some important things to deal with, please wait."
for((i=0;i<100;i++))
do
        clear
        echo "Well, there're still some important things to deal with, please wait.-"
        sleep 0.1
        clear
        echo "Well, there're still some important things to deal with, please wait.\\"
        sleep 0.1
        clear
        echo "Well, there're still some important things to deal with, please wait.|"
        sleep 0.1
        clear
        echo "Well, there're still some important things to deal with, please wait./"
        sleep 0.1
        clear
done
echo -e "Well, it seems to be all done now."
sleep 1
echo -e "Please check with the code under this line."
echo -e "___________________________________________"
echo -e "|go version                               |"
echo -e "|gcc -v                                   |"
echo -e "|node -v                                  |"
echo -e "|npm -v                                   |"
echo -e "|_________________________________________|"
echo -e "Please make sure they install successfully."
sleep 1

# Version Information
# This script last edited by Tom at 11:18 A.M. 2020.02.02 Sun. - Version 2.0 -
# This script last edited by Tom at 10:00 A.M. 2020.02.08 Sat. - Version 3.0 -
