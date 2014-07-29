# Cookbook Name:: netapp
# Provider:: group
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
  # validations.
  raise ArgumentError, "Attribute position is required for group creation" unless new_resource.pattern
  raise ArgumentError, "Attribute replacement is required for group creation" unless new_resource.replacement
  raise ArgumentError, "Attribute replacement is required for group creation" if new_resource.position > 1024 || new_resource.position < 1

  # Create API Request.
  netapp_group_api = netapp_hash

  netapp_group_api[:api_name] = "group-mapping-create"
  netapp_group_api[:resource] = "group"
  netapp_group_api[:action] = "create"
  netapp_group_api[:svm] = new_resource.svm
  netapp_group_api[:api_attribute]["direction"] = new_resource.name
  netapp_group_api[:api_attribute]["pattern"] = new_resource.pattern
  netapp_group_api[:api_attribute]["position"] = new_resource.position
  netapp_group_api[:api_attribute]["replacement"] = new_resource.replacement
  netapp_group_api[:api_attribute]["return-record"] = new_resource.return_record unless new_resource.return_record.nil?

  # Invoke NetApp API.
  invoke(netapp_group_api)
end

action :delete do
  # Create API Request.
  netapp_group_api = netapp_hash

  netapp_group_api[:api_name] = "group-mapping-delete"
  netapp_group_api[:resource] = "group"
  netapp_group_api[:action] = "delete"
  netapp_group_api[:svm] = new_resource.svm
  netapp_group_api[:api_attribute]["direction"] = new_resource.name
  netapp_group_api[:api_attribute]["position"] = new_resource.position

  # Invoke NetApp API.
  invoke(netapp_group_api)
end
