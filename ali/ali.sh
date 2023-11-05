#!/bin/bash
#REM Etapes 1 generate key pair if it doesnt exists
FILE=aliPrivateKey.pem
if test -f "$FILE"; then
    echo "$FILE already exists."
else 
	openssl genrsa -out aliPrivateKey.pem 1024
	openssl rsa -pubout -in aliPrivateKey.pem -out aliPublicKey.pem
	#REM Etapes 2
	cp aliPublicKey.pem -d ../brahim
	echo "$FILE generated."
fi

#REM Etapes 3
openssl rand -hex 16 > key.bin
#REM Etapes 4
openssl rsautl -encrypt -inkey brahimPublicKey.pem -in key.bin -out enkey.bin
#REM Etapes 5
openssl dgst -sha256 message
#REM Etapes 6
openssl dgst -sign aliPrivateKey.pem -out sign message
#REM Etapes 7
openssl enc -des -base64 -in message -out enmsg -pass file:key.bin
openssl enc -des -base64 -in sign -out ensign -pass file:key.bin
openssl rsautl -encrypt -inkey brahimPublicKey.pem -pubin -in key.bin -out enkey.bin
#REM Etapes 8
cp enmsg ../brahim/messageFromAli
cp ensign ../brahim/ensign
cp enkey.bin ../brahim/enkey.bin
