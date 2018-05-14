name             'proftpd-ii'
maintainer       'Hugo Cisneiros (Eitch)'
maintainer_email 'hugo.cisneiros@movile.com'
license          'Apache 2.0'
description      'Installs/Configures proftpd-ii'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version     '>= 11.0' if respond_to?(:chef_version)
version          '0.5.5'
issues_url       'https://github.com/Movile/chef-proftpd-ii/issues' if respond_to?(:issues_url)
source_url       'https://github.com/Movile/chef-proftpd-ii' if respond_to?(:source_url)

recipe 'openresty', 'Installs proftpd from package and sets up configuration apache style sites-enabled/sites-available'

%w[centos rhel amazon scientific oracle].each do |os|
  supports os
end

depends 'yum-repoforge'
