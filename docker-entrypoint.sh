#!/bin/bash

if [ ! -f /opt/garrysmod/srcds_run ]
then
    echo "Garry's Mod directory not found. Downloading..."
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod +app_update 4020 validate +quit
fi
if [ ! -f /opt/garrysmod/cstrike/srcds_run ]
then
    echo "CS:S directory not found. Downloading..."
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod/cstrike +app_update 232330 validate +quit
fi


if [ ${update+x} ]
then
    echo "Update environment enforced. Updating Garry's Mod!"
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod +app_update 4020 validate +quit
    echo "Whew! Okay, time to move on to CS:S."
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod/cstrike +app_update 232330 validate +qui
else
    echo "Update environment is not set. Skipping update!"
fi

echo "
        \"mountcfg\"
        {
                \"cstrike\"     \"/opt/garrysmod/cstrike/cstrike\"
        }
    " > /opt/garrysmod/garrysmod/cfg/mount.cfg

exec /opt/garrysmod/srcds_run -port "$port" "$@"
