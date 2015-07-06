def test_properties_file_path(properties_file_name)
  File.expand_path(properties_file_name, File.dirname(__FILE__))
end

java_properties 'Dynamic attributes as properties' do
  properties_file test_properties_file_path('test_dynamic.properties')
  ruby_home '/usr/lib/ruby/test_dynamic'
  java_home '/usr/lib/jvm/test_dynamic'
end

java_properties 'Properties as a method call' do
  properties_file test_properties_file_path('test_method_call.properties')
  property 'ruby.home', '/usr/lib/ruby/test_method_call'
  property 'java.home', '/usr/lib/jvm/test_method_call'
end

java_properties 'Properties as a hash' do
  properties_file test_properties_file_path('test_hash.properties')
  properties({'ruby.home' => '/usr/lib/ruby/test_hash', 'java.home' => '/usr/lib/jvm/test_hash'})
end

java_properties 'Mixed methods' do
  properties_file test_properties_file_path('test_mixed.properties')
  properties({'ruby_home' => '/usr/lib/ruby/test_mixed_hash', 'java.home' => '/usr/lib/jvm/test_mixed_hash'})
  property('ruby_home', '/usr/lib/ruby/test_mixed_method_call')
  ruby_home 'usr/lib/ruby/test_mixed_dynamic'
end

java_properties 'No changes' do
  properties_file test_properties_file_path('test_no_changes.properties')
  java_home 'asdf'
end