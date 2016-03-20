node 'puppetmaster' {

  hiera_include('classes')

}

class ipagent {

  firewall { '012 allow outbound puppet':
    chain  =>  'OUTPUT',
    dport  =>  '8140',
    action =>  'accept',
    state  =>  'NEW',
  }

}

class ipmaster {

  firewall { '012 allow outbound puppet':
    chain  =>  'OUTPUT',
    dport  =>  '8140',
    action =>  'accept',
    state  =>  'NEW',
  }

  firewall { '013 allow inbound puppet':
    chain  =>  'INPUT',
    dport  =>  '8140',
    action =>  'accept',
    state  =>  'NEW',
  }

}

class httpserver {

  firewall { '020 allow http access only from one IP':
    chain  =>  'INPUT',
    dport  =>  '80',
    proto  =>  'tcp',
    action =>  'accept',
    source =>  '10.0.0.0/8',
  }

  firewall { '021 allow http access only from one IP':
    chain  =>  'INPUT',
    dport  =>  '80',
    proto  =>  'tcp',
    action =>  'accept',
    source =>  '172.16.0.0/12',
  }

  firewall { '022 allow outbound http':
    chain  =>  'OUTPUT',
    sport  =>  '80',
    proto  =>  'tcp',
    action =>  'accept',
  }

}
