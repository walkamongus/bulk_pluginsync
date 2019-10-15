# bulk_pluginsync
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bulk_pluginsync
class bulk_pluginsync(
  $compile_master_pool_address = $facts['fqdn'],
  $compile_master_pool_port    = 8140,
  $packages_directory          = '/opt/puppetlabs/server/data/packages/public',
  $script_directory            = '/opt/puppetlabs/server/data/packages/public/current',
  $script_url_path             = 'packages/bulk_pluginsync.tar.gz',
){

  $tarball_location = "${packages_directory}/bulk_pluginsync.tar.gz"
  $command = "cd /opt/puppetlabs/puppet/cache/; tar -czvf ${tarball_location} lib"

  cron { 'create tar.gz of pluginsync cache':
    command => $command,
    hour    => '*',
  }

  exec { 'create tar.gz of pluginsync cache - onetime':
    path    => $facts['path'],
    command => $command,
    creates => $tarball_location,
  }

  file { "${script_directory}/bulk_pluginsync.bash":
    mode    => '0644',
    content => epp('bulk_pluginsync/bulk_pluginsync.bash.epp', {
      'compile_master_pool_address' => $compile_master_pool_address,
      'compile_master_pool_port'    => $compile_master_pool_port,
      'script_url_path'             => $script_url_path,
    }),
  }
}
