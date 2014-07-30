# Cookbook Name:: netapp
# Provider:: nfs
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

include NetApp::Api

action :enable do

  # Create API Request.
  netapp_nfs_enable_api = netapp_hash

  netapp_nfs_enable_api[:api_name] = "nfs-enable"
  netapp_nfs_enable_api[:resource] = "nfs"
  netapp_nfs_enable_api[:action] = "enable"
  netapp_nfs_enable_api[:svm] = new_resource.name

  #Create and enable NFS service on the vserver
  invoke(netapp_nfs_enable_api)
  new_resource.updated_by_last_action(true)
end

action :disable do

  # Create API Request.
  netapp_nfs_disable_api = netapp_hash

  netapp_nfs_disable_api[:api_name] = "nfs-disable"
  netapp_nfs_disable_api[:resource] = "nfs"
  netapp_nfs_disable_api[:action] = "disable"
  netapp_nfs_disable_api[:svm] = new_resource.name

  #Create and enable NFS service on the vserver
  invoke(netapp_nfs_disable_api)
  new_resource.updated_by_last_action(true)
end

action :add_rule do

  # validations.
  raise ArgumentError, "Attribute Pathname is required to append export rules" unless new_resource.pathname

  # Create API Request.
  netapp_nfs_add_rule_api = netapp_hash

  netapp_nfs_add_rule_api[:api_name] = "nfs-exportfs-append-rules-2"
  netapp_nfs_add_rule_api[:resource] = "nfs"
  netapp_nfs_add_rule_api[:action] = "add_rule"
  netapp_nfs_add_rule_api[:svm] = new_resource.name

  netapp_nfs_add_rule_api[:api_attribute]["persistent"] = new_resource.persistent unless new_resource.persistent.nil?
  netapp_nfs_add_rule_api[:api_attribute]["verbose"] = new_resource.verbose unless new_resource.verbose.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["pathname"] = new_resource.pathname
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["anon"] = new_resource.anon unless new_resource.anon.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["nosuid"] = new_resource.nosuid unless new_resource.nosuid.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["all-hosts"] = new_resource.read_only_all_hosts unless new_resource.read_only_all_hosts.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["name"] = new_resource.read_only_name unless new_resource.read_only_name.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["negate"] = new_resource.read_only_negate unless new_resource.read_only_negate.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["all-hosts"] = new_resource.read_write_all_hosts unless new_resource.read_write_all_hosts.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["name"] = new_resource.read_write_name unless new_resource.read_write_name.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["negate"] = new_resource.read_write_negate unless new_resource.read_write_negate.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["all-hosts"] = new_resource.root_all_hosts unless new_resource.root_all_hosts.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["name"] = new_resource.root_name unless new_resource.root_name.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["negate"] = new_resource.root_negate unless new_resource.root_negate.nil?
  netapp_nfs_add_rule_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["sec-flavor"]["sec-flavor-info"]["flavor"] = new_resource.flavor unless new_resource.flavor.nil?

  # Invoke NetApp API.
  invoke(netapp_nfs_add_rule_api)
  new_resource.updated_by_last_action(true)
end

action :modify_rule do

  # validations.
  raise ArgumentError, "Attribute Pathname is required to modify export rules" unless new_resource.pathname
  raise ArgumentError, "Attribute Persistent is required to modify export rules" unless new_resource.pathname

  # Create API Request.
  netapp_nfs_modify_rule_api = netapp_hash

  netapp_nfs_modify_rule_api[:api_name] = "nfs-exportfs-modify-rule-2"
  netapp_nfs_modify_rule_api[:resource] = "nfs"
  netapp_nfs_modify_rule_api[:action] = "modify_rule"
  netapp_nfs_modify_rule_api[:svm] = new_resource.name

  netapp_nfs_modify_rule_api[:api_attribute]["persistent"] = new_resource.persistent
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["pathname"] = new_resource.pathname
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["anon"] = new_resource.anon unless new_resource.anon.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["nosuid"] = new_resource.nosuid unless new_resource.nosuid.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["all-hosts"] = new_resource.read_only_all_hosts unless new_resource.read_only_all_hosts.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["name"] = new_resource.read_only_name unless new_resource.read_only_name.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["negate"] = new_resource.read_only_negate unless new_resource.read_only_negate.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["all-hosts"] = new_resource.read_write_all_hosts unless new_resource.read_write_all_hosts.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["name"] = new_resource.read_write_name unless new_resource.read_write_name.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["negate"] = new_resource.read_write_negate unless new_resource.read_write_negate.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["all-hosts"] = new_resource.root_all_hosts unless new_resource.root_all_hosts.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["name"] = new_resource.root_name unless new_resource.root_name.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["negate"] = new_resource.root_negate unless new_resource.root_negate.nil?
  netapp_nfs_modify_rule_api[:api_attribute]["rule"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["sec-flavor"]["sec-flavor-info"]["flavor"] = new_resource.flavor unless new_resource.flavor.nil?

  # Invoke NetApp API.
  invoke(netapp_nfs_modify_rule_api)
  new_resource.updated_by_last_action(true)
end

action :delete_rule do

   # validations.
  raise ArgumentError, "Attribute Pathname is required to delete export rules" unless new_resource.pathname

  # Create API Request.
  netapp_nfs_delete_rule_api = netapp_hash

  netapp_nfs_delete_rule_api[:api_name] = "nfs-exportfs-delete-rules"
  netapp_nfs_delete_rule_api[:resource] = "nfs"
  netapp_nfs_delete_rule_api[:action] = "delete_rule"
  netapp_nfs_delete_rule_api[:svm] = new_resource.name

  netapp_nfs_delete_rule_api[:api_attribute]["pathnames"]["pathname-info"]["name"] = new_resource.pathname
  netapp_nfs_delete_rule_api[:api_attribute]["persistent"] = new_resource.persistent unless new_resource.persistent.nil?
  netapp_nfs_delete_rule_api[:api_attribute]["verbose"] = new_resource.verbose unless new_resource.verbose.nil?

  # Invoke NetApp API.
  invoke(netapp_nfs_delete_rule_api)
  new_resource.updated_by_last_action(true)
end