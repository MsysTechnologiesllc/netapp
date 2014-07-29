#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Provider:: user
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

  #validations.
  raise ArgumentError, "Argument role is required for user creation" unless new_resource.role

  # Create API Request.
  netapp_user_api = netapp_hash

  netapp_user_api[:api_name] = "security-login-create"
  netapp_user_api[:resource] = "user"
  netapp_user_api[:action] = "create"

  netapp_user_api[:api_attribute]["application"] = new_resource.application
  netapp_user_api[:api_attribute]["authentication-method"] = new_resource.authentication
  netapp_user_api[:api_attribute]["role-name"] = new_resource.role
  netapp_user_api[:api_attribute]["user-name"] =  new_resource.name
  netapp_user_api[:api_attribute]["vserver"] = new_resource.vserver
  netapp_user_api[:api_attribute]["password"] = new_resource.password unless new_resource.password.nil?
  netapp_user_api[:api_attribute]["comment"] = new_resource.comment unless new_resource.comment.nil?

  unless new_resource.authentication == "urm"
    netapp_user_api[:api_attribute]["snmpv3-login-info"]["authentication-password"] = new_resource.authentication_password unless new_resource.authentication_password.nil?
    netapp_user_api[:api_attribute]["snmpv3-login-info"]["authentication-protocol"] = new_resource.authentication_protocol unless new_resource.authentication_protocol.nil?
    netapp_user_api[:api_attribute]["snmpv3-login-info"]["privacy-protocol"] = new_resource.privacy_protocol unless new_resource.privacy_protocol.nil?
    netapp_user_api[:api_attribute]["snmpv3-login-info"]["privacy-password"] = new_resource.privacy_password unless new_resource.privacy_password.nil?
    netapp_user_api[:api_attribute]["snmpv3-login-info"]["engine-id"] = new_resource.engine_id unless new_resource.engine_id.nil?
  end

  # Invoke NetApp API.
  invoke(netapp_user_api)
end

action :delete do

  # Create API Request.
  netapp_user_api = netapp_hash

  netapp_user_api[:api_name] = "security-login-delete"
  netapp_user_api[:resource] = "user"
  netapp_user_api[:action] = "delete"
  netapp_user_api[:api_attribute]["application"] = new_resource.application
  netapp_user_api[:api_attribute]["authentication-method"] = new_resource.authentication
  netapp_user_api[:api_attribute]["user-name"] = new_resource.name
  netapp_user_api[:api_attribute]["vserver"] = new_resource.vserver

  # Invoke NetApp API.
  invoke(netapp_user_api)
end
