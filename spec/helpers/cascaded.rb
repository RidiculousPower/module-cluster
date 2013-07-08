# -*- encoding : utf-8 -*-

###########################
#  have_inherited_stacks  #
###########################

RSpec::Matchers.define :have_inherited_stacks do |clustered_instance, controller, event_contexts, stack|
  
  unexpected_success_string = nil
  fail_string = nil
  
  match do |hooked_instance|

    matched = nil

    unexpected_success_string = 'stacks for :' << event_contexts.collect( & :to_s ).join( ', :' ) << 
                                ' were inherited by ' << hooked_instance.name.to_s << ' from ' <<
                                clustered_instance.name.to_s << ' but were not expected.'

    instance_controller = controller.instance_controller( hooked_instance )

    event_contexts.each do |this_event_context|
      unless matched = instance_controller.has_stack?( this_event_context )
        fail_string = 'stack for :' << this_event_context.to_s << ' was not inherited by ' << 
                      hooked_instance.name.to_s << ' from ' << clustered_instance.name.to_s << ' .'
        break
      end
      unless fail_string or matched = instance_controller.stack( this_event_context ) == stack
        fail_string = 'inherited stack for :' << this_event_context.to_s << ' in ' <<
                      hooked_instance.name.to_s << ' was not equivalent to stack from ' << 
                      clustered_instance.name.to_s << ' .'
        break
      end
    end

    matched

  end

  failure_message_for_should_not { unexpected_success_string }
  failure_message_for_should { fail_string }

end

###################################
#  be_enabled_for_instance_hooks  #
###################################

RSpec::Matchers.define :be_enabled_for_instance_hooks do

  unexpected_success_string = nil
  fail_string = nil

  match do |instance|
    
    matched = nil
    
    unexpected_success_string = instance.name.to_s << ' was enabled for :before_instance and :after_instance, ' <<
                                'but not expected to be enabled.'

    unless matched = instance.ancestors.include?( ::Module::Cluster::Hooks::InstanceSupport )
      fail_string = instance.name.to_s << ' was not enabled for :before_instance and :after_instance.'
    end

    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

################################
#  have_determined_to_cascade  #
################################

RSpec::Matchers.define :have_determined_to_cascade do |frame, 
                                                       controller, 
                                                       clustered_instance, 
                                                       event_contexts, 
                                                       *expected_results|

  fail_string = nil
  unexpected_success_string = nil

  match do |hooked_instance|
    
    unexpected_success_string = 'instance was determined to cascade for :' << 
                                event_contexts.collect( & :to_s ).join( ', :' ) << ' but cascade was not expected.'
    
    matched = nil
    
    event_contexts.each do |this_event_context|
      cascade_result = controller.frame_should_cascade?( frame, 
                                                         this_event_context, 
                                                         hooked_instance, 
                                                         clustered_instance )
      unless matched = expected_results.include?( cascade_result )
        fail_string = 'frame will not cascade for :' << this_event_context.to_s << '. ' <<
                      'Expected :' << expected_results.collect( & :to_s ).join( ', :' ).to_s << 
                      ' but got :' << cascade_result.to_s << '.'
        break
      end
    end
    
    matched
    
  end
  
  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

############################
#  have_cascaded_includes  #
############################

RSpec::Matchers.define :have_cascaded_includes do |controller, clustered_instance, event_context, *modules|

  fail_string = nil
  unexpected_success_string = nil

  match do |inheriting_instance|

    unexpected_success_string = 'cascade of module includes ' << 
                                modules.collect( & :name ).collect( & :to_s ).join( ', :' ) << 
                                ' (' << modules.collect( & :to_s ).join( ', :' ) << 
                                ') occurred but was not expected for ' << inheriting_instance.name.to_s << 
                                ' from ' << clustered_instance.name.to_s << '.'

    include Cascaded
    
    matched, fail_string = cascaded_includes?( controller, 
                                               event_context, 
                                               inheriting_instance, 
                                               clustered_instance, 
                                               *modules )
    
    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

###########################
#  have_cascaded_extends  #
###########################

RSpec::Matchers.define :have_cascaded_extends do |controller, clustered_instance, event_context, *modules|

  fail_string = nil
  unexpected_success_string = nil

  match do |inheriting_instance|

    unexpected_success_string = 'cascade of module extends ' << 
                                modules.collect( & :name ).collect( & :to_s ).join( ', :' ) << 
                                ' (' << modules.collect( & :to_s ).join( ', :' ) << 
                                ') occurred but was not expected for ' << inheriting_instance.name.to_s << 
                                ' from ' << clustered_instance.name.to_s << '.'

    include Cascaded
    
    matched, fail_string = cascaded_extends?( controller, 
                                              event_context, 
                                              inheriting_instance, 
                                              clustered_instance, 
                                              *modules )
    
    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#########################
#  have_cascaded_block  #
#########################

RSpec::Matchers.define :have_cascaded_block do |controller, clustered_instance, event_context, block_state|

  fail_string = nil
  unexpected_success_string = nil

  include Cascaded

  match do |inheriting_instance|
    
    unexpected_success_string = 'block cascade occurred but was not expected to ' << inheriting_instance.to_s << 
                                ' from ' << clustered_instance.to_s << '.'

    matched, fail_string = cascaded_block?( controller, event_context, inheriting_instance, clustered_instance, block_state )
    
    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end
