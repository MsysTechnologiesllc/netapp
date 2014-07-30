require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::nfs' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'enables an nfs' do
      expect(chef_run).to enable_netapp_nfs('cluster1')
    end

    it 'deletes an nfs' do
      expect(chef_run).to disable_netapp_nfs('cluster2')
    end

    it 'appends a rule' do
      expect(chef_run).to add_rule_netapp_nfs('cluster3').with(
          pathname: "/vol/root_vs",
          read_write_all_hosts: true
        )
    end

    it 'modifies a rule' do
      expect(chef_run).to modify_rule_netapp_nfs('cluster4').with(
          pathname: "/vol/root_vs",
          read_write_all_hosts: false
        )
    end

    it 'deletes a rule' do
      expect(chef_run).to delete_rule_netapp_nfs('cluster5')
    end
  end
end