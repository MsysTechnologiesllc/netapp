# Cookbook Name:: netapp
# Provider:: iscsi
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
  request = NaElement.new("iscsi-service-create")
  request.child_add_string("alias-name", new_resource.alias) if new_resource.alias
  request.child_add_string("node-name", new_resource.node) if new_resource.node
  request.child_add_string("start", new_resource.start) if new_resource.start

  # Invoke NetApp API.
  result = invoke_elem(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "iscsi","create")
end

action :delete do

  # Create API Request.
  request = NaElement.new("iscsi-service-destroy")

  # Invoke NetApp API.
  result = invoke_elem(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "iscsi","delete")
end