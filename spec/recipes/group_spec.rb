require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::group' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a new group' do
      expect(chef_run).to create_netapp_group('unix_win').with(
          position: 1,
          pattern: "cifs",
          replacement: "EXAMPLE\\Domain Groups",
          svm: "cluster2"
        )
    end

    it 'deletes a group' do
      expect(chef_run).to delete_netapp_group('krb_unix').with(
          position: 1,
          svm: "cluster2"
        )
    end
  end
end