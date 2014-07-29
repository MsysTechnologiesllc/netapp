require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::iscsi' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates an iscsi on cluster' do
      expect(chef_run).to create_netapp_iscsi('demo-cluster')
    end

    it 'destroys iscsi on cluster' do
      expect(chef_run).to delete_netapp_iscsi('demo-del-cluster')
    end
  end
end