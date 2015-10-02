require 'spec_helper_acceptance'

describe 'icinga' do
  context 'full install' do
    it 'provisions with no errors' do
      # Create a CA and certificate for the api
      shell('puppet cert generate $(hostname -f)')
      # Add in an MPM module for mod_php
      shell('echo "apache::mpm_module: \'prefork\'" > /var/lib/hiera/common.yaml')
      pp = <<-EOS
        Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin' }
        include ::icinga2
        include ::icinga2::web
        include ::icinga2::features::api
        include ::icinga2::features::command
        include ::icinga2::features::ido_mysql
      EOS
      # Check for clean provisioning and idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end