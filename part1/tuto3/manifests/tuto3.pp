package {
  'collectd':
    ensure => installed,
    require => Package['apache2', 'libconfig-general-perl', 'librrds-perl', 'libregexp-common-perl', 'libhtml-parser-perl'];
}

package {
  'apache2':
    ensure => installed;
}

package {
  [
    'libconfig-general-perl',
    'librrds-perl',
    'libregexp-common-perl',
    'libhtml-parser-perl'
  ]:
    ensure => installed;
}

service {
  'collectd':
    ensure => running,
    enable => true,
    notify => Service['apache2'];
}

service {
  'apache2':
    ensure => running,
    enable => true;
}

file {
  '/etc/apache2/conf-available/collection3.conf':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => '/vagrant/tuto3/files/collection3.conf',
    require => Package['apache2'],
    notify => Service['apache2'];
}

file {
  '/etc/apache2/conf-enabled/collection3.conf':
    ensure => '/etc/apache2/conf-available/collection3.conf',
    require => Package['apache2'],
    notify => Service['apache2'];
    
}

file {
  '/etc/apache2/mods-enabled/cgid.conf':
    ensure => '/etc/apache2/mods-available/cgid.conf',
    require => Package['apache2'],
    notify => Service['apache2'];
  '/etc/apache2/mods-enabled/cgid.load':
    ensure => '/etc/apache2/mods-available/cgid.load',
    require => Package['apache2'],
    notify => Service['apache2'];
}

