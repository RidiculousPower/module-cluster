# -*- encoding : utf-8 -*-

require_relative '../support/included_extended.rb'
require_relative '../support/cascaded.rb'

########################################
#  have_initialized_instance_tracking  #
########################################

RSpec::Matchers.define :have_initialized_instance_tracking do
  
  fail_string = "extending with controller failed to initialize instances"
  unexpected_success_string = "extending with controller initialize instances but was not expected"
  
  match { |controller| controller.instance_variable_defined?( :@instances ) }
  
  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#################################
#  have_determined_to_evaluate  #
#################################

RSpec::Matchers.define :have_determined_to_evaluate do |frame, event_context, clustered_instance|

  fail_string = "frame will not execute"
  unexpected_success_string = "frame will execute but was not expected to do so"

  match do |hooked_instance|
    mock_controller.frame_should_evaluate?( frame, event_context, hooked_instance, clustered_instance )
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#################################
#  have_executed_frame_cascade  #
#################################

RSpec::Matchers.define :have_executed_frame_cascade do |controller, 
                                                        frame, 
                                                        event_contexts, 
                                                        clustered_instance, 
                                                        block_only|

  fail_string = nil
  unexpected_success_string = nil

  match do |hooked_instance|
    matched = nil
    unexpected_success_string = 'frame found on stack for :' << event_contexts.join( ', :' ) << ' but was not expected.'
    event_contexts.each do |this_event_context|
      inherited_frame = mock_controller.instance_controller( hooked_instance ).stack( this_event_context ).last
      unless matched = ! inherited_frame.nil?
        fail_string = 'no frame found on :' << this_event_context.to_s << ' stack.'
        break
      end
      if frame.execution_contexts
        unless matched = inherited_frame.execution_hooks.nil?
          fail_string = 'execution hooks on cascaded frame were non-nil (' << 
                        inherited_frame.execution_hooks.collect( & :to_s ).join( ', :' ) << ').'
          break
        end
      end
      if block_only
        unless matched = inherited_frame.block_action == frame.block_action
          fail_string = 'expected only block to inherit block was not inherited (got ' << 
                        inherited_frame.block_action.to_s << ').'
          break
        end
        unless matched = inherited_frame.modules.nil?
          fail_string = 'expected only block to inherit but :modules was non-nil (' << 
                        inherited_frame.modules.collect( & :to_s ).join( ', ' ) << ').'
          break
        end
        unless matched = inherited_frame.include_or_extend.nil?
          fail_string = 'expected only block to inherit but :include_or_extend was non-nil (:' << 
                        inherited_frame.include_or_extend.to_s << ').'
          break
        end
      end
    end
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

###########################
#  have_executed_include  #
###########################

RSpec::Matchers.define :have_executed_include do |clustered_instance, *modules|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended

  match do |inheriting_instance|
    unexpected_success_string = 'include of modules :' << modules.collect( & :name ).collect( & :to_s ).join( ', :' ) <<
                                ' (' << modules.collect( & :to_s ).join( ', :' ) << 
                                ') occurred but was not expected for ' << inheriting_instance.name.to_s << 
                                ' from ' << clustered_instance.name.to_s << '.'
    matched = nil
    modules.each do |this_module|
      matched, fail_string = included_modules?( inheriting_instance, *modules )
      break unless matched
    end
    matched
  end
  
  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

##########################
#  have_executed_extend  #
##########################

RSpec::Matchers.define :have_executed_extend do |clustered_instance, *modules|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended

  match do |inheriting_instance|
    unexpected_success_string = 'extend of modules :' << modules.collect( & :name ).collect( & :to_s ).join( ', :' ) <<
                                ' (' << modules.collect( & :to_s ).join( ', :' ) << 
                                ') occurred but was not expected for ' << inheriting_instance.name.to_s << 
                                ' from ' << clustered_instance.name.to_s << '.'
    matched = nil
    modules.each do |this_module|
      matched, fail_string = extended_modules?( inheriting_instance, *modules ) unless fail_string
      break unless matched
    end
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#########################
#  have_executed_block  #
#########################

RSpec::Matchers.define :have_executed_block do |clustered_instance, block_state|

  fail_string = nil
  unexpected_success_string = nil
  
  match do |inheriting_instance|
    unexpected_success_string = 'block executed but was not expected for ' << inheriting_instance.to_s << 
                                ' from ' << clustered_instance.to_s << '.'
    matched = true
    unless matched = block_state.block_ran?
      fail_string = 'block did not run'
    end
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end
