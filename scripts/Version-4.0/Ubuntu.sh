# Install packages for Ubuntu 18.04.3 LTS
# | - Version-4.0 - |
#!/bin/bash

name="Ubuntu.sh"
timestamp=$(date)
# Judge the account of the user.
mkdir /opt/install-log
echo -e "You need be root account and then you can do it."
echo -e "You can input 'su' and then input your key of root account to login with root account."
user=$(whoami)
echo "$user try to run the script $name at $timestamp." >> /opt/install-log/operations.txt
if [ "$user" == "root" ];
then echo "The user login with root account successfully. It will start."
else echo "You need to login with root account! Exit and then you can restart this script!"
     echo "$user failed to run the scripts $name at $timestamp." >> /opt/install-log/operations.txt
exit
fi
echo -e "$user run the script $name at $timestamp." >> /opt/install-log/operations.txt

# Update the packages of apt.
sudo apt upgrade -y
sudo apt update -y
sudo apt-get upgrade -y
sudo apt-get update -y

sudo apt install python3 -y 
sudo apt install python3-pip -y
sudo apt install docker.io -y

# Record the log.
date=$(date)
echo "$name done at ${date}." >> /opt/install-log/operations.txt

# Date 2020-02-23 10:41 Sun by Tom. |- Version 4.0 -|  
