include_recipe "newrelic::repository"

package "newrelic-sysmond" do
  action :upgrade
end

bag = data_bag_item("applications", "gotryiton")

#creates the config file using the databag applications - newrelic_key
template "/etc/newrelic/nrsysmond.cfg" do
  owner "root"
  group "newrelic"
  mode "0644"
  source "nrsysmond.cfg.erb"
  notifies :restart, "service[newrelic-sysmond]"
  variables :newrelic_key => bag[node.chef_environment]["newrelic_key"]
end

service "newrelic-sysmond" do
  supports :restart => true, :status => true
  action [:enable, :start]  
end
