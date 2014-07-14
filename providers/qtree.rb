 # Cookbook Name:: netapp
# Provider:: qtree
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
  raise ArgumentError, "Attribute volume is required for qtree creation" unless new_resource.volume

  # Create API Request.
  request = NaElement.new("qtree-create")
  request.child_add_string("qtree", new_resource.name)
  request.child_add_string("volume", new_resource.volume)
  request.child_add_string("export_policy", new_resource.export_policy) if new_resource.export_policy
  request.child_add_string("mode", new_resource.mode) if new_resource.mode
  request.child_add_string("oplocks", new_resource.oplocks) if new_resource.oplocks
  request.child_add_string("security-style", new_resource.security) if new_resource.security

  # Invoke NetApp API.
  result = invoke_elem(request,new_resource.svm)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "qtree creation failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end

end

action :delete do

  # Create API Request.
  request = NaElement.new("qtree-delete")
  request.child_add_string("qtree", new_resource.name)
  request.child_add_string("force", new_resource.force) if new_resource.force

  # Invoke NetApp API.
  result = invoke_elem(request, new_resource.svm)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "qtree deletion failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end
