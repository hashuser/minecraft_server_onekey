
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
  ExecStart=java -Xmx512M -Xms512M -jar $(cd "$(dirname "$0")";pwd)/server.jar nogui
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
  mkdir $(cd "$(dirname "$0")";pwd)/Minecraft
  cd $(cd "$(dirname "$0")";pwd)/Minecraft
  wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar
  apt search openjdk
  apt install openjdk-19-jdk-headless
  java -Xmx512M -Xms512M -jar server.jar nogui
  echo "eula=true" > eula.txt
}

main
