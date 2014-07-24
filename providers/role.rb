# Cookbook Name:: netapp
# Provider:: role
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
  netapp_role_api = netapp_hash

  netapp_role_api[:api_name] = "security-login-role-create"
  netapp_role_api[:resource] = "role"
  netapp_role_api[:action] = "create"
  netapp_role_api[:api_attribute]["role-name"] = new_resource.name
  netapp_role_api[:api_attribute]["vserver"] = new_resource.svm
  netapp_role_api[:api_attribute]["command-directory-name"] = new_resource.command_directory
  netapp_role_api[:api_attribute]["access-level"] = new_resource.access_level if new_resource.access_level
  netapp_role_api[:api_attribute]["return-record"] = new_resource.return_record if new_resource.return_record
  netapp_role_api[:api_attribute]["role-query"] = new_resource.role_query if new_resource.role_query

  # Invoke NetApp API.
  invoke(netapp_role_api)
end

action :delete do

  # Create API Request.
  netapp_role_api = netapp_hash

  netapp_role_api[:api_name] = "security-login-role-delete"
  netapp_role_api[:resource] = "role"
  netapp_role_api[:action] = "delete"
  netapp_role_api[:api_attribute]["role-name"] = new_resource.name
  netapp_role_api[:api_attribute]["vserver"] = new_resource.svm
  netapp_role_api[:api_attribute]["command-directory-name"] = new_resource.command_directory

  # Invoke NetApp API.
  invoke(netapp_role_api)
end