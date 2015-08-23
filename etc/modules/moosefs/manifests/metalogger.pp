# Setup metalogger machine
class moosefs::metalogger{
  package{ [ 'moosefs-metalogger' ]:
    ensure  => installed,
    require => File ['/etc/yum.repos.d/moosefs.repo'],
  }
  service { 'moosefs-metalogger':
    ensure  => 'running',
    enable  => true,
    require => Package['moosefs-metalogger'],
  }
}
