
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
                      ' but got ' << cascade_result.to_s << '.'
        break
      end
    end
    matched
  end
  
  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

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

RSpec::Matchers.define :have_cascaded_modules do |controller, 
                                                  clustered_instance, 
                                                  event_context, 
                                                  include_modules, 
                                                  extend_modules|

  fail_string = nil
  unexpected_success_string = nil

  match do |inheriting_instance|

    unexpected_success_string = 'module cascade occurred but was not expected to ' << inheriting_instance.to_s << 
                                ' from ' << clustered_instance.to_s << '.'

    include Cascaded
    
    matched, fail_string = cascaded_includes?( controller, 
                                               event_context, 
                                               inheriting_instance, 
                                               clustered_instance, 
                                               *include_modules )
    unless fail_string
      matched, fail_string = cascaded_extends?( controller, 
                                                event_context, 
                                                inheriting_instance, 
                                                clustered_instance, 
                                                *extend_modules )
    end
    
    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

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
