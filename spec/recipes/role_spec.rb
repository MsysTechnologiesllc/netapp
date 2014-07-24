require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::role' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a role' do
      expect(chef_run).to create_netapp_role('demo-role').with(
          svm: "demo-svm",
          command_directory: "volume"
        )
    end

    it 'deletes a role' do
      expect(chef_run).to delete_netapp_role('demo-del-role').with(
        svm: "demo-svm",
        command_directory: "DEFAULT"
        )
    end
  end
end