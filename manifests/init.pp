# == Class: winbind
#
# Full description of class winbind here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { winbind:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class winbind (
  $smb_ensure = 'false',
  $ad_ou = '',
  $username,
  $password,
  $netbiosdomain,
  $dnsdomain,
  $kdc,
  $krb5realm,
)
{

  include winbind::params

  $package_samba = $winbind::params::package_samba

  package { $package_samba:
    ensure => 'present',
  }

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { '/etc/nsswitch.conf':
   ensure  => present,
   content => template('winbind/nsswitch.conf.erb'),
  }

  file { '/etc/samba/smb.conf':
    content => template('winbind/smb.conf.erb'),
    require => Package['samba'],
  }

  file { '/etc/krb5.conf':
    content => template('winbind/krb5.conf.erb'),
  }

  file { '/etc/pam.d/sshd':
    content => template('winbind/pam.sshd.erb'),
  }

  service { 'smb':
    ensure  => $smb_ensure,
    require => File['/etc/samba/smb.conf'],
  }

  service { 'winbind':
    ensure    => running,
    subscribe => [File['/etc/nsswitch.conf'],File['/etc/samba/smb.conf']],
  }

  case $::winbind_enabled {
   'false': { 
     exec { 'domainbind':
       command => "net ads join ${ad_ou} -U $username%$password",
       unless  => "wbinfo -t",
       path    => '/bin:/usr/bin:/usr/sbin:/sbin',
       user    => 'root',
       require => Service['winbind'],
     }
   }
   default : { }
  }

}
