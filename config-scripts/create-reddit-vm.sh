yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=b1gendq33mr1dsiv2am5,image-family=reddit-full,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file ssh-keys="/Users/kirk/.ssh/id_rsa.pub" \
  --metadata serial-port-enable=1
