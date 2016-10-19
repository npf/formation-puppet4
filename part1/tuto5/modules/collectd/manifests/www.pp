class collectd::www {
  include apache2

  package {
    [
      'libconfig-general-perl',
      'librrds-perl',
      'libregexp-common-perl',
      'libhtml-parser-perl'
    ]:
      ensure => installed;
  }

  file {
    '/etc/apache2/conf-available/collection3.conf':
      ensure => file,
      mode   => '0644',
      owner  => root,
      group  => root,
      source => '/vagrant/tuto4/files/collection3.conf',
      notify => Service['apache2'];
  }

  file {
    '/etc/apache2/conf-enabled/collection3.conf':
      ensure  => '/etc/apache2/conf-available/collection3.conf',
      notify  => Service['apache2'];
  }

  file {
    '/etc/apache2/mods-enabled/cgid.conf':
      ensure => '/etc/apache2/mods-available/cgid.conf';
    '/etc/apache2/mods-enabled/cgid.load':
      ensure => '/etc/apache2/mods-available/cgid.load',
      notify => Service['apache2'];
  }
}
