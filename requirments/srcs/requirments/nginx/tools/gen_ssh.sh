#!/bin/bash

# Set the domain name
DOMAIN_NAME="salem.42.fr"

# Set the path for the SSL files
SSL_PATH="."

# Create the SSL path if it does not exist
if [ ! -d "$SSL_PATH" ]; then
  mkdir -p "$SSL_PATH"
fi

# Generate a private key
openssl genpkey -algorithm RSA -out "$SSL_PATH/$DOMAIN_NAME.key" -aes256

# Generate a CSR
openssl req -new -key "$SSL_PATH/$DOMAIN_NAME.key" -out "$SSL_PATH/$DOMAIN_NAME.csr" -subj "/CN=$DOMAIN_NAME"
#V0c$13x8^1Gg#hK
# Generate a self-signed certificate
openssl x509 -req -days 365 -in "$SSL_PATH/$DOMAIN_NAME.csr" -signkey "$SSL_PATH/$DOMAIN_NAME.key" -out "$SSL_PATH/$DOMAIN_NAME.crt"
