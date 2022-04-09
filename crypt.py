from Crypto.PublicKey import RSA
import sys
	

#lire le fichier a crypter
with open(sys.argv[1],'rb') as fl:
	file_t = fl.read()
	fl.close()
	
#importer des clés à partir d'un fichier
with open(sys.argv[3],'r') as fk:
	priv = fk.read()
	fk.close()
	
with open(sys.argv[4],'r') as fp:
	pub = fp.read()
	fp.close()


#key 	
privat = RSA.importKey(priv)
public = RSA.importKey(pub)

key = (privat, public)
	
#chiffrage
public_key = key[0].publickey()
enc_data = public_key.encrypt(file_t, len(file_t))
	
with open( sys.argv[2], 'wb') as ef:
	ef.write(enc_data[0])
	ef.close()

