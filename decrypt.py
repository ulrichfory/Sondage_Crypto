from Crypto.PublicKey import RSA
import sys

#lire le fichier a decrypte
with open( sys.argv[1], 'rb') as ef:
	file_t = ef.read()
	ef.close()
	
#creation d´un couple de clés

	
	
	
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


#dechiffrage
x = key[0].decrypt(file_t)

	

with open( sys.argv[2], 'wb') as ef:
	ef.write(x)
	ef.close()


