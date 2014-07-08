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
  user_info = NaElement.new("useradmin-user-info")

  # Add values
  user_info.child_add_string("name", new_resource.name)
  user_info.child_add_string("status", new_resource.status) if new_resource.status
  user_info.child_add_string("password-minimum-age", new_resource.passminage) if new_resource.passminage
  user_info.child_add_string("password-maximum-age", new_resource.passmaxage) if new_resource.passminage

  # Create user-groups container
  user_groups = NaElement.new("user-groups")

  new_resource.groups.each do |group|
    group_info = NaElement.new("useradmin-group-info")
    group_info.child_add_string("name", group)
    user_groups.child_add(group_info)
  end

  # Put it all together
  user_info.child_add(user_groups)

  # Add the user
  result = invoke("useradmin-user-add","password", @resource[:password], "useradmin-user", user_info)
end

action :delete do
  result = invoke("useradmin-user-delete", "user-name", new_resource.name)
end