require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::aggregate' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a new aggregate' do
      expect(chef_run).to create_netapp_aggregate('aggr-demo').with(
          disk_count: 5
        )
    end

    it 'deletes an aggregate' do
      expect(chef_run).to delete_netapp_aggregate('aggr-del-demo')
    end
  end
end