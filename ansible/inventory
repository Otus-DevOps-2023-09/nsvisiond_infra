#!/bin/bash

if [ "$1" == "--list" ]; then
json=$(cat inventory.json.tpl)
cd ../terraform/stage/ || exit
app_ip=$(terraform output external_ip_address_app)
db_ip=$(terraform output external_ip_address_db)

json=${json/app_server_ip/$app_ip};
echo "${json/db_server_ip/$db_ip}"
fi
