#!/bin/bash

# generate a qr code using an aws MFA seed

get-aws-qr(){
    echo -n Enter secret: 
    read -s secret
    qrencode -o "qrcode.png" "otpauth://totp/root?secret=$secret&issuer=aws-opg-shared"
    display qrcode.png
}