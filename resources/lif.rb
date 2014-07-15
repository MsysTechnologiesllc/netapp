#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: lif
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

attribute :name, :kind_of => String, :required => true, :name_attribute => true #interface-name
attribute :svm, :kind_of => String, :required => true

#optional parameters
attribute :address, :kind_of => String
attribute :administrative_status, :kind_of => String, :equal_to => ["up", "down", "unknown"]
attribute :comment, :kind_of => String
attribute :data_protocols, :kind_of => Array
attribute :dns_domain_name, :kind_of => String
attribute :failover_group, :kind_of => String
attribute :failover_policy, :kind_of => String, :equal_to => ["nextavail", "priority", "disabled"]
attribute :firewall_policy, :kind_of => String
attribute :home_node, :kind_of => String
attribute :home_port, :kind_of => String
attribute :is_auto_revert, :kind_of => [TrueClass, FalseClass]
attribute :is_ipv4_link_local, :kind_of => [TrueClass, FalseClass]
attribute :listen_for_dns_query, :kind_of => [TrueClass, FalseClass]
attribute :netmask, :kind_of => String
attribute :netmask_length, :kind_of => Integer
attribute :return_record, :kind_of => [TrueClass, FalseClass]
attribute :role, :kind_of => String, :equal_to => ["undef", "cluster", "data", "node_mgmt", "intercluster", "cluster_mgmt"]
attribute :routing_group_name, :kind_of => String
attribute :use_failover_group, :kind_of => String, :equal_to => ["system_defined", "disabled", "enabled"]