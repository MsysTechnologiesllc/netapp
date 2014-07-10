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
  request = NaElement.new("security-login-create")
  request.child_add_string("application", new_resource.application)
  request.child_add_string("authentication-method", new_resource.authentication)
  request.child_add_string("role-name", new_resource.role)  # raise exception if parameter not supplied
  request.child_add_string("user-name", new_resource.name)
  request.child_add_string("vserver", new_resource.vserver)
  request.child_add_string("password", new_resource.password) if new_resource.password
  request.child_add_string("comment", new_resource.comment) if new_resource.comment

  if new_resource.authentication == "urm"
    snmpv3_login_info = NaElement.new("snmpv3-login-info")

    snmpv3_login_info_params = NaElement.new("snmpv3-login-info")
    snmpv3_login_info_params.child_add_string("authentication-password", new_resource.authentication_password) if new_resource.authentication_password
    snmpv3_login_info_params.child_add_string("authentication-protocol", new_resource.authentication_protocol) if new_resource.authentication_protocol
    snmpv3_login_info_params.child_add_string("privacy-protocol", new_resource.privacy_protocol) if new_resource.privacy_protocol
    snmpv3_login_info_params.child_add_string("privacy-password", new_resource.privacy_password) if new_resource.privacy_password
    snmpv3_login_info_params.child_add_string("engine-id", new_resource.engine_id) if new_resource.engine_id

    snmpv3_login_info.child_add(snmpv3_login_info_params)
    request.child_add(snmpv3_login_info)
  end

  result = invoke_elem(request)
end

action :delete do
  request = NaElement.new("security-login-delete")
  request.child_add_string("application", new_resource.application)
  request.child_add_string("authentication-method", new_resource.authentication)
  request.child_add_string("user-name", new_resource.name)
  request.child_add_string("vserver", new_resource.vserver)

  result = invoke_elem(request)
end
