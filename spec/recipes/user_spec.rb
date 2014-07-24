require_relative '../spec_helper'
require_relative '../helpers/matchers'

describe 'netapp::user' do
  context 'without :step_into' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe)}

    it 'creates a new user' do
      expect(chef_run).to create_netapp_user('demo-user').with(
          vserver: "demo-svm",
          role: "demo-role",
          application: "ontapi",
          authentication: "password",
          password: "demo001"
        )
    end

    it 'deletes an user' do
      expect(chef_run).to delete_netapp_user('demo-del-user').with(
          vserver: "demo-svm",
          application: "ontapi",
          authentication: "password"
        )
    end
  end
end