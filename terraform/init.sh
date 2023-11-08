#!/bin/bash

clear
echo "Prepare environment start..."

cd ./init || exit

echo "Creating service account, ydb, keys and backend S3 bucket..."

rm iam_token.tfvars
echo "iam_token=\"$(yc iam create-token)\"" >> iam_token.tfvars
terraform init -reconfigure
terraform apply --auto-approve -var-file="iam_token.tfvars" -var-file="terraform.tfvars"
rm iam_token.tfvars

echo "Prepare terraform for stage..."
cd ../stage || exit
terraform init -reconfigure -backend-config=backend.tfvars

echo "Prepare terraform for prod..."
cd ../prod || exit
terraform init -reconfigure -backend-config=backend.tfvars

echo "Prepare environment complete."
