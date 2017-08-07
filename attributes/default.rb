#
# Cookbook Name:: chef-wowza
# Attributes:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default['wowza']['download_file'] = "WowzaStreamingEngine-4.5.0-linux-x64-installer.run"
default['wowza']['download_path'] = "https://www.wowza.com/downloads/WowzaStreamingEngine-4-5-0"
default['wowza']['user_name'] = "admin"
default['wowza']['password'] = "admin"
default['wowza']['version'] = "4.5.0"
default['wowza']['license_key'] = "insert key between quotations"

