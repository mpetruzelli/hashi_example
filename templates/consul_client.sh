#!/bin/bash

SERVICE_DIR="/etc/systemd/system"

touch "$SERVICE_DIR/consul.service"
chmod 755 "$SERVICE_DIR/consul.service"

HOST=$(hostname --ip-address)



cat <<-EOF > "$SERVICE_DIR/consul.service"
	[Unit]
	Description=consul agent
	Requires=network-online.target
	After=network-online.target 
	
	[Service]
	Restart=on-failure
	ExecStart=/usr/local/bin/consul agent -client=$HOST -data-dir=/etc/consul.d/data -advertise=$HOST -retry-join "provider=azure  resource_group=${rg_name} vm_scale_set=consul tenant_id=${tenant_id} client_id=${client_id} subscription_id=${subscription_id} secret_access_key=${client_secret}"
	ExecReload=/bin/kill -HUP $MAINPID
	
	[Install]
	WantedBy=multi-user.target
EOF

 systemctl enable consul.service

 systemctl start consul