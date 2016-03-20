#!/bin/bash
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime

echo nameserver 8.8.8.8 > /etc/resolv.conf

echo '#!/bin/bash
make_resolv_conf() {
echo "Doing nothing to resolv.conf"
}' > /etc/dhcp/dhclient-enter-hooks

chmod a+x /etc/dhcp/dhclient-enter-hooks
/etc/init.d/network restart

rpm -q puppet &>/dev/null || {
  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install puppet
}

rpm -q puppetserver &>/dev/null || {
  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install puppetserver nano git ntp
}

# Block with puppet structure copy
\cp -rf /vagrant/puppet/* /etc/puppet
cp /vagrant/puppetmaster.yaml /var/lib/hiera

chown -R puppet:puppet /etc/puppet

# Passenger requires kernel >= 2.6.39 or disabled SELinux
sed -i 's\=permissive\=disabled\g' /etc/sysconfig/selinux
sed -i 's\=permissive\=disabled\g' /etc/selinux/config

# line for correct certificate name
echo nameserver 8.8.8.8 > /etc/resolv.conf

puppet master --verbose --no-daemonize & sleep 15
kill -SIGINT $(ps aux | grep '[/]usr/bin/ruby /usr/bin/puppet master --verbose --no-daemonize' | awk '{print $2}')
yum -y install mod_ssl ruby-devel rubygems gcc gcc-c++ libcurl-devel openssl-devel gettext-devel ruby-json
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm install 1.9.3
# removed gem install rake rack passenger --no-rdoc --no-ri

mkdir -p /usr/share/puppet/rack/puppetmasterd/{public,tmp}
cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd
# fixed: nginx strips all environment variables by default
# cp /vagrant/config.ru /usr/share/puppet/rack/puppetmasterd
chown -R puppet:puppet /usr/share/puppet
# reboot
