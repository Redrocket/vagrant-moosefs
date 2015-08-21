class moosefs::mfsmaster{
  package{ ['moosefs-master', 'moosefs-cli', 'moosefs-cgi', 'moosefs-cgiserv', 'httpd' ]:
    ensure => installed,
    require => File ['/etc/yum.repos.d/moosefs.repo'],
  }
  file{'/etc/mfs/mfsexports.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/moosefs/mfsexports.cfg',
    require => Package['moosefs-master'],
    notify  => Service['moosefs-master'],
  }
  service{'moosefs-master':
    ensure => running,
    enable => true,
  }
}
