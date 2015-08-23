# Setup cgi web server.
class moosefs::mfscgi{
  package{ [ 'moosefs-cgi', 'moosefs-cgiserv', 'httpd' ]:
    ensure  => installed,
    require => File ['/etc/yum.repos.d/moosefs.repo'],
  }
  file{'/etc/httpd/conf.d/moosy.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/moosefs/httpd_moose.conf',
    require => Package['httpd'],
    notify  => Service['httpd'],
  }
  service{'httpd':
    ensure => running,
    enable => true,
  }
}
