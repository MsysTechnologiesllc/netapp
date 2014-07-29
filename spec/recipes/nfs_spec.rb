require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::nfs' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates an nfs' do
      expect(chef_run).to create_netapp_nfs('demo-nfs').with(
        svm: "cluster2"
        )
    end

    it 'deletes an nfs' do
      expect(chef_run).to delete_netapp_nfs('demo-del-nfs').with(
          svm: "cluster2"
        )
    end
  end
end