#!/bin/bash

SERVICE_DIR="/etc/systemd/system"

touch "$SERVICE_DIR/consul.service"
chmod 755 "$SERVICE_DIR/consul.service"

HOST=$(hostname --ip-address)

cat <<-EOF > "$SERVICE_DIR/consul.service"
	[Unit]
	Description=consul agent
	Requires=network-online.target
	After=network-online.targetx
	
	[Service]
	Restart=on-failure
	ExecStart=/usr/local/bin/consul agent -server -data-dir=/etc/consul.d/data -bind=$HOST -advertise=$HOST -bootstrap-expect=1 -client=$HOST -ui
	ExecReload=/bin/kill -HUP $MAINPID
	
	[Install]
	WantedBy=multi-user.target
EOF

 systemctl enable consul.service
 systemctl stop docker
 systemctl start consul