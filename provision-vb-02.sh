#!/bin/bash
yum install -y epel-release pygpgme curl
curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
yum -y install nginx
rm -f /etc/nginx/nginx.conf && cp /vagrant/nginx.conf /etc/nginx
/etc/init.d/puppetserver stop
chkconfig puppetserver off
yum -y install passenger
chkconfig nginx on && service nginx start
# check processes /usr/sbin/passenger-memory-stats
puppet agent --onetime --verbose --no-daemonize
