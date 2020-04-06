########################
# Author: Tom          #
# Version:  - 3.0 -    #
# Fabric: 2.0.0        #
# Date: 2020-01-23 Thu #
# Descripiton: We will #
# prepare for centos7. #
# And then set up the  #
# Hyperledger Fabric.  #
########################


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

if [ ! -d "/opt/go/src/github.com/hyperledger/fabric" ]; then
	echo -e "Error: You need to run other scripts first."
	exit 0
	exec
fi
cd /opt/go/src/github.com/hyperledger/fabric
make
echo "Well, all done."
