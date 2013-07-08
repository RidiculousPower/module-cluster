# -*- encoding : utf-8 -*-

########################
#  have_class_support  #
########################

RSpec::Matchers.define :have_class_support do

  unexpected_success_string = "instance was extended with #{::Module::Cluster::Hooks::ClassSupport} but not expected to be"
  fail_string = "expected instance to be extended with #{::Module::Cluster::Hooks::ClassSupport}"

  match { |enabled_instance| enabled_instance.is_a?( ::Module::Cluster::Hooks::ClassSupport ) }

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#########################
#  have_module_support  #
#########################

RSpec::Matchers.define :have_module_support do

  unexpected_success_string = "instance was extended with #{::Module::Cluster::Hooks::ModuleSupport} but not expected to be"
  fail_string = "expected instance to be extended with #{::Module::Cluster::Hooks::ModuleSupport}"

  match { |enabled_instance| enabled_instance.is_a?( ::Module::Cluster::Hooks::ModuleSupport ) }

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

################
#  be_a_stack  #
################

RSpec::Matchers.define :be_a_stack do

  unexpected_success_string = "instance was a #{::Module::Cluster::Hooks::ClassSupport} but not expected to be"
  fail_string = "expected stack to be a #{::Module::Cluster::InstanceController::Stack}"

  match { |stack| stack.is_a?( ::Module::Cluster::InstanceController::Stack ) }

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end
