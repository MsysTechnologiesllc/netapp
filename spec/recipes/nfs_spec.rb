require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::nfs' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates an nfs' do
      expect(chef_run).to enable_netapp_nfs('cluster2')
    end

    it 'deletes an nfs' do
      expect(chef_run).to disable_netapp_nfs('cluster3')
    end
  end
end