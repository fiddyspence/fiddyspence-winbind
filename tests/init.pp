# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation errors
# and view a log of events) or by fully applying the test in a virtual environment
# (to compare the resulting system state to the desired state).
#
# Learn more about module testing here: http://docs.puppetlabs.com/guides/tests_smoke.html
#
class { 'winbind':
  username => 'administrator',
  password => 'fuckarse',
  netbiosdomain => 'spence',
  dnsdomain => 'spence.org.uk.vm',
  kdc => 'chris-336fb02c0.spence.org.uk.vm',
  krb5realm => 'spence.org.uk.vm',
}
