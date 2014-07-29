require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::lif' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a network interface' do
      expect(chef_run).to create_netapp_lif('demo-interface').with(
        address: "192.168.1.200",
        home_node: "cluster1-01",
        home_port: "e0a",
        role: "cluster_mgmt",
        svm: "cluster1",
        netmask: "255.255.255.0"
        )
    end

    it 'deletes a network interface' do
      expect(chef_run).to delete_netapp_lif('demo-del-interface').with(
          svm: "cluster1"
        )
    end
  end
end