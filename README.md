# minecraft_server_onekey
## Install
```
sudo curl -L https://raw.githubusercontent.com/hashuser/minecraft_server_onekey/master/install.sh | bash -s -- --Xmx 1024 --Xms 512 --Gamemode creative --Maxplayer 20
```
## Parameters
```
--Xmx: Maximum RAM (in MiB, >= 1024, otherwise server may not able to reboot)
--Xms: Minimum RAM (in MiB)
--Maxplayer: Maximum number of players
--Gamemode: survival, creative, adventure
```
