# == Class: iptables
#
# Full description of class iptables here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'iptables':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class ipdefault {

  class {'::firewall': }

  resources { 'firewall':
    purge => true,
  }

  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }

  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }

  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }

  firewall { '003 accepts all established input connections':
    chain  => 'INPUT',
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

  firewall { '004 accepts all established output connections':
    chain  => 'OUTPUT',
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

  firewall { '005 accepts DNS':
    chain  => 'OUTPUT',
    proto  => 'udp',
    dport  => '53',
    action  => 'accept',
  }

  firewall { '006 accepts yum/wget':
    chain  => 'OUTPUT',
    proto  => 'tcp',
    dport  => '80',
    state  => 'NEW',
    action  => 'accept',
  }

  firewall {'007 accepts https':
    chain  => 'OUTPUT',
    proto  => 'tcp',
    dport  => '443',
    action  => 'accept',
  }

  firewall {'008 accepts inbound NTP':
    chain  => 'INPUT',
    proto  => 'udp',
    dport  => '123',
    action  => 'accept',
  }

  firewall {'009 accepts outbound NTP':
    chain  => 'OUTPUT',
    proto  => 'udp',
    dport  => '123',
    action  => 'accept',
  }

  firewall { '010 allow inbound ssh':
    chain  =>  'INPUT',
    dport  =>  '22',
    proto  =>  'tcp',
    action =>  'accept',
  }

  firewall { '011 allow outbound ssh':
    chain  =>  'OUTPUT',
    sport  =>  '22',
    proto  =>  'tcp',
    action =>  'accept',
  }

  firewall { '997 drop all other requests':
    chain  => 'INPUT',
    action => 'drop',
  }

  firewall { '998 drop all other requests':
    chain  => 'FORWARD',
    action => 'drop',
  }

  firewall { '999 drop all other requests':
    chain  => 'OUTPUT',
    action => 'drop',
  }

}
