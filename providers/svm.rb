# Cookbook Name:: netapp
# Provider:: svm
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
  new_resource.nsswitch.each do |switch|
    raise ArgumentError, "Invalid name-server-switch \"#{switch}\". It must be nis/file/ldap" unless ["nis", "file", "ldap"].include? switch
  end

  if new_resource.nmswitch
    new_resource.nmswitch.each do |switch|
      raise ArgumentError, "Invalid name-mapping-switch \"#{switch}\". It must be file/ldap" unless ["file", "ldap"].include? switch
    end
  end

  # Create API Request.
  request =  NaElement.new("vserver-create")
  request.child_add_string("vserver-name", new_resource.name)
  request.child_add_string("root-volume-security-style", new_resource.security)
  request.child_add_string("root-volume-aggregate", new_resource.aggregate)
  request.child_add_string("root-volume", new_resource.volume)

  name_server_switch = NaElement.new("name-server-switch")

  new_resource.nsswitch.each do |switch|
    switch = NaElement.new("nsswitch", switch)
    name_server_switch.child_add(switch)
  end
  request.child_add(name_server_switch)

  request.child_add_string("comment", new_resource.comment) if (new_resource.comment)
  request.child_add_string("is-repository-vserver", new_resource.is_repository_vserver) if (new_resource.is_repository_vserver)
  request.child_add_string("language", new_resource.language) if (new_resource.language)

  if (new_resource.nmswitch)
    name_mapping_switch = NaElement.new("name-mapping-switch")

    new_resource.nmswitch.each do |switch|
      switch = NaElement.new("nmswitch", switch)
      name_mapping_switch.child_add(switch)
    end
    request.child_add(name_mapping_switch)
  end

  request.child_add_string("quota-policy", new_resource.quota_policy) if (new_resource.quota_policy)
  request.child_add_string("return-record", new_resource.return_record) if (new_resource.return_record)
  request.child_add_string("snapshot-policy", new_resource.snapshot_policy) if (new_resource.snapshot_policy)

  # Invoke NetApp API.
  result = invoke_elem(request)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "Vserver creation failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end

action :delete do
  #To-do
  #1- volume should be put to offline mode
  #2- volume should be deleted
  #3- delete vm

  request =  NaElement.new("vserver-destroy")
  request.child_add_string("vserver-name", new_resource.name)

  result = invoke_elem(request)

  if resut.results_errorno != 0
    Chef::Log.error("Vserver deletion failed.")
    Chef::Log.error("Error no- #{result.results_errno}. Reason- #{result.results_reason}.")
  end
end