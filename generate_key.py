from Crypto.PublicKey import RSA
import sys
	

#creation d´un couple de clés
key = RSA.generate(1024)	
	
#afficher ses clés:
k = key.exportKey('PEM')
p = key.publickey().exportKey('PEM')
	
#sauvegarder ses clés dans des fichiers:
with open(sys.argv[1],'w') as kf:
	kf.write(k.decode())
	kf.close()
	
with open(sys.argv[2],'w') as pf:
	pf.write(p.decode())
	pf.close()
		
