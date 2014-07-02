require_relative '../spec_helper'

describe 'netapp::user' do
  subject { ChefSpec::Runner.new.converge('netapp::user') }

  # Write quick specs using `it` blocks with implied subjects
  it { should include_recipe('netapp::user') }

  # Write full examples using the `expect` syntax
  it 'does something' do
    expect(subject).to include_recipe('netapp::user')
  end

  # Use an explicit subject
  let(:chef_run) { ChefSpec::Runner.new.converge('netapp::user') }

  it 'does something' do
    expect(chef_run).to include_recipe('netapp::user')
  end
end
