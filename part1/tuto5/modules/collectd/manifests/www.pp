class collectd::www {
  include 'apache'
  file {
    '/etc/apache2/conf-available/collection3.conf':
      ensure  => file,
      mode    => '0644',
      owner   => root,
      group   => root,
      source  => '/vagrant/tuto3/files/collection3.conf',
      require => Package['apache2'],
      notify  => Service['apache2'];
  }
  file {
    '/etc/apache2/conf-enabled/collection3.conf':
      ensure  => '/etc/apache2/conf-available/collection3.conf',
      require => Package['apache2'],
      notify  => Service['apache2'];
  }
  file {
    '/etc/apache2/mods-enabled/cgid.conf':
      ensure  => '/etc/apache2/mods-available/cgid.conf',
      require => Package['apache2'],
      notify  => Service['apache2'];
    '/etc/apache2/mods-enabled/cgid.load':
      ensure  => '/etc/apache2/mods-available/cgid.load',
      require => Package['apache2'],
      notify  => Service['apache2'];
  }
    package {
      ['libconfig-general-perl',
      'librrds-perl',
      'libregexp-common-perl',
      'libhtml-parser-perl']:
        ensure => installed,
        notify => Package['collectd'];
    }
}

class {
  'collectd':
    www => true;
}
