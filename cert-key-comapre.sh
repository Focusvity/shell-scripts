#!/bin/bash

if ! command -v openssl &> /dev/null; then
	sudo apt-get update
	sudo apt-get install -y openssl
fi

read -p "Enter the path to the certificate file: " cert_path
read -p "Enter the path to the private key: " key_path

cert_md5=$(openssl x509 -noout -modulus -in "$cert_path" | openssl md5)
key_md5=$(openssl rsa -noout -modulus -in "$key_path" | openssl md5)

if [ "$cert_md5" = "$key_md5" ]; then
	echo "Certificate and key matches!"
else
	echo "[x] Certificate and key doesn't match!"
fi
