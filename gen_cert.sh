#/bin/bash

touch openssl-ca.cnf

cat ca.cfg > openssl-ca.cnf

openssl req -x509 -config openssl-ca.cnf -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM

printf "Generated cacertficate:-\n"

openssl x509 -in cacert.pem -text -noout
openssl x509 -purpose -in cacert.pem -inform PEM

touch openssl-server.cnf

cat cert.cfg > openssl-server.cnf

openssl req -config openssl-server.cnf -newkey rsa:2048 -sha256 -nodes -out servercert.csr -outform PEM

printf "Generated certificate signing request:-\n"

openssl req -text -noout -verify -in servercert.csr

cat ca2.cfg >> openssl-ca.cnf

touch index.txt

echo '01' > serial.txt

openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out servercert.pem -infiles servercert.csr

openssl x509 -in servercert.pem -text -noout
