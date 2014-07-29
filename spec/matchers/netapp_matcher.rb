require 'rspec/expectations'

RSpec::Matchers.define :equal_netapp_element do |expected|
  match do |actual|
    actual.sprintf == expected.sprintf
  end
  failure_message do |actual|
    "expected that #{actual.sprintf} would be equal to #{expected.sprintf}"
  end
end