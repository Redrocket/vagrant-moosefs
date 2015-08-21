# Deploy
class moosefs::common{
  file {'/data':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }
  host { 'mfsmaster':
    ip      => '192.168.2.200',
    require => File['/data'],
  }
  service { 'firewalld':
    ensure => stopped,
    enable => false,
    require => Host['mfsmaster'],
  }
}
