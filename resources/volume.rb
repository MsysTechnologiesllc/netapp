#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: volume
#
# Copyright:: 2014, Chef Software, Inc <legal@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :required => true, :name_attribute => true
attribute :svm, :kind_of => String
attribute :aggregate, :kind_of => String, :required => true
attribute :size, :kind_of => String, :required => true

attribute :role, :kind_of => String, :equal_to => ["namespace", "data", "ns_mirror"]
attribute :export_policy, :kind_of => String
attribute :flexcache_cache_policy, :kind_of => String # can be created only using "flexcache-cache-policy-crreate".
attribute :flexcache_fill_policy, :kind_of => String
attribute :flexcache_origin_volume_name, :kind_of => String
attribute :group_id, :kind_of => Integer
attribute :is_junction_active, :kind_of => [TrueClass, FalseClass]
attribute :is_nvfail_enabled, :kind_of => String
attribute :is_vserver_root, :kind_of => [TrueClass, FalseClass]
attribute :junction_path, :kind_of => String
attribute :language, :kind_of => String
attribute :max_dir_size, :kind_of => Integer
attribute :max_write_alloc_blocks, :kind_of => Integer
attribute :percentage_snapshot, :kind_of => Integer
attribute :qos_policy_group, :kind_of => String
attribute :snapshot_policy, :kind_of => String
attribute :space_reserve, :kind_of => String
attribute :storage_service, :kind_of => String
attribute :unix_permission, :kind_of => String
attribute :user_id, :kind_of => Integer
attribute :vm_align_sector, :kind_of => Integer
attribute :vm_align_suffix, :kind_of => String
attribute :comment, :kind_of => String
attribute :security_style, :kind_of => String, :equal_to => ["mixed", "ntfs", "unified", "unix"]
attribute :state, :kind_of => String, :equal_to => ["online", "restricted", "offline"]
attribute :type, :kind_of => String, :equal_to => ["rw", "ls", "dp", "dc"]