# 10-master.conf
# See README.md for usage
class dovecot::master (
  Hash[String, Optional[String]] $options,
  Hash[String, Hash] $services,
) {
  include ::dovecot

  dovecot::config::dovecotcfhash {'master':
    config_file => 'conf.d/10-master.conf',
    options     => $options,
  }

  # Configure services included in $services
  $services.each |String $s, Optional[Hash] $v| {
    dovecot::master::service {$s:
      * => $v,
    }
  }
}
