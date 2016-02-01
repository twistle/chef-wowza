chef-wowza Cookbook
===================
This cookbook automates the installation of the Wowza Media Server 4.3.0, including their installer, which contains a very long EULA, and 5 interactive prompts.

Requirements
------------
- CentOS 6.7
- Java jdk - openjdk will be just fine.
- Wowza license - this you will get when you sign up for a free trial, or you can request a developer license.
- Wowza binary - the Wowza binary (4.3.0) is now wgetted as part of this role.

Attributes
----------
```
default['wowza_version'] = "WowzaStreamingEngine-4.3.0-linux-x64-installer.run"
default['user_name'] = "admin"
default['password'] = "admin"
default['license_key'] = "XXX-XXXX-XXXX-XXXX-XXXX-XXXX-XXXXXX"
```

Usage
-----
Install knife-solo
```
knife solo prepare root@HOST -P 'PASS'
```
Just include `chef-wowza` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-wowza]"
  ]
}
```
```
knife solo cook root@HOST -P 'PASS'
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
