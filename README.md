chef-wowza Cookbook
===================

Ansible role for Wowza 4.4.1
------------

This cookbook automates the installation of the Wowza Media Server 4.4.1, including their installer, which contains a very long EULA, and 5 interactive prompts.

Requirements
------------
- CentOS 6.7
- Java jdk - openjdk will be just fine.
- Wowza license - this you will get when you sign up for a free trial, or you can request a developer license.
- Wowza binary - the Wowza binary (4.4.1) is now wgetted as part of this role.

Attributes
----------
```
default['wowza_file'] = "WowzaStreamingEngine-4.4.1-linux-x64-installer.run"
default['wowza_download_path'] = "http://www.wowza.com/downloads/WowzaStreamingEngine-4-4-1"
default['user_name'] = "admin"
default['password'] = "admin"
default['license_key'] = "insert key between quotations"
```

Usage
-----
##### 1) Install knife-solo
```shell
apt-get update
curl -L https://www.opscode.com/chef/install.sh | sudo bash
/opt/chef/embedded/bin/gem install knife-solo --no-ri --no-rdoc
```

##### 2) Clone repository
```shell
mkdir ~/my_deploy_code
cd ~/my_deploy_code
knife solo init .
cd site-cookbooks/
git clone https://github.com/msergiy87/chef-wowza.git
```

##### 3) Prepare host
```shell
cd ~/my_deploy_code
knife solo prepare root@HOST -P 'PASS'
```

##### 4) Include `chef-wowza` in your node's `run_list`:
```shell
vim nodes/192.168.0.103.json
```
```json
{
  "run_list": [
    "recipe[chef-wowza]"
  ],
  "automatic": {
    "ipaddress": "192.168.0.103"
  }
}
```
##### 5) Add license key and change username and password
```shell
vim site-cookbooks/chef-wowza/attributes/default.rb

default['user_name'] = "admin"
default['password'] = "admin"
default['license_key'] = "insert key between quotations"
```

##### 6) Cook
```shell
knife solo cook root@HOST -P 'PASS'
```

##### 7) Add iptables rules on server
```shell
iptables -I INPUT -p tcp --dport 1935 -j ACCEPT
iptables -I INPUT -p tcp --dport 8088 -j ACCEPT
```

##### 8) Run web interface
```
http://192.168.0.103/enginemanager
```

Wowza needs several user actions on the interactive prompt portion of the installer:
- an acknowledgement of acceptance of their terms
- an administrative user added for using the Wowza console
- a password for the administrative user
- confirmation of that password
- Wowza license key
- an acknowledgement of whether or not you want Wowza to start at boot

Those values can be edited in the template/script.exp.erb file.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
