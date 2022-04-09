#!/bin/bash

install_service() 
{
#get service name
service_name=$(echo "$1" | cut -d "." -f 1)
#get script name
script_name="${service_name}.sh"

#copy service file if not exists
if [ ! -f /etc/systemd/system/$service_name ]
then
	sudo cp $2/service/$1 /etc/systemd/system/
else
	echo "$service_name file already exist, please check"
fi


#copy script if not exists
if [ ! -f /bin/$script_name ]
then
	sudo cp $2/src/$script_name /bin/

else
	echo "$script_name already exists, please check"
fi

#create log folder if not exists
if [ ! -d /var/log/$service_name ]
then
	sudo mkdir /var/log/$service_name
else
	echo "log folder already exists"
fi

#activating the service
sudo systemctl enable $1
#start the service
sudo systemctl start $1

}


INSTALL_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


install_service crypt.service $INSTALL_DIR
install_service decrypt.service $INSTALL_DIR
