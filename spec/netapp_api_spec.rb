require_relative 'spec_helper'
require_relative '../libraries/netapp_api'
require_relative '../libraries/NaServer'
require_relative '../libraries/NaElement'

class Netapp_Wrapper
  include NetApp::Api
end

describe 'create netapp connection' do
  context 'when url is provided' do
    before do
      @netapp = Netapp_Wrapper.new
      @netapp.define_singleton_method(:node) do
        node = Hash.new
        node['netapp'] = {'url' => "http://root:secret@pfiler01.example.com/vfiler01" }
        node['netapp']['api'] = {'timeout' => 40000 }
        node
      end
      @server = double
    end
    it 'connects to netapp server' do
      expect(NaServer).to receive(:new).with("pfiler01.example.com",1,13).and_return(@server)
      expect(@server).to receive(:set_admin_user).with("root", "secret")
      expect(@server).to receive(:set_transport_type).with("HTTP")
      expect(@server).to receive(:set_port).with(80)
      expect(@server).to receive(:set_vfiler).with("vfiler01")
      expect(@server).to receive(:set_timeout).with(40000)

      @netapp.connect
    end
  end

  context 'when login credentials are passed separately' do
    before do
      @netapp = Netapp_Wrapper.new
      @netapp.define_singleton_method(:node) do
        node =  Hash.new
        node['netapp'] = Hash.new
        node['netapp']['user'] = "root"
        node['netapp']['password'] = "secret"
        node['netapp']['fqdn'] = "pfiler01.example.com"
        node['netapp']['https'] = true
        node['netapp']['virtual_filer'] = "vfiler01"
        node['netapp']['api'] = {'timeout' => 40000}
        node
      end
      @server = double
    end
    it 'connects to netapp server' do
      expect(NaServer).to receive(:new).with("pfiler01.example.com",1,13).and_return(@server)
      expect(@server).to receive(:set_admin_user).with("root", "secret")
      expect(@server).to receive(:set_transport_type).with("HTTPS")
      expect(@server).to receive(:set_port).with(443)
      expect(@server).to receive(:set_vfiler).with("vfiler01")
      expect(@server).to receive(:set_timeout).with(40000)

      @netapp.connect
    end
  end
end

describe 'invoke method' do
  before do
    @netapp = Netapp_Wrapper.new
    @request = double
    @response = double

    @api_hash = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc)}
    @api_hash[:api_name] = "test_api"
    @api_hash[:api_attribute] = "test_attribute"
    @api_hash[:resource] = "test_resource"
    @api_hash[:action] = "test_action"
  end

  it 'creates a server object, calls netapp api and checks for errors when svm is not set' do
    expect(@netapp).to receive(:generate_request).with("test_api", "test_attribute").and_return(@request)
    expect(@netapp).to receive(:invoke_api).with(@request).and_return(@response)
    expect(@netapp).to receive(:check_errors!).with(@response, "test_resource", "test_action")

    @netapp.invoke(@api_hash)
  end

  it 'creates a server object, calls netapp api and checks for errors when svm is set' do
    @api_hash[:svm] = "test_svm"
    expect(@netapp).to receive(:generate_request).with("test_api", "test_attribute").and_return(@request)
    expect(@netapp).to receive(:invoke_api).with(@request, "test_svm").and_return(@response)
    expect(@netapp).to receive(:check_errors!).with(@response, "test_resource", "test_action")

    @netapp.invoke(@api_hash)
  end
end

describe 'invoke_api method' do
  before do
    @netapp = Netapp_Wrapper.new
    @request = double
    @server = double
  end

  it 'invokes netapp api using default vfiler specified in the url' do
    expect(@netapp).to receive(:connect).and_return(@server)
    expect(@server).to receive(:invoke_elem).with(@request)

    @netapp.invoke_api(@request)
  end

  it 'invokes netapp api by by using tunneled connection to vfiler' do
    expect(@netapp).to receive(:connect).and_return(@server)
    expect(@server).to receive(:set_vfiler).with("test_svm")
    expect(@server).to receive(:invoke_elem).with(@request)

    @netapp.invoke_api(@request, "test_svm")
  end
end

describe 'generate request' do
  before do
    @netapp = Netapp_Wrapper.new
    @request = double
    @response = double

    @api_hash = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc)}
    @api_hash[:api_name] = "vserver-create"
    @api_hash[:resource] = "create"
    @api_hash[:action] = "create"
  end

  it 'creates an NaElement with the value' do
    @api_hash[:attributes]["vserver-name"] = "test-svm"

    api_request = NaElement.new("vserver-create")
    api_request.child_add_string("vserver-name", "test-svm")

    expect(@netapp.generate_request(@api_hash[:api_name],@api_hash[:attributes])).to equal_netapp_element(api_request)
  end

  it 'create an array of child elements' do
    @api_hash[:attributes]["ns-switch"] = ["file", "nis"]

    api_request = NaElement.new("vserver-create")
    api_request.child_add_string("ns-switch", "file")
    api_request.child_add_string("ns-switch", "nis")

    expect(@netapp.generate_request(@api_hash[:api_name],@api_hash[:attributes])).to equal_netapp_element(api_request)
  end

  it 'creates an NaElement with api name when no value is passed' do
    api_request = NaElement.new("vserver-create")

    expect(@netapp.generate_request(@api_hash[:api_name],@api_hash[:attributes])).to equal_netapp_element(api_request)
  end

end