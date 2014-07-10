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

#optional attributes
attribute :allow_mixed_rpm, :kind_of => [TrueClass, FalseClass]
attribute :allow_same_carrier, :kind_of => [TrueClass, FalseClass]
attribute :block_type, :kind_of => String
attribute :checksum_style, :kind_of => String
attribute :disk_count, :kind_of => Integer
attribute :disk_size, :kind_of => Integer
attribute :disk_size_with_unit, :kind_of => String
attribute :disk_type, :kind_of => String
attribute :disks, :kind_of => Array
attribute :force_small_aggregate, :kind_of => [TrueClass, FalseClass]
attribute :force_spare_pool, :kind_of => [TrueClass, FalseClass]
attribute :ignore_pool_checks, :kind_of => [TrueClass, FalseClass]
attribute :is_mirrored, :kind_of => [TrueClass, FalseClass]
attribute :mirror_disks, :kind_of => Array
attribute :nodes, :kind_of => Array
attribute :pre_check, :kind_of => [TrueClass, FalseClass]
attribute :raid_size, :kind_of => Integer
attribute :raid_type, :kind_of => String
attribute :rpm, :kind_of => Integer
attribute :striping, :kind_of => String, :equal_to => ["striped", "not_striped", "unknown"]