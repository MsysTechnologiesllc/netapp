require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::volume' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a new volume' do
      expect(chef_run).to create_netapp_volume('demo_vol').with(
          svm: "cluster2",
          aggregate: "aggr1",
          size: "250m"
        )
    end

    it 'deletes a volume' do
      expect(chef_run).to delete_netapp_volume('demo_del_vol').with(
          svm: "cluster2"
        )
    end
  end
end