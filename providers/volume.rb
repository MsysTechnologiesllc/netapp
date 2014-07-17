# Cookbook Name:: netapp
# Provider:: aggregate
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
  request =  NaElement.new("volume-create")
  request.child_add_string("volume", new_resource.name)
  request.child_add_string("size", new_resource.size)
  request.child_add_string("containing-aggr-name", new_resource.aggregate)
  # Invoke NetApp API.
  result = invoke_api(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "volume","create")
end

action :delete do

  # Create API Request.
  request =  NaElement.new("volume-destroy")
  request.child_add_string("name", new_resource.name)

  # Invoke NetApp API.

  # The state of volume should be offline before deleting the volume.
  # Change the state of volume to offline from online.
  volume_offline_request = NaElement.new("volume-offline")
  volume_offline_request.child_add_string("name", new_resource.name)
  result = invoke_api(volume_offline_request, new_resource.svm)

  #Destroy volume
  result = invoke_api(request, new_resource.svm)

  # Check the result for any errors.
  check_result(result, "volume","delete")
end
