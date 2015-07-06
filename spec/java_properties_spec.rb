require 'chefspec'
require 'chefspec/berkshelf'

def test_properties_file_path(properties_file_name)
  File.expand_path("../test/cookbooks/java_properties_hwrp_test/recipes/#{properties_file_name}", File.dirname(__FILE__))
end

describe 'java_properties_hwrp_test::java_properties_test' do

  subject(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['java_properties']).converge(described_recipe)
  end

  context 'using dynamic properties' do
    it { is_expected.to merge_java_properties('Dynamic attributes as properties') }
    it { is_expected.to create_file(test_properties_file_path('test_dynamic.properties'))
                        .with_content(['java_home=/usr/lib/jvm/test_dynamic',
                                       'ruby_home=/usr/lib/ruby/test_dynamic'].join($/)) }
  end

  context 'using the property method call' do
    it { is_expected.to merge_java_properties('Properties as a method call') }
    it { is_expected.to create_file(test_properties_file_path('test_method_call.properties'))
                        .with_content(['java.home=/usr/lib/jvm/test_method_call',
                                       'ruby.home=/usr/lib/ruby/test_method_call'].join($/)) }
  end

  context 'using the properties hash' do
    it { is_expected.to merge_java_properties('Properties as a hash') }
    it { is_expected.to create_file(test_properties_file_path('test_hash.properties'))
                        .with_content(['java.home=/usr/lib/jvm/test_hash',
                                       'ruby.home=/usr/lib/ruby/test_hash'].join($/)) }
  end

  context 'last call wins when mixing' do
    it { is_expected.to merge_java_properties('Mixed methods') }
    it { is_expected.to create_file(test_properties_file_path('test_mixed.properties'))
                        .with_content(['java.home=/usr/lib/jvm/test_mixed_hash',
                                       'ruby_home=usr/lib/ruby/test_mixed_dynamic'].join($/)) }
  end
end
