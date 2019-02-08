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

# Add git repo with ssh access
Clone repo and have remote setup to use ssh:

git clone git@github.com-znibb:znibb/repo.git repo

where 'git' corresponds to "User" and 'github.com-znibb' to "host" from  ~/.ssh/config, 'znibb/repo.git' to the path to your repo on github and 'repo' to the desired local path to the repo.

To update the remote use

git remote set-url origin git@github.com-znibb:znibb/repo.git

where the part between '@' and ':' must match the appropriate entry in ~/.ssh/config
