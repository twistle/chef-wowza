#
# Cookbook Name:: chef-wowza
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

wowza_file = node['wowza_file']
wowza_path = "/root/#{wowza_file}"

#backup_dir = "/var/backup/#{node['hostname']}"

# Upgrade
execute 'yum update -y' do
  command 'yum update -y'
end

# Install OpenJDK 7 JDK, expect
package ['java-1.7.0-openjdk-devel', 'expect'] do
  action :install
end

# Download package Wowza
remote_file "/root/#{node['wowza_file']}" do
  source "http://www.wowza.com/downloads/#{wowza_download_path}/#{wowza_file}"
  owner "root"
  group "root"
  mode "0755"
  action :create_if_missing
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
