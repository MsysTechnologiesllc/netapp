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
  raise ArgumentError, "Attribute volume is required for SVM creation" unless new_resource.volume
  raise ArgumentError, "Attribute aggregate is required for SVM creation" unless new_resource.aggregate
  raise ArgumentError, "Attribute security if required for SVM creation" unless new_resource.security

  new_resource.nsswitch.each do |switch|
    raise ArgumentError, "Invalid name-server-switch \"#{switch}\". It must be nis/file/ldap" unless ["nis", "file", "ldap"].include? switch
  end

  if new_resource.nmswitch
    new_resource.nmswitch.each do |switch|
      raise ArgumentError, "Invalid name-mapping-switch \"#{switch}\". It must be file/ldap" unless ["file", "ldap"].include? switch
    end
  end

  # Create API Request.
  netapp_svm_api = netapp_hash

  netapp_svm_api[:api_name] = "vserver-create"
  netapp_svm_api[:resource] = "svm"
  netapp_svm_api[:action] = "create"
  netapp_svm_api[:api_attribute]["vserver-name"] = new_resource.name
  netapp_svm_api[:api_attribute]["root-volume-security-style"] = new_resource.security
  netapp_svm_api[:api_attribute]["root-volume-aggregate"] = new_resource.aggregate
  netapp_svm_api[:api_attribute]["root-volume"] = new_resource.volume
  netapp_svm_api[:api_attribute]["name-server-switch"]["nsswitch"] = new_resource.nsswitch

  #optional api fields
  netapp_svm_api[:api_attribute]["comment"] = new_resource.comment if (new_resource.comment)
  netapp_svm_api[:api_attribute]["is-repository-vserver"] = new_resource.is_repository_vserver if (new_resource.is_repository_vserver)
  netapp_svm_api[:api_attribute]["language"] =  new_resource.language if (new_resource.language)
  netapp_svm_api[:api_attribute]["name-mapping-switch"]["nmswitch"] = new_resource.nmswitch if new_resource.nmswitch
  netapp_svm_api[:api_attribute]["quota-policy"] =  new_resource.quota_policy if (new_resource.quota_policy)
  netapp_svm_api[:api_attribute]["return-record"] =  new_resource.return_record if (new_resource.return_record)
  netapp_svm_api[:api_attribute]["snapshot-policy"] = new_resource.snapshot_policy if (new_resource.snapshot_policy)

  # Invoke NetApp API.
  invoke(netapp_svm_api)
end

action :delete do

  # Create API request hash.
  netapp_svm_api = netapp_hash

  netapp_svm_api[:api_name] = "vserver-destroy"
  netapp_svm_api[:resource] = "svm"
  netapp_svm_api[:action] = "delete"
  netapp_svm_api[:api_attribute]["vserver-name"] = new_resource.name

  # Invoke NetApp API.
  invoke(netapp_svm_api)
end