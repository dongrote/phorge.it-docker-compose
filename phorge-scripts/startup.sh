#!/bin/sh

# set server name in nginx config
sed "s/{{SERVER_NAME}}/${SERVER_NAME}/g" /etc/nginx/templates/phorge.conf.template \
  >/etc/nginx/sites-available/phorge.conf
ln -sf /etc/nginx/sites-available/phorge.conf /etc/nginx/sites-enabled/phorge.conf

# set phorge sshd listen port
sed -i "s/Port.*/Port ${PHORGE_SSH_PORT}/" /etc/ssh/sshd_config.phorge

cd /opt/phorge && \
  ./bin/config set mysql.host "$MARIADB_HOST" && \
  ./bin/config set mysql.user "$MARIADB_USER" && \
  ./bin/config set mysql.pass "$MARIADB_PASSWORD" && \
  ./bin/config set phabricator.base-uri "$PHORGE_BASE_URI" && \
  ./bin/config set pygments.enabled true && \
  ./bin/config set storage.local-disk.path /var/phorge-file-storage && \
  ./bin/config set phd.user daemon && \
  ./bin/config set diffusion.ssh-user git && \
  ./bin/config set diffusion.ssh-port "$PHORGE_SSH_PORT" && \
  ./bin/storage upgrade --force && \
  ./bin/phd start && \
  exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf