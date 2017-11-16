#
# See README.md for usage
define dovecot::auth::passwdfile (
  String $owner             = 'root',
  String $group             = 'dovecot',
  String $mode              = '0640',
  Optional[String] $source  = undef,
  Optional[String] $content = undef,
  Array[String] $users      = [],
  Boolean $manage_content   = true,
) {
  include ::dovecot::ldap

  #lint:ignore:unquoted_string_in_selector
  $_manage_content = $source ? {
    undef   => $content ? {
      undef   => $manage_content ? {
        true  => epp('dovecot/auth/passwd-file.epp', { users => $users }),
        false => undef,
      },
      default => $content,
    },
    default => undef,
  }
  #lint:endignore

  file {$name:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $source,
    content => $_manage_content,
  }
}
