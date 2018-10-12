#!/bin/bash

SERVICE_DIR="/etc/systemd/system"

touch "$SERVICE_DIR/nomad.service"
chmod 755 "$SERVICE_DIR/nomad.service"

mkdir -p /opt/nomad/alloc /opt/nomad/data
chmod -R 775 /opt/nomad

HOST=$(hostname --ip-address)

if [[ $HOSTNAME = *"nomad"* ]]; then
	cat <<-EOF > "/etc/nomad.d/conf.hcl"
		client {
			chroot_env {
				"/bin"           	= "/bin"
				"/lib" 				= "/lib"
  				"/lib32" 			= "/lib32"
  				"/lib64" 			= "/lib64"
  				"/run/resolvconf" 	= "/run/resolvconf"
  				"/sbin" 			= "/sbin"
			}
		}
	EOF


	cat <<-EOF > "$SERVICE_DIR/nomad.service"
		[Unit]
		Description=nomad agent
		Requires=network-online.target
		After=network-online.target consul.service
		
		[Service]
		Restart=on-failure
		ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad.d/conf.hcl -data-dir=/opt/nomad/data -alloc-dir=/opt/nomad/alloc --bind=$HOST -client -consul-address=localhost:8500 
		ExecReload=/bin/kill -HUP $MAINPID
		
		[Install]
		WantedBy=multi-user.target
	EOF

	systemctl enable nomad.service

	systemctl start nomad
else
	exit 0
fi