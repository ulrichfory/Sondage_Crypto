#!/bin/bash

uninstall_daemon()
{
#stopping service
sudo systemctl stop $1
#disabling service
sudo systemctl disable $1

#check if service file exists then delete it
if [ -f /etc/systemd/system/$1 ]
then
	sudo rm -rf /etc/systemd/system/$1
else
	echo "/etc/systemd/system/$1 does not exist"
fi

#check if log folder exists then deleted it
service_name=$(echo $1 | cut -d "." -f 1)
if [ -d /var/log/$service_name ]
then
	sudo rm -rf /var/log/$service_name
else
	echo "/var/log/$service_name not found"
fi

#check if binary exists then delete it
script_name="${service_name}.sh"
if [ -f /bin/$script_name ]
then
        sudo rm -rf /bin/$script_name
else
        echo "/bin/$script_name does not exist"
fi

}


uninstall_daemon crypt.service
uninstall_daemon decrypt.service

INSTALL_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DIR_CLE="${INSTALL_DIR}/key" 
CRYPT="${INSTALL_DIR}/tocrypt"
CRYPTED="${INSTALL_DIR}/crypted"
DECRYPT="${INSTALL_DIR}/todecrypt"
DECRYPTED="${INSTALL_DIR}/decrypted"


crypt=$(ls ${CRYPT})
crypted=$(ls ${CRYPTED})
decrypted=$(ls ${DECRYPTED})
decrypt=$(ls ${DECRYPT})
key=$(ls ${DIR_CLE})

sudo rm -rf ${CRYPT}/${crypt}
sudo rm -rf ${CRYPTED}/${crypted}
sudo rm -rf ${DECRYPTED}/${decrypted}
sudo rm -rf ${DECRYPT}/${decrypt}
sudo rm -rf ${DIR_CLE}/${key}
sudo rm -rf ${DIR_CLE}/${key}

