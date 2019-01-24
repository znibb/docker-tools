#!/bin/bash

# Expects input parameters:
# 1: name/ID of container whose volume is to be restored (fetch with "docker container ls"
# 2: file to restore volume from
# 3: volume directory inside the container (check container-side of the volumes-statement in relevant docker-compose.yml)


arch=$(uname -m)
if [[ "$arch" -eq "armv6l" ]]; then
	IMAGE_NAME="arm32v6/busybox"
elif [[ "$arch" -eq "armv7l" ]]; then
	IMAGE_NAME="arm32v7/busybox"
else
	IMAGE_NAME="resin/armhf-alpine"
fi

# Check if supplied file to restore from exists
if [[ ! -f "$2" ]]; then
	echo "Invalid file: $2"
	exit 1
fi

# Check if file was supplied with absolute path
if [[ $(echo "$2" | cut -c1) != "/" ]]; then
	echo "Must use absolute file path: $2"
	exit 2
fi

file_path=$(dirname $2)
file_name=$(basename $2)

docker run --rm --volumes-from $1 -v $file_path:/backup $IMAGE_NAME /bin/sh -c "cd $3 && tar -xvz -f /backup/$file_name --strip 1"
