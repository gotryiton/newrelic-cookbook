#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2011, Go Try It On
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include_recipe "apt"
include_recipe "php::source_54"
include_recipe "newrelic::repository"

# creates the install script command to run after package installation
execute "newrelic-install" do
  command "newrelic-install install"
  returns 1
  environment ({"NR_INSTALL_SILENT" => 1})
  action :nothing
end

# installs the new relic package and then runs the install script
package "newrelic-php5" do
  action :install
  options "--force-yes"
  notifies :run, resources(:execute => "newrelic-install")
end

# creates a service
service "newrelic-daemon" do
  service_name "newrelic-daemon"
  restart_command "/usr/sbin/invoke-rc.d newrelic-daemon restart && sleep 1"
  status_command "/usr/sbin/invoke-rc.d newrelic-daemon status"
  supports value_for_platform(
    "debian" => { "4.0" => [ :restart], "default" => [ :restart, :status ] },
    "ubuntu" => { "default" => [ :restart, :status ] },
    "centos" => { "default" => [ :restart, :status ] },
    "redhat" => { "default" => [ :restart, :status ] },
    "fedora" => { "default" => [ :restart, :status ] },
    "arch" => { "default" => [ :restart, :status ] },
    "default" => { "default" => [:restart] }
  )
  action :enable
end

bag = data_bag_item("applications", "gotryiton")
#creates the config file using the databag applications - newrelic_key
template "/etc/newrelic/newrelic.cfg" do
  owner "root"
  group "root"
  mode "0644"
  source "newrelic.cfg.erb"
  notifies :restart, "service[newrelic-daemon]"
  variables :newrelic_key => bag["newrelic_key"]
end

#creates the standard php newrelic ini file
template "/etc/php5/conf.d/newrelic.ini" do
  owner "root"
  group "root"
  mode "0644"
  source "newrelic.ini.erb"
  variables :newrelic_key => bag["newrelic_key"]
  # notifies :reload, "service[apache2]"
end

#creates the standard php newrelic ini file
template "/etc/php5/cli/conf.d/newrelic.ini" do
  owner "root"
  group "root"
  mode "0644"
  source "newrelic.ini.erb"
  only_if { File.directory?('/etc/php5/cli/conf.d') }
end

if File.directory?('/etc/php5/fpm/conf.d')
  #creates the fpm newrelic ini file
  template "/etc/php5/fpm/conf.d/newrelic.ini" do
    owner "root"
    group "root"
    mode "0644"
    source "newrelic.ini.erb"
    notifies :reload, "service[php5-fpm]"
    only_if { File.directory?('/etc/php5/fpm/conf.d') }
  end
end
