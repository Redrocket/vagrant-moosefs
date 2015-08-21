# Deploy
class moosefs::repo{
  file {'/etc/yum.repos.d/moosefs.repo':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/moosefs/moosefs.repo',
  }
}
