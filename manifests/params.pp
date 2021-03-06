# == Class: winbind::params
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
#  class { winbind::params:  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class winbind::params {

  case $::osfamily {
    'redhat': {
      if $::operatingsystemrelease =~ /6\./ {
        $package_samba = [ 'samba','krb5-workstation','krb5-libs','pam_krb5','samba-winbind' ]
      } else {
        $package_samba = [ 'samba','krb5-workstation','krb5-libs','pam_krb5' ]
      }
    }
    default: { fail("Sorry - we don't support your $::{operatingsystem}") }
  }

}
