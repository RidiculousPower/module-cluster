
RSpec::Matchers.define :have_class_support do
  match do |actual|
    actual.is_a?( ::Module::Cluster::ClassSupport ) 
  end
  failure_message_for_should { "expected instance to be extended with #{::Module::Cluster::ClassSupport}" }
end

RSpec::Matchers.define :have_module_support do
  match { |actual| actual.is_a?( ::Module::Cluster::ModuleSupport ) }
  failure_message_for_should { "expected instance to be extended with #{::Module::Cluster::ModuleSupport}" }
end
