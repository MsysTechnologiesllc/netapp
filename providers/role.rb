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

action :create do
  unless exists?
    #TODO create role
  end
  user_info = NaElement.new("useradmin-user-info")
  user_info.child_add_string("name", new_resource.name)
  user_info.child_add_string("comment", new_resource.comment) if new_resource.comment

  if new_resource.capabilities
    user_capabilities = NaElement.new("user-capabilities")

    new_resource.capabilities.each do |capability|
      user_capability = NaElement.new("useradmin-capability-info")
      user_capability.child_add_string("name",capability)
      user_capabilities.child_add(user_capability)
    end
    user_info.child_add(user_capabilities)
  end

  result = invoke("useradmin-role-add", "useradmin-role", user_info)
end

action :delete do
  if exists?
    #TODO delete role
  end

  result = invoke("useradmin-role-delete", "user-name", new_resource.name)
end

private
  def exists?
    #TODO check if role  exists
    true
  end