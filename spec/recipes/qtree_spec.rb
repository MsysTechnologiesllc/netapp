require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::qtree' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a qtree' do
      expect(chef_run).to create_netapp_qtree('demo-tree').with(
          volume: "root_vs",
          svm: "demo-svm"
        )
    end

    it 'deletes a qtree' do
      expect(chef_run).to delete_netapp_qtree('/vol/root_vs/demo-tree').with(
          svm: "demo-svm"
        )
    end
  end
end