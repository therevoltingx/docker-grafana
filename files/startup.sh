#!/bin/bash

. /etc/profile.d/rbenv.sh
ruby /setup.rb

exec /usr/sbin/grafana-server \
  --homepath=/usr/share/grafana \
  --pidfile=/var/run/grafana-server.pid \
  --config=/etc/grafana/grafana.ini
