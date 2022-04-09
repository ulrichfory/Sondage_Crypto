#!/bin/bash




#variables modifiables par l'utilisateur

DIR="/home/tinasoady/crypto_project"
CLE_PR="private.pem"
CLE_PU="public.pem"
SUFFIX_CR=".crypt"
MESS_DRC="message_decrypt.txt"
SUFFIX_DCR=".decrypt"
DIR_CLE="/home/crypto_project/key" 
DECRYPT="/home/crypto_project/todecrypt"
DECRYPTED="/home/crypto_project/decrypted"
CRYPTED="/home/crypto_project/crypted"




	#verification si  les clés sont déjà générées
key=1
if [ -f ${DIR_CLE}/${CLE_PR} ] && [ -f ${DIR_CLE}/${CLE_PU} ]
then
	key=0
fi
	
if [ $key -eq 0 ]
then
	#DECRYPTAGE
	while IFS=$'\n' read file
        do
		if   [ -f $file ]
		then
			echo " faire un cryptage svp" 
			break
		fi
		decrypt=0
		while IFS=$'\n' read file_dec 
		do
			if ! [ -f $file_dec ]
			then
				echo "le fichier est deja decrypter: $file_dec" 
				break
			fi
			 
              		decrypt=0
                	while IFS=$'\n' read decrypt_file
                	do
                		if   [ -f $decrypt_file ]
                       	then
                       		echo "le fichier est deja decrypter:  $decrypt_file"
                       	else
                       		CRYPT_FILE="${file:0:-${#SUFFIX_CR}}"
                        		DECRYPT_FILE="${decrypt_file:0:-${#SUFFIX_DCR}}"
                                	if [[ "$DECRYPT_FILE" = "$CRYPT_FILE" ]]
                               	 then
                                        	decrypt=1
                                        fi
                       	fi
			done <<<$(ls ${DECRYPT}/)
		 done <<<$(ls ${DECRYPTED}/)
                if [ $decrypt -eq 1 ]
                then
                        echo "decryptage"
                        decrypt_file=$(ls ${DECRYPT}/)
                        #Execution de decrypt.py
                        python3 ${DIR}/src/decrypt.py ${DECRYPT}/${decrypt_file} ${DECRYPTED}/${MESS_DRC} ${DIR_CLE}/${CLE_PR} ${DIR_CLE}/${CLE_PU}

                fi
	done <<<$(ls ${CRYPTED}/)
fi
