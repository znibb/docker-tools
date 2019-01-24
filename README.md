# Docker images
Builds available at [my docker page](https://cloud.docker.com/swarm/znibb/repository/list)

# Export docker volume contents
Usage:
`./export_volume.sh arg1 arg2`
where
`arg1` is the name of the volume to export contents from
`arg2` is the **absolute** path to write the archive to

# Restore docker volume contents
Usage:
`./restore_volume.sh arg1 arg2 arg3`
where
`arg1` is the name or ID of the container whose volume is to be restored
`arg2` is the archive to restore from
`arg3` is the path inside the container the volume was originally mounted to (chech relevant docker-compose.yml)
