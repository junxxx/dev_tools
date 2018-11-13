#!/bin/bash
openssl genrsa -out rsa_2048_priv.pem 2048
openssl rsa -pubout -in rsa_2048_priv.pem -out rsa_2048_pub.pem
