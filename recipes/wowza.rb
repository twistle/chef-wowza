#
# Cookbook Name:: chef-wowza
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

wowza_file = node['wowza']['download_file']
wowza_install_dir = "/root"
wowza_path = "#{wowza_install_dir}/#{wowza_file}"
wowza_download_path = node['wowza']['download_path']

#backup_dir = "/var/backup/#{node['hostname']}"

# install java
include_recipe "java"

# install expect
package ['expect']

# install wget
package ['wget']

# Download package Wowza
bash "download wowza" do
  code <<-EOF
        cd #{wowza_install_dir}
        wget #{wowza_download_path}/#{wowza_file} -q
        chmod u+x #{wowza_file}
  EOF
  not_if "test -e #{wowza_path}"
end


# Copy expect script template
template '/root/script.exp' do
  source 'script.exp.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Run expect script, which runs Wowza installer
execute 'expect script' do
  command '/root/script.exp'
  not_if '/bin/ls /usr/local/WowzaStreamingEngine/conf/Server.license'
end

# Restart Wowza
%w[ WowzaStreamingEngine WowzaStreamingEngineManager ].each do |wowza|
  service wowza do
    action [ :restart ]
  end
end

# Chmod /root/script.exp
file '/root/script.exp' do
  owner 'root'
  group 'root'
  mode '0400'
end

# Chmod wowza_path
file wowza_path do
  owner 'root'
  group 'root'
  mode '0400'
end
