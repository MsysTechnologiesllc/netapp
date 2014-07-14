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
  request = NaElement.new("security-login-role-create")
  request.child_add_string("role-name", new_resource.name)
  request.child_add_string("vserver", new_resource.svm)
  request.child_add_string("command-directory-name", new_resource.command_directory)
  request.child_add_string("access-level", new_resource.access_level) if new_resource.access_level
  request.child_add_string("return-record", new_resource.return_record) if new_resource.return_record
  request.child_add_string("role-query", new_resource.role_query) if new_resource.role_query

  # Invoke NetApp API.
  result = invoke_elem(request)

  # Check the result for any errors.
  if result.results_errno == 0
    Chef::Log.debug("Role #{new_resource.name} is created.")
  else
    raise "Role creation failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end

action :delete do

  # Create API Request.
  request = NaElement.new("security-login-role-delete")
  request.child_add_string("role-name", new_resource.name)
  request.child_add_string("vserver", new_resource.svm)
  request.child_add_string("command-directory-name", new_resource.command_directory)

  # Invoke NetApp API.
  result = invoke_elem(request)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "Role deletion failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end