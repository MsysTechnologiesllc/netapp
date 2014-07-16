require_relative '../spec_helper'

describe 'netapp::user' do
  subject { ChefSpec::Runner.new.converge('netapp::user') }

  it { should include_recipe('netapp::user') }

  context 'connection' do
    # Use an explicit subject
    let(:chef_run) {ChefSpec::Runner.new(step_into: ['user']).converge('netapp::user')}

    it 'should call netapp api invoke' do
      expect(chef_run).to include_recipe('netapp::user')
    end
  end
end
