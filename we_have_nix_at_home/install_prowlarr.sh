wget --content-disposition 'http://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Prowlarr*.linux*.tar.gz
sudo mv Prowlarr/ /opt
sudo chown $USER:$USER -R /opt/Prowlarr

cat << EOF | sudo tee /etc/systemd/system/prowlarr.service > /dev/null
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target
[Service]
User=$USER
Group=$USER
Type=simple

ExecStart=/opt/Prowlarr/Prowlarr -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl -q daemon-reload

sudo systemctl enable --now prowlarr

rm Prowlarr*.linux*.tar.gz
