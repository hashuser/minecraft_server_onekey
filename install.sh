
#!/bin/bash
# 1.19.3 Java

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
  ExecStart=java -Xmx${Memoey_max}M -Xms${Memoey_min}M -jar $(cd "$(dirname "$0")";pwd)/server.jar nogui
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
  mkdir $(cd "$(dirname "$0")";pwd)/Minecraft
  cd $(cd "$(dirname "$0")";pwd)/Minecraft
  wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar
  apt search openjdk
  apt install openjdk-19-jdk-headless
  create_service
  install_service
  echo "eula=true" > eula.txt
  sed -i 's/gamemode=servival/gamemode=${Gmode}/g' server.properties
  systemctl restart Minecraft.service
}

for arg in "$@"; do
  shift
  case "$arg" in
    '--Xmx')        set -- "$@" '-m'   ;;
    '--Xms')        set -- "$@" '-s'   ;;
    '--Gamemode')   set -- "$@" '-g'   ;;
    *)              set -- "$@" "$arg" ;;
  esac
done

while getopts ":Xmx:Xms:Gamemode:" opt
do
    case "${opt}" in
        m)
        Memoey_max=${OPTARG}
        ;;
        s)
        Memoey_min=${OPTARG}
        ;;
        g)
        Gmode=${OPTARG}
        ;;
        *)
        echo "Exit"
        echo "${opt}"
        exit 1
        ;;
esac done

if [ ! ${Memoey_max} ]; then
  Memoey_max="1024"
fi
if [ ! ${Memoey_min} ]; then
  Memoey_min="1024"
fi
if [ ! ${Gmode} ]; then
  Gmode="Servival"
fi

echo "-----1------"
echo ${Memoey_max}
echo ${Memoey_min}
echo ${Gmode}
echo "-----2------"

main
