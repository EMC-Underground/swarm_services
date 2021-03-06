#!/usr/bin/env bash

mkdir -p newcerts

if [ ! -f index.txt ]; then
  touch index.txt
fi

if [ ! -f serial ]; then
  echo '01' > serial
fi

if [ ! -f ca.key ]; then
  openssl genrsa -out ca.key 4096
fi

if [ ! -f ca.crt ]; then
  openssl req -new -x509 -days 3650 -key ca.key -out ca.crt
fi

if [ ! -f norcal.csr ]; then
  openssl req -new -out norcal.csr -config openssl_config.cnf
fi

if [ ! -f norcal.crt ]; then
  openssl ca -config ca.cnf -out norcal.crt -extfile norcal.extensions.cnf -in norcal.csr
fi
