#!/bin/bash

apt-get update -yq
sleep 30
apt-get install mongodb -yq
systemctl start mongodb
systemctl enable mongodb
