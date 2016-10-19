class collectd (
    $www = false
) {
    if $www == true {
      include 'collectd::www'
    }
    package {
      'collectd':
        ensure => installed;
    }
    service {
      'collectd':
        ensure  => running,
        enable  => true,
        require => Package['collectd'];
    }
}
