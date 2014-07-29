# Cookbook Name:: netapp
# Provider:: lif
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
  raise ArgumentError, "Attribute home_node is required to create network interface" unless new_resource.home_node
  raise ArgumentError, "Attribute home_port is required to create network interface" unless new_resource.home_port
  raise ArgumentError, "Attribute role is required to create network interface" unless new_resource.role

  unless new_resource.data_protocols
    new_resource.data_protocols.each do |protocol|
      raise ArgumentError, "Invalid protocol \"#{protocol}\". It must be nfs/cifs/iscsi/fcp/fcache/none" unless ["nfs", "cifs", "iscsi", "fcp", "fcache", "none"].include? protocol
    end
  end

  # Create API Request.
  netapp_lif_api = netapp_hash

  netapp_lif_api[:api_name] = "net-interface-create"
  netapp_lif_api[:resource] = "lif"
  netapp_lif_api[:action] = "create"
  netapp_lif_api[:api_attribute]["vserver"] = new_resource.svm
  netapp_lif_api[:api_attribute]["home-node"] = new_resource.home_node
  netapp_lif_api[:api_attribute]["home-port"] = new_resource.home_port
  netapp_lif_api[:api_attribute]["interface-name"] = new_resource.name
  netapp_lif_api[:api_attribute]["role"] = new_resource.role
  netapp_lif_api[:api_attribute]["address"] = new_resource.address unless new_resource.address.nil?
  netapp_lif_api[:api_attribute]["administrative-status"] = new_resource.administrative_status unless new_resource.administrative_status.nil?
  netapp_lif_api[:api_attribute]["comment"] = new_resource.comment unless new_resource.comment.nil?
  #Todo- verify
  netapp_lif_api[:api_attribute]["data-protocols"] = new_resource.data_protocols unless new_resource.data_protocols.nil?
  netapp_lif_api[:api_attribute]["failover-group"] = new_resource.failover_group unless new_resource.failover_group.nil?
  netapp_lif_api[:api_attribute]["failover-policy"] = new_resource.failover_policy unless new_resource.failover_policy.nil?
  netapp_lif_api[:api_attribute]["firewall-policy"] = new_resource.firewall_policy unless new_resource.firewall_policy.nil?
  netapp_lif_api[:api_attribute]["is-auto-revert"] = new_resource.is_auto_revert unless new_resource.is_auto_revert.nil?
  netapp_lif_api[:api_attribute]["is-ipv4-link-local"] = new_resource.is_ipv4_link_local unless new_resource.is_ipv4_link_local.nil?
  netapp_lif_api[:api_attribute]["listen-for-dns-query"] = new_resource.listen_for_dns_query unless new_resource.listen_for_dns_query.nil?
  netapp_lif_api[:api_attribute]["netmask"] = new_resource.netmask unless new_resource.netmask.nil?
  netapp_lif_api[:api_attribute]["netmask-length"] = new_resource.netmask_length unless new_resource.netmask_length.nil?
  netapp_lif_api[:api_attribute]["return-record"] = new_resource.return_record unless new_resource.return_record.nil?
  netapp_lif_api[:api_attribute]["routing-group"] = new_resource.routing_group unless new_resource.routing_group_name.nil?
  netapp_lif_api[:api_attribute]["use-failover-group"] = new_resource.use_failover_group unless new_resource.use_failover_group.nil?

  # Invoke NetApp API.
  invoke(netapp_lif_api)
end

action :delete do

  # Create API Request.
  netapp_lif_api = netapp_hash

  netapp_lif_api[:api_name] = "net-interface-delete"
  netapp_lif_api[:resource] = "lif"
  netapp_lif_api[:action] = "delete"
  netapp_lif_api[:api_attribute]["vserver"] = new_resource.svm
  netapp_lif_api[:api_attribute]["interface-name"] = new_resource.name

  # Invoke NetApp API.
  invoke(netapp_lif_api)
end