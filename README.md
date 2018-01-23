# gmod

Garry's Mod image. What it says on the can.

This integrates with the base image kalka/steamcmd.

# NOTICE

This is a modified version of kalka/gmod intended to use with a mongodb binary. libboost-all-dev:i386 is installed on this version.

After the container has finished running, put any necessary mongo binary files in the associated locations:
* The root directory of garrysmod (where srcds_run is)
* garrysmod/lua/bin/

This ships with CS:S for your convenience. If you don't want CS:S, I don't know what to tell you.

This folder requires you to set the host directory to 777 so that the container can read it. This is only temporary and I will make a way to access it via GID/PID's in the future.

## Running the container

`sudo mkdir -p /opt/{garrysmod,css} && sudo chmod 777 /opt/{garrysmod,css}`

Run it just like with any Garry's Mod instance:

`docker run --rm -it -v /opt/garrysmod:/opt/garrysmod -v /opt/css:/opt/css -p 27015:27015/udp kalka/gmod -game garrysmod -maxplayers 8 +gamemode sandbox +map gm_flatgrass`

`-it` is required for interactive mode unless you really want to have a bad time trying to kill the script.

To daemonize:

`docker run -d -v /opt/garrysmod:/opt/garrysmod -v /opt/css:/opt/css -p 27015:27015/udp kalka/gmod -game garrysmod -maxplayers 8 +gamemode sandbox +map gm_flatgrass`

Do `docker ps` to see it running. To attach to it, do `docker attach gmod`. You will attach to the console.

You can choose to add `-p 27015:27015/tcp` to the command line, keep in mind though that this will expose the RCON instance in SRCDS publicly. It is best to use an internal IP for rcon if you have an internal network, like so: `-p 10.x.x.x:27015:27015/tcp`

## Automated run

You can create something like a bash file named run.sh and run everything I just said on it:

```bash
#!/bin/bash

mkdir -p /opt/{garrysmod,css} && chmod 777 /opt/{garrysmod,css}

docker run -it --rm -v /opt/garrysmod:/opt/garrysmod -v /opt/css:/opt/css -p 27015:27015/udp kalka/gmod -game garrysmod -maxplayers 8 +gamemode sandbox +map gm_flatgrass
```

## Refs

This project also has the ability to use an environment variable to force an update if your gameserver requires or an update or needs to validate gameserver files. Append `-e update=true` to your script and SteamCMD will run.
