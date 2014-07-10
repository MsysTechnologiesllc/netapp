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
  unless exists?
    #TODO create group
  end
  user_info = NaElement.new("useradmin-user-info")
  user_info.child_add_string("name", new_resource.name)
  user_info.child_add_string("comment", new_resource.comment) if new_resource.comment

  if new_resource.roles
    user_roles = NaElement.new("user-roles")

    new_resource.roles.each do |role|
      user_role = NaElement.new("useradmin-role-info")
      user_role.child_add_string("name",role)
      user_roles.child_add(user_role)
    end
    user_info.child_add(user_roles)
  end

  result = invoke("useradmin-group-add", "useradmin-group", user_info)
end

action :delete do
  if exists?
    #TODO delete group
  end

  result = invoke("useradmin-group-delete", "group-name", new_resource.name)
end

private
  def exists?
    #TODO check if group exists
    true
  end