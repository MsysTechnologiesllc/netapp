require_relative '../spec_helper'

describe 'netapp::default' do
  subject { ChefSpec::Runner.new.converge('netapp::default') }

  # Write quick specs using `it` blocks with implied subjects
  it { should include_recipe('netapp::default') }

  # Write full examples using the `expect` syntax
  it 'does something' do
    expect(subject).to include_recipe('netapp::default')
  end

  # Use an explicit subject
  let(:chef_run) { ChefSpec::Runner.new.converge('netapp::default') }

  it 'does something' do
    expect(chef_run).to include_recipe('netapp::default')
  end
end
