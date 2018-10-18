#!/bin/sh

# SDE
sudo sde reprovision

# NGINX
#sudo yum install epel-release git -y
#git clone https://github.com/letsencrypt/letsencrypt
#cd letsencrypt
#sudo ./letsencrypt-auto --nginx -d "*.dev.dsolab.net" --agree-tos -m cfondop@securitycompass.com -n
# https://serverfault.com/questions/750902/how-to-use-lets-encrypt-dns-challenge-validation

#sudo /root/.local/bin/aws s3api get-object  --bucket ${bucket_name} --key ${fullchain} /etc/sde/.server.crt
#sudo /root/.local/bin/aws s3api get-object  --bucket ${bucket_name} --key ${private_key} /etc/sde/.server.key

#sudo chmod 664 /etc/sde/.server.crt
#sudo chmod 664 /etc/sde/.server.key

# Configure certificate for NGINX
#sudo sed -i 's:/etc/pki/tls/private/sdelements.key:/etc/sde/.server.key:g' /etc/sde/custom.yaml
#sudo sed -i 's:/etc/pki/tls/certs/sdelements.crt:/etc/sde/.server.crt:g' /etc/sde/custom.yaml

# Configure Password for the user
pip install awscli --upgrade --user
sudo rm /docs/sde/log/sdlc.log 2> /dev/null
PASS=$(sudo sde manage_django reset_super_users | head -2 | tail -1)
USER=$(sudo sde manage_django reset_super_users | head -1 | tail -1)

# SSM
sudo /root/.local/bin/aws ssm put-parameter --name ${sde_password} --type SecureString --value "$PASS" --region us-east-1 --overwrite
sudo /root/.local/bin/aws ssm put-parameter --name ${sde_user} --type SecureString --value "$USER" --region us-east-1 --overwrite

sudo sde reprovision
