#!/bin/bash

SERVICE_DIR="/etc/systemd/system"

touch "$SERVICE_DIR/nomad.service"
chmod 755 "$SERVICE_DIR/nomad.service"

HOST=$(hostname --ip-address)

if [[ $HOSTNAME = *"nomad"* ]]; then
	cat <<-EOF > "$SERVICE_DIR/nomad.service"
		[Unit]
		Description=nomad agent
		Requires=network-online.target
		After=network-online.target consul.service
		
		[Service]
		Restart=on-failure
		ExecStart=/usr/local/bin/nomad agent -data-dir=/etc/nomad.d/data --bind=$HOST -server -bootstrap-expect=1 -consul-address=localhost:8500 
		ExecReload=/bin/kill -HUP $MAINPID
		
		[Install]
		WantedBy=multi-user.target
	EOF

	systemctl enable nomad.service

	systemctl start nomad
else
	exit 0
fi