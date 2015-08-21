# Deploy
class moosefs::mfsclient{
  package { ['moosefs-chunkserver', 'moosefs-client']:
    ensure  => present,
    require => Service['firewalld'],
  }
  file {'/mnt/sdb':
    ensure => directory,
    owner  => 'mfs',
    group  => 'mfs',
    require => Package['moosefs-chunkserver'],
  }
  file {'/etc/mfs/mfshdd.cfg':
    ensure  => file,
    source  => 'puppet:///modules/moosefs/mfshdd.cfg',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/mnt/sdb'],
  }
  service { 'moosefs-chunkserver':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/mfs/mfshdd.cfg'],
  }
  file { ['/mnt/mfs', '/mnt/mfsmeta/']:
    ensure => directory,
    owner  => 'mfs',
    group  => 'mfs',
    require => Service['moosefs-chunkserver'],
  }
  exec {'mfsmount':
    command     => '/usr/bin/mfsmount /mnt/mfs -H mfsmaster',
    refreshonly => true,
    subscribe   => File['/mnt/mfs'],
  }
  exec {'mfsmountmeta':
    command     => '/usr/bin/mfsmount -o mfsmeta /mnt/mfsmeta -H mfsmaster',
    refreshonly => true,
    subscribe   => File['/mnt/mfsmeta'],
  }
 
}
