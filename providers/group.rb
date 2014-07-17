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
  request =  NaElement.new("group-mapping-create")
  request.child_add_string("direction", new_resource.direction)
  request.child_add_string("pattern", new_resource.pattern)
  request.child_add_string("position", new_resource.position)
  request.child_add_string("replacement", new_resource.replacement)

  request.child_add_string("return-record", new_resource.return_record) if new_resource.return_record

  # Invoke NetApp API.
  result = invoke_api(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "group","create")
end

action :delete do
  # Create API Request.
  request =  NaElement.new("group-mapping-delete")
  request.child_add_string("direction", new_resource.direction)
  request.child_add_string("position", new_resource.position)

  # Invoke NetApp API.
  result = invoke_api(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "group","create")
end
