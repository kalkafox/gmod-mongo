#!/bin/bash

if [ ! -f /opt/garrysmod/srcds_run ]
then
    echo "Garry's Mod directory not found. Downloading..."
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod +app_update 4020 validate +quit
fi

if [ ${update+x} ]
then
    echo "Update environment enforced. Updating Garry's Mod!"
    /usr/games/steamcmd +login anonymous +force_install_dir /opt/garrysmod +app_update 4020 validate +quit
else
    echo "Update environment is not set. Skipping update!"
fi

exec /opt/garrysmod/srcds_run -game garrysmod -port "$port" "$@"
