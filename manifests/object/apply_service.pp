# == Define: icinga2::object::apply_service
#
# Manages local and remote services
#
define icinga2::object::apply_service (
  $check_name = undef,
  $import = undef,
  $check_command = undef,
  $vars = undef,
  $assign_where = undef,
) {

  $target = '/etc/icinga2/conf.d/services.conf'

  if ! defined(Icinga2::Config[$target]) {
    icinga2::config { $target: }
  }

  concat::fragment { "icinga2::object::apply_service ${title}":
    target  => $target,
    content => template('icinga2/object/apply_service.conf.erb'),
    order   => '10',
  }

}