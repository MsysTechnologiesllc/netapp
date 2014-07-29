require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::feature' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'adds a new feature' do
      expect(chef_run).to enable_netapp_feature('demo-feature').with(
          codes: ["CAYHXPKBFDUFZGABGAAAAAAAAAAA"]
        )
    end
  end
end