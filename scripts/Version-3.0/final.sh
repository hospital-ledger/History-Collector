########################
# Author: Tom          #
# Version:  - 2.0 -    #
# Fabric: 2.0.0        #
# Date: 2020-01-23 Thu #
# Descripiton: We will #
# prepare for centos7. #
# And then set up the  #
# Hyperledger Fabric.  #
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
if [ ! -d "/opt/go" ]; then
	echo "Error: You need to run the \"second.sh\" before install the fabric."
	exit 0
	exec
	# Notice! The exec may be useless in some platform. I won't alert under this line.
fi
cd /opt/go/src
cd /opt/go/src
if [ ! -d "github.com" ]; then
    mkdir github.com
fi
cd github.com
if [ ! -d "hyperledger" ]; then
    mkdir hyperledger
fi
cd hyperledger
if [ -d "fabric" ]; then 
	rm -r -f fabric
fi
git clone https://gitee.com/Hospital-Ledger/fabric.git
if [ ! -d "/opt/packages" ]; then
	echo "Error: You need to run the \"second.sh\" before install the fabric."
	cd /opt
	git clone https://gitee.com/Hospital-Ledger/packages.git
fi
cd /opt/go/src/github.com/hyperledger/fabric/scripts
if [ -d "fabric-samples" ]; then
	rm -r -f fabric-samples
fi
git clone https://gitee.com/Hospital-Ledger/fabric-samples.git
cd fabric-samples
if [ ! -f "/opt/packages/" ]; then	
	cd /opt
	git clone https://gitee.com/Hospital-Ledger/packages.git
	cd /opt/go/src/github.com/hyperledger/fabric/scripts/fabric-samples
fi
cp /opt/packages/hyperledger-fabric-linux-amd64-2.0.0.tar.gz ./
cp /opt/packages/hyperledger-fabric-ca-linux-amd64-1.4.4.tar.gz ./
if [ ! -d "/opt/scripts" ]; then
	git clone https://github.com/hospital-ledger/scripts.git
	git checkout Version-3.0
fi
if [ -f "bootstrap.sh" ]; then
	rm bootstrap.sh
fi
cd /opt/scripts/
git checkout Version-3.0
cp /opt/scripts/bootstrap.sh /opt/go/src/github.com/hyperledger/fabric/scripts
./bootstrap.sh
cd /opt/go/src/github.com/hyperledger/fabric/scripts/fabric-samples
tar -zxvf ./hyperledger-fabric-linux-amd64-2.0.0.tar.gz -C /usr/
tar -zxvf ./hyperledger-fabric-linux-amd64-2.0.0.tar.gz -C /opt/go/
tar -zxvf ./hyperledger-fabric-ca-linux-amd64-1.4.4.tar.gz -C /usr/
tar -zxvf ./hyperledger-fabric-ca-linux-amd64-1.4.4.tar.gz -C /opt/go/
cd /opt/go/src/github.com/hyperledger/fabric/scripts/fabric-samples/first-network/
./byfn.sh generate
./byfn.sh up
sleep 1
docker ps
echo "Then the first network will shutdown."
./byfn.sh down
docker ps
cd /opt/scripts
git checkout master
echo "Well, all done."
# Version Information
# This script last edited by Tom at 11:18 A.M. 2020.02.02 Sun. - Version 2.0 -
# This script last edited by Tom at 10:00 A.M. 2020.02.08 Sat. - Version 3.0 -
