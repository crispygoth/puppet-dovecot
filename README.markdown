# dovecot #

This is the dovecot module. It provides installation and configuration routines using Puppet.

#### Table of contents

1. [Overview](#overview)
2. [Usage](#usage)
3. [Classes](#classes)
  * [`dovecot`](#dovecot)
  * [`dovecot::auth`](#dovecotauth)
  * [`dovecot::logging`](#dovecotlogging)
  * [`dovecot::mail`](#dovecotmail)
  * [`dovecot::master`](#dovecotmaster)
  * [`dovecot::lda`](#dovecotlda)
  * [`dovecot::ssl`](#dovecotssl)
  * [`dovecot::imap`](#dovecotimap)
  * [`dovecot::pop3`](#dovecotpop3)
  * [`dovecot::lmtp`](#dovecotlmtp)
  * [`dovecot::managesieved`](#dovecotmanagesieved)
4. [Resources](#resources)
  * [`dovecot::auth::passdb`](#dovecotauthpassdb)
  * [`dovecot::auth::userdb`](#dovecotauthuserdb)
  * [`dovecot::auth::ldapfile`](#dovecotauthldapfile)
  * [`dovecot::auth::passwdfile`](#dovecotauthpasswdfile)
  * [`dovecot::auth::sqlfile`](#dovecotauthsqlfile)
  * [`dovecot::namespace`](#dovecotnamespace)
  * [`dovecot::plugin`](#dovecotplugin)
  * [`dovecot::imap::inet_listener`](#dovecotimapinetlistener)
  * [`dovecot::pop3::inet_listener`](#dovecotpop3inetlistener)
  * [`dovecot::lmtp::inet_listener`](#dovecotlmtpinetlistener)
  * [`dovecot::lmtp::unix_listener`](#dovecotlmtpunixlistener)
  * [`dovecot::auth::unix_listener`](#dovecotauthunixlistener)
  * [`dovecot::config::listener`](#dovecotconfiglistener)
5. [Defined Types](#definedtypes)
  * [`dovecot::mountpoint`](#dovecotmountpoint)
6. [Example](#example)

## Overview

This module installs and configures [Dovecot](http://dovecot.org/) server on Linux.

This module requires Puppet 4.0.0 or greater. Puppet 3.x was
[discontinued](https://puppet.com/misc/puppet-enterprise-lifecycle) at
the end of 2016.

## Usage

In its simplest use you could use as:

```
include dovecot
```

It will just install dovecot package with its default configuration (OS dependant).

The module also provides parameters and subclasses to configure different services for
the dovecot server.

For example, to configure imap you could use:

```
include dovecot
include dovecot::imap
```

## Classes

### `dovecot`

This is the main class. It installs and configure dovecot and its main components.

For configuration, it, by default, includes ```dovecot::auth```, ```dovecot::logging```, ```dovecot::mail``` and ```dovecot::master```, so if you want to pass parameters to these classes using the ```class``` notation, you should manually disable this include by setting as ```false``` the ```enable_auth```, ```enable_logging```, ```enable_mail``` and/or ```enable_master``` parameters. If you are confortable passing parameters from hiera, you could ignore these parameters.

#### Parameters

##### `package_ensure`

Tells Puppet whether the Dovecot package should be installed, and what version. Valid options: 'present', 'latest', or a specific version number. Default value: 'present'

##### `package_manage`

Tells Puppet whether to manage the dovecot package. Valid options: true or false. Default value: true

##### `package_name`

Tells Puppet what dovecot package to manage. Valid options: Array[string]. Default value: OS dependant ('dovecot-core' on Ubuntu)

##### `service_enable`

Tells Puppet whether to enable the dovecot service at boot. Valid options: true or false. Default value: true

##### `service_ensure`

Tells Puppet whether the dovecot service should be running. Valid options: 'running' or 'stopped'. Default value: 'running'

##### `service_manage`

Tells Puppet whether to manage the dovecot service. Valid options: true or false. Default value: true

##### `service_name`

Tells Puppet what dovecot service to manage. Valid options: string. Default value: varies by operating system

##### `service_provider`

Tells Puppet which service provider to use for dovecot. Valid options: string. Default value: 'undef'

##### `config_dir`

Specifies a directory for the dovecot configuration files. Valid options: string containing an absolute path. Default value: OS dependant ('/etc/dovecot' on Ubuntu)

##### `enable_imap`

Enable IMAP service in dovecot. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::imap``` in your manifests.

##### `enable_pop3`

Enable POP3 service in dovecot. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::pop3``` in your manifests.

##### `enable_lmtp`

Enable LMTP service in dovecot. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::lmtp``` in your manifests.

##### `enable_managesieved`

Enable ManageSieve service in dovecot to manage users' Sieve script collection. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::managesieved``` in your manifests.

##### `enable_auth`

Enable authentication configuration. Valid options: true or false. Default value: true.

Setting a true value for this option is the same than manually including class ```dovecot::auth``` in your manifests.

##### `enable_logging`

Enable logging configuration. Valid options: true or false. Default value: true.

Setting a true value for this option is the same than manually including class ```dovecot::logging``` in your manifests.

##### `enable_mail`

Enable mail configuration. Valid options: true or false. Default value: true.

Setting a true value for this option is the same than manually including class ```dovecot::mail``` in your manifests.

##### `enable_master`

Enable master configuration. Valid options: true or false. Default value: true.

Setting a true value for this option is the same than manually including class ```dovecot::master``` in your manifests.

##### `enable_ssl`

Enable SSL configuration. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::ssl``` in your manifests.

##### `enable_lda`

Enable LDA configuration. Valid options: true or false. Default value: false.

Setting a true value for this option is the same than manually including class ```dovecot::lda``` in your manifests.

##### `plugins`

A hash with plugins and their configuration that should be enabled in dovecot. Valid options: a hash of valid parameters to dovecot::plugin. Devault value: {}

This option is the same than manually calling ```dovecot::plugin``` for your plugins.

##### `files`

A hash with files to be included in dovecot configuration. These file will be created as file resources. Valid options: a hash o valid file resources. Default value: {}

### `dovecot::auth`

This class is the responsible of configuring auth in dovecot. It is the one configuring the file '/etc/dovecot/conf.d/10-auth.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/10-auth.conf'. Default value: {}

##### `unix_listeners

A hash of unix_listeners (and their options) for the auth service. Default value: {} (default listeners are used)

##### `service_options`

A has of options to se inside

```
service lmtp {
...
}
```
configuration.

Default value: {}

##### `passdb`

An array of hashes with password databases. Default value: []

##### `userdb`

An array of hashes with user databases. Default value: []

##### `ldapfile`

A hash with ldap connection configuration files (and their parameters). See dovecot::auth::ldapfile. Devault value: {}

##### `passwdfile`

A hash with passwd files (and their parameters). See dovecot::auth::passwdfile. Devault value: {}

##### `sqlfile`

A hash with sql connection configuration files (and their parameters). See dovecot::auth::sqlfile. Devault value: {}

### `dovecot::logging`

Class to configure logging options at '/etc/dovecot/conf.d/10-logging.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/10-logging.conf'. Default value: {}

##### `plugins`

A hash to configure `plugin` option at '/etc/dovecot/conf.d/10-logging.conf'.

### `dovecot::mail`

Class to configure mail options at '/etc/dovecot/conf.d/10-mail.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/10-mail.conf'. Default value: {}

##### `namespace`

A hash to configure mail namespaces. See dovecot::namespace to see the structure of this hash.

### `dovecot::master`

Class to configure mail options at '/etc/dovecot/conf.d/10-master.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/10-master.conf'. Default value: {}

##### `services`

A hash of services to configure at '/etc/dovecot/conf.d/10-master.conf'. Default value: {}

This parameter is rarely used because most of common services could be enabled by directly including its corresponding class.

### `dovecot::lda`

Class to configure LDA options at '/etc/dovecot/conf.d/15-lda.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/15-master.conf'. Default value: {}

##### `mail_plugins`

A hash of plugins to configure for lda protocol. Default value: {}

### `dovecot::ssl`

Class to configure SSL options at '/etc/dovecot/conf.d/10-ssl.conf'.

This class is always included from ```dovecot```.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/10-ssl.conf'. Default value: {}

### `dovecot::imap`

Class to install and configure IMAP's dovecot service.

You can manually include this class in your manifests or by setting `enable_imap` dovecot's parameter to true.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/20-imap.conf'. Default value: {}

##### `protocol_options`

A hash of options to set inside

```
protocol imap {
...
}
```
configuration.

Default value: {}

##### `service_options`

A hash of options for the imap service configuration inside

```
service imap {
...
}
```

Default value: {}

##### `login_options`

A hash of options for the imap-login configuration inside

```
service imap-login {
...
}
```

Default value: {}

##### `inet_listeners`

A hash of inet_listeners to configure for imap service.

Default value: {} (default listeners are used)

##### `package_name`

A string with the name of the package providing imap support for dovecot. Default value: OS dependant ('dovecot-imapd on Ubuntu)

### `dovecot::pop3`

Class to install and configure POP3's dovecot service.

You can manually include this class in your manifests or by setting `enable_pop3` dovecot's parameter to true.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/20-pop3.conf'. Default value: {}

##### `protocol_options`

A hash of options to set inside

```
protocol pop3 {
...
}
```
configuration.

Default value: {}

##### `service_options`

A hash of options for the pop3 service configuration inside

```
service pop3 {
...
}
```

Default value: {}

##### `login_options`

A hash of options for the pop3-login configuration inside

```
service pop3-login {
...
}
```

Default value: {}

##### `inet_listeners`

A hash of inet_listeners to configure for pop3 service.

Default value: {} (default listeners are used)

##### `package_name`

A string with the name of the package providing pop3 support for dovecot. Default value: OS dependant ('dovecot-pop3d on Ubuntu)

### `dovecot::lmtp`

Class to install and configure LMTP's dovecot service.

You can manually include this class in your manifests or by setting `enable_lmtp` dovecot's parameter to true.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/20-lmtp.conf'. Default value: {}

##### `protocol_options`

A hash of options to set inside

```
protocol lmtp {
...
}
```
configuration.

Default value: {}

##### `service_options`

A has of options to se inside

```
service lmtp {
...
}
```
configuration.

Default value: {}

##### `inet_listeners`

A hash of inet_listeners to configure for lmtp service.

Default value: {} (default listeners are used)

##### `unix_listeners`

A hash of unix_listeners to configure for lmtp service.

Default value: {} (default listeners are used)

##### `package_name`

A string with the name of the package providing lmtp support for dovecot. Default value: OS dependant ('dovecot-lmtpd on Ubuntu)

### `dovecot::managesieved`

Class to install and configure ManageSieve's dovecot service.

You can manually include this class in your manifests or by setting `enable_managesieved` dovecot's parameter to true.

#### Parameters

##### `options`

A hash of options to set in '/etc/dovecot/conf.d/20-managesieve.conf'. Default value: {}

##### `protocol_options`

A hash of options to set inside

```
protocol managesieve {
...
}
```
configuration.

Default value: {}

##### `service_options`

A hash of options for the managesieve service configuration inside

```
service managesieve {
...
}
```

Default value: {}

##### `login_options`

A hash of options for the managesieve-login configuration inside

```
service managesieve-login {
...
}
```

Default value: {}

##### `inet_listeners`

A hash of inet_listeners to configure for managesieve service.

Default value: {} (default listeners are used)

##### `package_name`

A string with the name of the package providing managesieve support for dovecot. Default value: OS dependant ('dovecot-managesieved on Ubuntu)

## Resources

### `dovecot::auth::passdb`

Configures a password database for dovecot. This is normally used from `passdb` parameter of `dovecot::auth` class, but could also be manually used.

See [Password Databases](http://wiki2.dovecot.org/PasswordDatabase) for a complete description of every parameter.

#### Parameters

##### `driver`

Driver for the password database. Valid values are valid password databases supported by dovecot.

##### `order`

Password databases are looked secuentially. This is the order of this database in the list. Default value: '50'.

##### `args`

Arguments fot the password database. This field is driver specific. Default value: undef.

##### `default_fields`

Passdb fields (and extra fields) that are used, unless overwritten by the passdb backend. Default value: undef.

##### `override_fields`

Same as default_fields, but instead of providing the default values, these values override what the passdb backend returned. Default value: undef.

##### `deny`

If 'yes', used to provide 'denied users database'. Valid values: 'yes', 'no'. Default value: undef.

##### `master`

If 'yes', used to provide master users database. Valid values: 'yes', 'no'. Default value: undef.

##### `pass`

This is an alias for `result_success = continue`. Valid values: `yes`, `no`. Default value: undef.

##### `skip`

Do we sometimes want to skip over this passdb?. Valid values: 'never', 'authenticated', 'unauthenticated'. Default value: undef.

##### `result_failure`

What to do if authentication failed. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('continue').

##### `result_internalfail`

What to do if the passdb lookup had an internal failure. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('continue').

##### `result_success`

What to do if the authentication succeeded. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('return-ok').

### `dovecot::auth::userdb`

Configures a user database for dovecot. This is normally used from `userdb` parameter of `dovecot::auth` class, but could also be manually used.

See [User Databases](http://wiki2.dovecot.org/UserDatabase) for a complete description of every parameter.

#### Parameters

##### `driver`

Driver for the password database. Valid values are valid password databases supported by dovecot.

##### `order`

User databases are looked secuentially. This is the order of this database in the list. Default value: '70'.

##### `args`

Arguments fot the user database. This field is driver specific. Default value: undef.

##### `default_fields`

Userdb fields (and extra fields) that are used, unless overwritten by the userdb backend. Default value: undef.

##### `override_fields`

Same as default_fields, but instead of providing the default values, these values override what the userdb backend returned. Default value: undef.

##### `skip`

Do we sometimes want to skip over this userdb?. Valid values: 'never', 'found', 'notfound'. Default value: undef.

##### `result_failure`

What to do if the user wasn't found from the userdb. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('continue').

##### `result_internalfail`

What to do if the userdb lookup had an internal failure. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('continue').

##### `result_success`

What to do if the user was found from the userdb. Valid values: 'return-ok', 'return-fail', 'return', 'continue-ok', continue-fail', 'continue'. Default value: undef ('return-ok').

### `dovecot::auth::ldapfile`

Configures a LDAP connection that could be used in a password or user database (or both).

#### Parameters

##### `owner`

The owner of the file with the configuration. Default value: 'root'.

##### `group`

The group of the file with the configuration. Default value: 'root'.

##### `mode`

The mode of the file with the configuration. Default value: '0600'.

##### `hosts`

String with the list of LDAP hosts to use. Default value: undef.

##### `uris`

String with LDAP URIs to use. You can use this instead of hosts list. Default value: undef.

##### `dn`

Username used to login to the LDAP server. Default value: undef.

##### `dnpass`

Password for LDAP server, if dn is specified. Default value: undef.

##### `sasl_mech`

SASL mechanism to use. Default value: undef.

##### `sasl_realm`

SASL realm to use. Default value: undef.

##### `sasl_authz_id`

SASL authorization ID. Default value: undef.

##### `tls`

Use TLS to connect to the LDAP server. Valid values are 'yes' and 'no'. Default value: undef.

##### `tls_ca_cert_file`

File with the CA certificate for LDAP server. Default value: undef.

##### `tls_ca_cert_dir`

Directory with CA certificates. Default value: undef.

##### `tls_cipher_suite`

TLS cipher suite to use to connect the LDAP server. Default value: undef.

##### `tls_cert_file`

File with the certificate to use to connect to the LDAP server. Default value: undef.

##### `tls_key_file`

File with the private key to use to connect to the LDAP server. Default value: undef.

##### `tls_require_cert`

If LDAP server require certificate. Valid values are 'never', 'hard', 'demand', 'allow' and 'try'. Default value: undef.

##### `ldaprc_path`

Path with a file to use as ldaprc. Default value: undef.

##### `debug_level`

LDAP library debug level as specified by LDAP_DEBUG_* in ldap_log.h. Default value: undef.

##### `auth_bind`

If set to 'yes', use authentication binding for verifying password's validity. Valid values: 'yes', 'no'. Default value: undef.

##### `auth_bind_userdn`

If authentication binding is used, you can save one LDAP request per login if users' DN can be specified with a common template. Default value: undef.

##### `ldap_version`

LDAP protocolo version to use. Default value: undef.

##### `base`

LDAP base for users' searches. Default value: ''

##### `deref`

LDAP dereference. Valid values: 'never', 'searching', 'finding', 'always'. Default value: undef.

##### `scope`

Search scope. Valid values: 'base', 'onelevel', 'subtree'. Default value: undef.

##### `user_attrs`

String with mapping for ldap attributes and userdb attributes. Default value: undef.

##### `user_filter`

Filter to use for searches when the LDAP server is used as a user database. Default value: undef.

##### `pass_attrs`

String with mapping for ldap attributes and passdb attributes. Default value: undef.

##### `pass_filter`

Filter to use for searches when the LDAP server is used as a password database. Default value: undef.

##### `iterate_filter`

Attributes an filter to get a list of all users. Default value: undef.

##### `default_pass_scheme`

Default password scheme. Default value: undef.

### `dovecot::auth::passwdfile`

Configures a passwd like file used in a passwd-file database.

It is basically a file resource, so you must provide one of `source`, `content` of `users` parameter.

#### Parameters

##### `owner`

The owner of the file. Default value: 'root'.

##### `group`

The group of the file. Default value: 'root'.

##### `mode`

The mode of the file. Default value: '0600'.

##### `source`

The source of the file. Default value: undef.

##### `content`

The content of the file. Default value: undef.

##### `users`

An array of users/entries to include in the file.

### `dovecot::auth::sqlfile`

Configures a SQL connection that could be used in a password or user database (or both).

#### Parameters

##### `driver`

SQL driver to use. Valid values: 'mysql', 'pgsql', 'sqlite'.

##### `connect`

Database connection string. This is driver-specific setting.

##### `owner`

The owner of the file with the configuration. Default value: 'root'.

##### `group`

The group of the file with the configuration. Default value: 'root'.

##### `mode`

The mode of the file with the configuration. Default value: '0600'.

##### `default_pass_scheme`

Default password scheme. Default value: undef.

##### `password_query`

passdb query to retrieve the password. Default value: undef.

##### `user_query`

userdb query to retrieve the user information. Default value: undef.

##### `iterate_query`

Query to get a list of all usernames. Default value: undef.

### `dovecot::namespace`

Configure a dovecot namespace.

See [Namespaces](http://wiki2.dovecot.org/Namespaces) for a complete documentation of every parameter.

#### Parameters

##### `ensure`

Whether the namespace should be 'present' or 'absent'. Default value: 'present'.

##### `type`

Type of the namespace. Valid values are: 'private', 'shared', 'public'. Default value: undef.

##### `separator`

Hierarchy separator to use. Default value: undef.

##### `prefix`

Prefix required to access this namespace. Default value: undef.

##### `location`

Physical location of the mailbox. Default value: undef.

##### `inbox`

There can be only one INBOX, and this setting defines which namespace has it. Valid values: 'yes', 'no'. Default value: 'no'.

##### `hidden`

If namespace is hidden, it's not advertised to clients. Valid values: 'yes', 'no'. Default value: undef.

##### `list`

Show the mailboxes under this namespace with LIST command. Valid values: 'yes', 'no', 'children'. Default value: undef.

##### `subscriptions`

Namespace handles its own subscriptions. Valid values: 'yes', 'no': Default value: undef.

##### `mailboxes`

Hash with a list of mailboxes (and its options) that should be automatically created. Default value: {}.

### dovecot::plugin

Configures dovecot plugins.

It is normally call from dovecot class' plugins parameter, but you could manually use it too.

#### Parameters

##### `options`

Options of the plugin. Default value: {}.

##### `config_file`

File where we want to save plugin options. Normally you don't need to change it. Default value: 'conf.d/90-plugin.conf'.

### dovecot::imap::inet_listener

Configures an IMAP listener.

This is normally call from the hash provided with `inet_listeners` parameter of `dovecot::imap` class.

#### Parameters

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `address`

Address to attach the listener to. Default value: undef.

##### `port`

Port to attache the listener to. Valid values: Valid port number. Default value: undef.

##### `ssl`

If 'yes', the listener does an immediate SSL/TLS handshake after accepting a connection. This is needed for the legacy imaps and pop3s ports. Valid values. 'yes', 'no'. Default value: undef.

##### `haproxy`

If 'yes', this listener is configured for use with HAProxy. Valid values: 'yes', 'no'. Default value: undef.

### dovecot::pop3::inet_listener

Configures a POP3 listener.

This is normally call from the hash provided with `inet_listeners` parameter of `dovecot::pop3` class.

#### Parameters

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `address`

Address to attach the listener to. Default value: undef.

##### `port`

Port to attache the listener to. Valid values: Valid port number. Default value: undef.

##### `ssl`

If 'yes', the listener does an immediate SSL/TLS handshake after accepting a connection. This is needed for the legacy imaps and pop3s ports. Valid values. 'yes', 'no'. Default value: undef.

##### `haproxy`

If 'yes', this listener is configured for use with HAProxy. Valid values: 'yes', 'no'. Default value: undef.

### dovecot::lmtp::inet_listener

Configures a LMTP listener.

This is normally call from the hash provided with `inet_listeners` parameter of `dovecot::lmtp` class.

#### Parameters

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `address`

Address to attach the listener to. Default value: undef.

##### `port`

Port to attache the listener to. Valid values: Valid port number. Default value: undef.

##### `ssl`

If 'yes', the listener does an immediate SSL/TLS handshake after accepting a connection. This is needed for the legacy imaps and pop3s ports. Valid values. 'yes', 'no'. Default value: undef.

##### `haproxy`

If 'yes', this listener is configured for use with HAProxy. Valid values: 'yes', 'no'. Default value: undef.

### dovecot::lmtp::unix_listener

Configures a LMTP listener.

This is normally call from the hash provided with `unix_listeners` parameter of `dovecot::lmtp` class.

#### Parameters

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `user`

The owner of the unix socket. Default value: undef.

##### `group`

The group of the unix socket. Default value. undef.

##### `mode`

The permissions of the unix socket. Default value: undef.

### dovecot::auth::unix_listener

Configures an AUTH listener.

This is normally call from the hash provided with `unix_listeners` parameter of `dovecot::auth` class.

#### Parameters

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `user`

The owner of the unix socket. Default value: undef.

##### `group`

The group of the unix socket. Default value. undef.

##### `mode`

The permissions of the unix socket. Default value: undef.

### dovecot::config::listener

This method create unix and inet listeners for dovecot services.

This resource is normally call from ''dovecot::imap'' ('dovecot::pop3' and so on) classes and you should rarelly use it directly.

#### Parameters

##### `service`

The service you want to attach to the listener. Valid values: A dovecot service name ('imap-login', for example).

##### `listener_name`

The name for the listener. For example, for unix_listeners it is the path of the file. For inet_listeners it is normally like 'imap', 'imaps'.

##### `options`

Hash with options for the listener. These are the options inside the

```
inet_listener <name> {
...
}
```
or
```
unix_listener <name> {
...
}
```

Default value: {}.

##### `ensure`

If the listener should be 'present' or 'absent'. Valid values: 'present', 'absent'. Default value: 'present'.

##### `type`

Type of the listener. Valid values: 'unix', 'inet', 'fifo'. Default value: 'unix'.

##### `config_file`

Path of the file where to save the configuation, relative to dovecot config directory. Default value: 'conf.d/10-master.conf'.

## Defined Types

### `mountpoint`

Dovecot tries to keep track of mountpoints that might contain emails to improve error handling. This defined type can be used to specify if mountpoints are required for Dovecot's operation or not.

#### Parameters

##### `state`

Whether Dovecot shall expect the mountpoint to be 'online' (mounted) or 'ignore' it (don't care). Nonexistent mountpoints can be purged using 'absent'.

## Example

This is a more complete example:

```
class {'dovecot':
  enable_imap => true,
  enable_lmtp => true,
  plugins     => {
    'sieve' => {
      options => {
        sieve_default       => '/etc/dovecot/default.sieve',
        sieve_max_redirects => 15,
      },
    },
  },
}

class {'dovecot::auth':
  options => {
    disable_plaintext_auth => 'no',
  },
  passdb => [
    {
      driver => 'passwd-file',
      args   => 'username_format=%{user} /etc/dovecot/users',
    },
    {
      driver => 'ldap'
      args   => '/etc/dovecot/dovecot-ldap.conf.ext',
    },
  ],
  userdb => [
    {
      driver => 'prefetch',
    },
    {
      driver => 'ldap',
      args   => '/etc/dovecot/dovecot-ldap.conf.ext',
    },
  ],
  ldapfile => {
    '/etc/dovecot/dovecot-ldap.conf.ext' => {
      uris        => 'ldap://ldap.mydomain.com',
      dn          => 'cn=dovecot,dc=mydomain,dc=com',
      dnpass      => 'mypassword',
      auth_bind   => 'no'
      base        => 'ou=Users,dc=mydomain,dc=com',
      pass_filter => '(&(objectClass=CourierMailAccount)(mail=%u))',
      pass_attrs  => 'mailbox=userdb_mail,userPassword=password,quota=userdb_quota_rule',
      user_filter => '(&(objectClass=CourierMailAccount)(mail=%u))',
      user_attrs  => 'mailbox=mail,quota=quota_rule',
    },
  },
  passwdfile => {
    '/etc/dovecot/users' => {
      users => [
        'user1@mydomain.com:{CRYPT}asdfkjasdfjadf:::::',
        'user2@mydomain.com:{CRYPT}qwieurqwpioeru:::::',
      ],
    }
  },
}

class {'dovecot::mail':
  namespace => {
    'inbox' => {
      inbox     => 'yes',
      mailboxes => {
        'Trash' => {
          special_use => '\Trash'
          auto        => 'subscribe'
        },
        'Drafts' => {
          special_use => '\Drafts'
          auto        => 'subscribe'
        },
      },
    },
  },
}

class {'dovecot::lmtp':
  protocol_options => {
    mail_plugins => '$mail_plugins sieve',
  },
}
```
