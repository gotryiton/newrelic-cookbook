include_recipe "newrelic::repository"

package "newrelic-sysmond" do
  action :install
end

bag = Chef::EncryptedDataBagItem.load("production", "keys")
template "/etc/newrelic/nrsysmond.cfg" do
  owner "root"
  group "newrelic"
  mode "0644"
  source "nrsysmond.cfg.erb"
  notifies :restart, "service[newrelic-sysmond]"
  variables :newrelic_key => bag["newrelic"]
end

service "newrelic-sysmond" do
  supports :restart => true, :status => true
  action [:enable, :start]
end
