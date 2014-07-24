require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::svm' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a new svm' do
      expect(chef_run).to create_netapp_svm('demo-svm').with(
          security: 'unix',
          aggregate: 'aggr1',
          volume: "root_vs",
          nsswitch: ["nis"]
        )
    end

    it 'deletes an svm' do
      expect(chef_run).to delete_netapp_svm('del-svm')
    end
  end
end