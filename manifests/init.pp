# == Class: icinga2
#
# Class to deploy and configure icinga2 servers and clients
#
# === Parameters
#
# [*repo_manage*]
#   Whether to install the upstream repository
#
# === Examples
#
# For a basic all in one server with web front end:
#
#   include ::icinga2
#   include ::icinga2::web
#   include ::icinga2::features::ido_mysql
#
# For a satellite system:
#
#   include ::icinga2::features::api
#
#   icinga2::endpoint { 'master.example.com':
#     host => 'master.example.com',
#   }
#
#   icinga2::zone { 'master.example.com':
#     endpoints => [
#       'master.example.com'
#     ],
#   }
#
#   icinga2::endpoint { 'satellite.example.com':
#   }
#
#   icinga2::zone { 'satellite.example.com':
#     endpoints => [
#       'NodeName'
#     ],
#     parent    => master.example.com,
#   }
#
# === Authors
#
# Simon Murray <spjmurray@yahoo.co.uk>
#
# === Copyright
#
# Copyright 2015 Simon Murray, unless otherwise noted.
#
class icinga2 (
  $repo_manage = true,
  $plugins = $::icinga2::params::plugins,
  $webdeps = $::icinga2::params::webdeps,
  $user = $::icinga2::params::user,
) inherits icinga2::params {

  include ::icinga2::repo
  include ::icinga2::install
  include ::icinga2::configure
  include ::icinga2::service

  Class['::icinga2::repo'] -> Class['::icinga2::install']
  Class['::icinga2::install'] -> Class['::icinga2::configure']

}
