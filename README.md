# minecraft_server_onekey (Vanilla)
## Install
>Java Version
```
sudo curl -L https://raw.githubusercontent.com/hashuser/minecraft_server_onekey/master/install.sh | bash -s -- --Xmx 1024 --Xms 512 --Gamemode creative --Maxplayer 20 --Viewdistance 10
```
>Bedrock Version
```
sudo curl -L https://raw.githubusercontent.com/hashuser/minecraft_server_onekey/master/install_cpp.sh | bash -s -- --Gamemode creative --Maxplayer 10 --Viewdistance 32
```
## Parameters
>Java Version
```
--Xmx: Maximum RAM (in MiB, >= 1024, otherwise server may not able to reboot)
--Xms: Minimum RAM (in MiB)
--Maxplayer: Maximum number of players
--Gamemode: survival, creative, adventure
--Viewdistance: Distance a player can see within the world
```
>Bedrock Version
```
--Maxplayer: Maximum number of players
--Gamemode: survival, creative, adventure
--Viewdistance: Distance a player can see within the world
```
## Recommand Environment
>Java Version
```
CPU: >=2
RAM: >=2G
```
>Bedrock Version
```
CPU: >=1
RAM: >=1G
```
