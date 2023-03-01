#!/bin/bash
# 1.19.63 C++

create_service(){
  touch $(cd "$(dirname "$0")";pwd)/Minecraft.service
  cat>$(cd "$(dirname "$0")";pwd)/Minecraft.service<<EOF
  [Unit]
  Description=Minecraft Game Service
  After=rc-local.service
  [Service]
  Type=simple
  User=root
  Group=root
  WorkingDirectory=$(cd "$(dirname "$0")";pwd)
  ExecStart=$(cd "$(dirname "$0")";pwd)/bedrock_server
  LimitNOFILE=1048575
  Restart=always
  TasksMax=infinity
  [Install]
  WantedBy=multi-user.target
EOF
}

install_service(){
  echo "root  soft nofile 1048575" >> /etc/security/limits.conf
  echo "root  hard nofile 1048575" >> /etc/security/limits.conf
  mv $(cd "$(dirname "$0")";pwd)/Minecraft.service /etc/systemd/system/
  systemctl enable Minecraft.service
  systemctl start Minecraft.service
}

main(){
  echo ${Memoey_max}
  echo ${Memoey_min}
  echo ${Gmode}
  echo ${Mplayer}
  echo ${Vdistance}
  mkdir $(cd "$(dirname "$0")";pwd)/Minecraft
  cd $(cd "$(dirname "$0")";pwd)/Minecraft
  wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.63.01.zip
  unzip bedrock-server-1.19.63.01.zip
  rm $(cd "$(dirname "$0")";pwd)/bedrock-server-1.19.63.01.zip
  sed -i "s/gamemode=survival/gamemode=${Gmode}/g" "$(cd "$(dirname "$0")";pwd)/server.properties"
  sed -i "s/max-players=20/max-players=${Mplayer}/g" "$(cd "$(dirname "$0")";pwd)/server.properties"
  sed -i "s/view-distance=10/view-distance=${Vdistance}/g" "$(cd "$(dirname "$0")";pwd)/server.properties"
  cat $(cd "$(dirname "$0")";pwd)/server.properties
  create_service
  install_service
  iptables -P INPUT ACCEPT
  iptables -P OUTPUT ACCEPT
  ip6tables -P INPUT ACCEPT
  ip6tables -P OUTPUT ACCEPT
}

for arg in "$@"; do
  shift
  case "$arg" in
    '--Gamemode')      set -- "$@" '-g'   ;;
    '--Maxplayer')     set -- "$@" '-p'   ;;
    '--Viewdistance')  set -- "$@" '-v'   ;;
    *)                 set -- "$@" "$arg" ;;
  esac
done

while getopts ":g:p:v:" opt
do
    case "${opt}" in
        g)
        Gmode=${OPTARG}
        ;;
        p)
        Mplayer=${OPTARG}
        ;;
        v)
        Vdistance=${OPTARG}
        ;;
        *)
        echo "Exit"
        echo "${opt}"
        exit 1
        ;;
esac done

if [ ! ${Gmode} ]; then
  Gmode="Servival"
fi
if [ ! ${Mplayer} ]; then
  Mplayer="10"
fi
if [ ! ${Vdistance} ]; then
  Vdistance="32"
fi

main
