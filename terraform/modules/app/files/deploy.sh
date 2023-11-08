#!/bin/bash

sudo mv /tmp/puma.service /etc/systemd/system/puma.service

sudo apt-get update -yq
echo Waiting for apt-get update to finish...
a=1; while [ -n "$(pgrep apt-get)" ]; do echo $a; sleep 1s; a=$(expr $a + 1); done
echo apt-get update done.

sudo apt-get install -yq git policykit-1
echo Waiting for apt-get install to finish...
a=1; while [ -n "$(pgrep apt-get)" ]; do echo $a; sleep 1s; a=$(expr $a + 1); done
echo apt-get install done.

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sudo systemctl daemon-reload
sudo systemctl start puma
sudo systemctl enable puma
