netapp Cookbook
===============
The netapp cookbook manages the Clustered Data ONTAP (CDOT) filers using the NetApp ZAPI. The actions are cluster-wide or Storage Virtual Machine (SVM, formerly known as Vservers) specific.

Requirements
------------
#### NetApp Manageability SDK Library v5.0
You can download it from [NetApp](http://mysupport.netapp.com/NOW/cgi-bin/software?product=NetApp+Manageability+SDK&platform=All+Platforms) after you have created an account on [NetApp NOW](https://support.netapp.com/eservice/public/now.do)

NetApp connection
-----------------
The ZAPI connection is made over HTTP or HTTPS, with a user account that exists on the NetApp storage cluster. The user is only granted HTTP login and API roles, meaning that the user has no permission to do anything outside of ZAPI. The root user account also works but NetApp does not recommend using it. The connection settings are managed by attributes in the cookbook but are also exposed in Common attributes for the NetApp Resources.

    ['netapp']['url'] = 'https://root:secret@pfiler01.example.com/vfiler01'

or

    ['netapp']['https'] boolean, default is 'true'.
    ['netapp']['user'] string
    ['netapp']['password'] string
    ['netapp']['fqdn'] string
    ['netapp']['virtual_filer'] string

NetApp Resources
================

Common Attributes
-----------------
In addition to those provided by Chef itself (`ignore_failure`, `retries`, `retry_delay`, etc.), the connection attribute(s) are exposed all NetApp Resources even though they are typically set by attributes.

Common Actions
--------------
The `:nothing` action is provided by Chef for all Resources for use with notifications and subscriptions.

netapp_user
-----------
Cluster management of user creation, modification and deletion.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the user is in this state.
* `:delete` Removes the user

### Attributes ###
This resource has the following attributes:

* `name` string, name attribute. Required
* `password` string.
* `status` string. Valid values are `enabled`, `disabled` and `expired`. Default is `enabled`.
* `passminage` integer. Number of days the user’s password must be active before it may be changed. Default is 0.
* `passmaxage` integer. Number of days the user’s password can be active before the user must change it.
* `groups` Array of groups for this user account.

### Example ###

````ruby
netapp_user 'joe' do
  password 'foobar'
  groups ['admins']
  action :create
end
````

````ruby
netapp_user 'henry' do
  action :delete
end
````

netapp_group
------------
Cluster management of group creation, modification and deletion.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the group is in this state.
* `:delete` Removes the group

### Attributes ###
This resource has the following attributes:

* `name` string, name attribute. Required
* `comment` string.
* `roles` Array of roles for this group.

### Example ###

````ruby
netapp_group 'admins' do
  comments 'keep the trains on time'
  roles ['security']
  action :create
end
````

````ruby
netapp_group 'read-only' do
  action :delete
end
````

netapp_role
-----------
Cluster management of role creation, modification and deletion.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the role is in this state.
* `:delete` Removes the role

### Attributes ###
This resource has the following attributes:

* `name` string, name attribute. Required
* `comment` string.
* `capabilities` Array of capabilities for this role.

### Example ###

````ruby
netapp_role 'security' do
  comment 'security'
  action :create
end
````

````ruby
netapp_role 'superusers' do
  action :delete
end
````

netapp_feature
--------------
Cluster management of NetApp features by license. See API docs for "license-v2".

### Actions ###
This resource has the following action:

* `:enable` Default. Ensures the NetApp provides this feature.

### Attributes ###
This resource has the following attributes:

* `package` string, name attribute. Required
* `code` string, license code when adding a package. 24 or 48 uppercase alpha only characters.

### Example ###

````ruby
netapp_feature 'iscsi do
  code 'ABCDEFGHIJKLMNOPQRSTUVWX'
  action :enable
end
````

netapp_svm
----------
Cluster-level management of a data Storage Virtual Machines (SVMs). SVM-level management is done through other resources. After the cluster setup, a cluster administrator must create data SVMs and add volumes to these SVMs to facilitate data access from the cluster. A cluster must have at least one data SVM to serve data to its clients.

(Follow the "Completing the SVM setup worksheet" section of the Clustered_Data_ONTAP_82_System_Administration.pdf)

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the svm is in this state.
* `:delete` Removes the svm

### Attributes ###
This resource has the following attributes:

* `name` string, name attribute. Required. SVM names can contain a period (.), a hyphen (-), or an underscore (_), but must not start with a hyphen, period, or number. The maximum number of characters allowed in SVM names is 47.
* `protocols` array of strings. Protocols that you want to configure or allow on that SVM.
* `services` array of strings. Services that you want to configure on the SVM.
* `aggregate` string. Aggregate on which you want to create the root volume for the SVM. The default aggregate name is used if you do not specify one.
* `language` string. If you do not specify the language, the default language `C.UTF-8` or `POSIX.UTF-8` is used.???
* `security` string. Determines the type of permissions that can be used to control data access to a volume. Default is `unix`.

### Example ###

````ruby
netapp_svm 'vs1.example.com' do
  protocols ['nfs', 'iscsi']
  services ['file']
  language 'POSIX.UTF-8'
  aggregate 'aggr1'
  action :create
end
````

netapp_volume
-------------
SVM-management of volume creation, modification and deletion including auto-increment, snapshot schedules and volume options.

(Follow the "Completing the SVM setup worksheet" section of the Clustered_Data_ONTAP_82_System_Administration.pdf)
vserver setup -vserver vs2.example.com -storage true

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the volume is in this state.
* `:delete` Removes the volume

### Attributes ###
This resource has the following attributes:

* `name` string, name attribute. Volume name. Required.
* `svm` string. Name of managed SVM. Required
* `aggregate` string. Required
* `size` string (1-9kmgt). Required

### Example ###

````ruby
netapp_volume '/foo' do
  svm 'vs1.example.com'
  aggregate 'aggr1'
  size '5t'
  action :create
end
````

````ruby
netapp_volume 'bar' do
  action :delete
end
````

netapp_lif
----------
SVM-management of logical interface (LIF) creation, modification and deletion.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the lif is in this state.
* `:delete` Removes the lif

### Attributes ###
This resource has the following attributes:

* `name` name attribute. LIF name. Required
* `svm` Name of managed SVM. Required
* `address`
* `administrative_status` valid values "up", "down", "unknown"
* `comment`
* `data_protocols`
* `dns_domain_name`
* `failover_group`
* `failover_policy` valid values "nextavail", "priority", "disabled"
* `firewall_policy`
* `home_node`
* `home_port`
* `is_auto_revert`
* `is_ipv4_link_local`
* `listen_for_dns_query`
* `netmask`
* `netmask_length`
* `return_record`
* `role` valid values "undef", "cluster", "data", "node_mgmt", "intercluster", "cluster_mgmt"
* `routing_group_name`
* `use_failover_group` valid values "system_defined", "disabled", "enabled"
* 

### Example ###

````ruby
netapp_lif 'private' do
  svm 'vs1.example.com'
  action :create
end
````

````ruby
netapp_lif 'public' do
  action :delete
end
````

netapp_iscsi
----------
SVM-management of iSCSI target creation, modification and deletion.

### Actions ###
This resource has the following actions:

* `:create` Default. Creates iSCSI service.
* `:delete` Removes the target

### Attributes ###
This resource has the following attributes:

* `svm` Name of managed SVM. Required
* `alias`
* `node`
* `start` True or False. True by default.

### Example ###

````ruby
netapp_iscsi 'foo' do
  svm 'vs1.example.com'
  action :create
end
````

````ruby
netapp_iscsi 'bar' do
  action :delete
end
````

netapp_nfs
----------
SVM-management of NFS export rule creation, modification and deletion including NFS export security. Rule changes are persistent.

You do not need to enter any information to configure NFS on the SVM. The NFS configuration is created when you specify the protocol value as `nfs`.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the NFS export is in this state.
* `:delete` Removes the NFS export

### Attributes ###
This resource has the following attributes:
* `pathname` string, name attribute. Required
* `svm` string. Name of managed SVM. Required
* `security_rules` hash. Access block information for lists of hosts.

### Example ###

````ruby
netapp_nfs '/vol/vol0' do
  svm 'vs1.example.com'
  action :create
end
````

````ruby
netapp_export '/vol/vol1' do
  svm 'vs1.example.com'
  action :delete
end
````

netapp_qtree
------------
SVM-management of qtree creation, modification and deletion. Qtrees are a special subdirectory of the root of a volume that acts as a virtual subvolume with special attributes.

### Actions ###
This resource has the following actions:

* `:create` Default. Ensures the QTree is in this state.
* `:delete` Removes the QTree

### Attributes ###
This resource has the following attributes:

* `name` name attribute. The path of the qtree, relative to the volume. Required
* `svm` Name of managed SVM. Required
* `volume` Name of the volume on which to create the qtree. Required.
* `export_policy` Export policy of the qtree. If this input is not specified, the qtree will inherit the export policy of the parent volume.
* `mode` The file permission bits of the qtree, similar to UNIX permission bits. If this argument is missing, the permissions of the volume is used.
* `oplocks` Opportunistic locks mode of the qtree. Possible values: "enabled", "disabled". Default value is the oplock mode of the volume.
* `security` Security style of the qtree. Possible values: "unix", "ntfs", or "mixed". Default value is the security style of the volume.
* `force` True or false

### Example ###

````ruby
netapp_qtree '/share' do
  svm 'vs1.example.com'
  volume '/foo'
  action :create
end
````

````ruby
netapp_role '/bar' do
  svm 'vs1.example.com'
  volume '/foo'
  action :delete
end
````


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
- Authors:: Arjun Hariharan (Arjun.Hariharan@Clogeny.com)

```text
Copyright 2014 Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
