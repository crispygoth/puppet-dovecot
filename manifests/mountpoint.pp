# Dovecot keeps track of mountpoints that might contain emails. Sometimes we
# need to tell it which ones contain emails and which ones don't. Please refer
# to the Dovecot documentation for details
# (https://wiki2.dovecot.org/Mountpoints).
#
define dovecot::mountpoint(
  Enum['online', 'ignore', 'absent'] $state,
) {
  if $state == 'absent' {
    exec { "Unregister mountpoint $name with Dovecot":
      command  => "/usr/bin/doveadm mount remove $name",
      onlyif   => "/usr/bin/doveadm mount list | grep '${name}'",
      provider => 'shell',
    }
  } else {
    exec { "Register mountpoint $name with Dovecot as ${state}":
      command  => "/usr/bin/doveadm mount add ${name} ${state}",
      unless   => "/usr/bin/doveadm mount list '${name}' | grep ${state}",
      provider => 'shell',
    }
  }
}
