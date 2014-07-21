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

action :create do
  # Create API Request.
  netapp_nfs_api = netapp_hash

  netapp_nfs_api[:api_name] = "nfs-exportfs-append-rules-2"
  netapp_nfs_api[:resource] = "nfs"
  netapp_nfs_api[:action] = "create"
  netapp_nfs_api[:svm] = new_resource.svm

  netapp_nfs_api[:api_attribute]["persistent"] = new_resource.persistent if new_resource.persistent
  netapp_nfs_api[:api_attribute]["verbose"] = new_resource.verbose if new_resource.verbose
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["pathname"] = new_resource.name
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["anon"] = new_resource.anon if new_resource.anon
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["nosuid"] = new_resource.nosuid if new_resource.nosuid
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["all-hosts"] = new_resource.read_only_all_hosts if new_resource.read_only_all_hosts
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["name"] = new_resource.read_only_name if new_resource.read_only_name
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-only"]["exports-hostname-info"]["negate"] = new_resource.read_only_negate if new_resource.read_only_negate
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["all-hosts"] = new_resource.read_write_all_hosts if new_resource.read_write_all_hosts
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["name"] = new_resource.read_write_name if new_resource.read_write_name
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["read-write"]["exports-hostname-info"]["negate"] = new_resource.read_write_negate if new_resource.read_write_negate
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["all-hosts"] = new_resource.root_all_hosts if new_resource.root_all_hosts
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["name"] = new_resource.root_name if new_resource.root_name
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["root"]["exports-hostname-info"]["negate"] = new_resource.root_negate if new_resource.root_negate
  netapp_nfs_api[:api_attribute]["rules"]["exports-rule-info-2"]["security-rules"]["security-rule-info"]["sec-flavor"]["sec-flavor-info"]["flavor"] = new_resource.flavor if new_resource.flavor

  # Invoke NetApp API.
  invoke(netapp_nfs_api)

end

action :delete do
  # Create API Request.
  netapp_nfs_api = netapp_hash

  netapp_nfs_api[:api_name] = "nfs-exportfs-delete-rules"
  netapp_nfs_api[:resource] = "nfs"
  netapp_nfs_api[:action] = "delete"
  netapp_nfs_api[:svm] = new_resource.svm

  netapp_nfs_api[:api_attribute]["pathnames"]["pathname-info"]["name"] = new_resource.name
  netapp_nfs_api[:api_attribute]["persistent"] = new_resource.persistent if new_resource.persistent
  netapp_nfs_api[:api_attribute]["verbose"] = new_resource.verbose if new_resource.verbose

  # Invoke NetApp API.
  invoke(netapp_nfs_api)
end