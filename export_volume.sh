#!/bin/bash

# Expects input parameters
# 1: name of volume to export contents from
# 2: mountpoint to write export to
# 2: path to write archive to (relative to the mountpoint)

arch=$(uname -m)
if [[ "$arch" -eq "armv6l" ]]; then
	IMAGE_NAME="arm32v6/busybox"
elif [[ "$arch" -eq "armv7l" ]]; then
	IMAGE_NAME="arm32v7/busybox"
else
	IMAGE_NAME="resin/armhf-alpine"
fi

# Check if supplied volume exists
docker volume inspect $1 > /dev/null 2>&1
retVal=$?
if [[ $retVal -ne 0 ]]; then
	echo "Invalid volume name"
	exit 1
fi

# Check if file path is absolute
if [[ $(echo "$2" | cut -c1) != "/" ]]; then
	echo "Must use absolute file path: $2"
	exit 2
fi

# Mount target if not already mounted
if [[ ! $findmnt -M $2 ]]; then
	mount $2
fi

date=$(date +"%F")
docker run --rm -v $1:/volume -v $2:/backup $IMAGE_NAME /bin/sh -c "tar -cvz -f /backup/${1}_$date.tar.gz /volume --strip 1"
retVal=$?
if [[ $retVal -ne 0 ]]; then
	echo "Export failed unexpectedly"
	exit 3
fi

exit 0
