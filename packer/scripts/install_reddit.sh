#!/bin/bash

cp ~/puma.service /etc/systemd/system/puma.service
sudo apt-get update -yq
sleep 30
apt-get install -yq git policykit-1
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
systemctl daemon-reload
systemctl start puma
systemctl enable puma
rm ~/puma.service
