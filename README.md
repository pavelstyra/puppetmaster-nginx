# puppet 3.8.6 / nginx 1.8.1 / Passenger 5.0.26

**Puppet labs does not provide any guide on how to run a puppet master with passenger and nginx. Especially Passenger 5.**

So here is bash script for provision CentOS 6.7 Vagrant box with puppet master running on nginx with Passenger 5.0.26.
You can also review passenger_set_header specific changes in nginx.conf.
At the end of provision run puppetmaster will provision itself as agent with set of iptables rules.

```
git clone https://github.com/pavelstyra/puppetmaster-nginx.git
vagrant up --provider virtualbox
```
