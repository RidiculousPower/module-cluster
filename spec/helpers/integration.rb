# -*- encoding : utf-8 -*-

require_relative '../support/included_extended.rb'
require_relative '../support/cascaded.rb'

####################################
#  have_executed_but_not_cascaded  #
####################################

RSpec::Matchers.define :have_executed_but_not_cascaded do |clustered_instance, 
                                                           event_context, 
                                                           include_modules, 
                                                           extend_modules, 
                                                           block_state|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended
  include Cascaded
  
  match do |inheriting_instance|
    matched = nil
    unexpected_success_string = 'Not designed for :should_not. Use one of the other integration test methods: ' <<
                                ':have_executed_but_not_cascaded, :have_executed_and_cascaded, ' <<
                                ':have_executed_and_cascaded_block_only, :not_have_executed_or_cascaded, :have_cascaded_but_not_executed.'
    matched, fail_string = included_modules?( inheriting_instance, *include_modules )
    matched, fail_string = extended_modules?( inheriting_instance, *extend_modules ) unless fail_string
    unless fail_string or ! inheriting_instance.is_a?( ::Module )
      matched, fail_string = cascaded_includes?( ::Module::Cluster, 
                                                 event_context, 
                                                 inheriting_instance, 
                                                 clustered_instance, 
                                                 *include_modules )
      if matched
        fail_string = 'cascade occured for include of ' << 
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') in ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    unless fail_string
      matched, fail_string = cascaded_extends?( ::Module::Cluster, 
                                                event_context, 
                                                inheriting_instance, 
                                                clustered_instance, 
                                                *extend_modules ) unless fail_string
      if matched
        fail_string = 'cascade occured for extend of ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') with ' <<
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') from ' << clustered_instance.name.to_s << 
                      ' (' << clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
        matched
      end
    end
    unless fail_string
      matched, fail_string = cascaded_block?( ::Module::Cluster, 
                                              event_context, 
                                              inheriting_instance, 
                                              clustered_instance, 
                                              block_state ) unless fail_string
      if matched
        fail_string = 'cascade of block (' << block_state.block.to_s << ') occured for ' << 
                      inheriting_instance.name.to_s << ' (' << inheriting_instance.to_s << ') from ' << 
                      clustered_instance.name.to_s << ' (' << clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

################################
#  have_executed_and_cascaded  #
################################

RSpec::Matchers.define :have_executed_and_cascaded do |clustered_instance, 
                                                       event_context, 
                                                       include_modules, 
                                                       extend_modules, 
                                                       block_state|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended
  include Cascaded
  
  match do |inheriting_instance|
    matched = nil
    unexpected_success_string = 'Not designed for :should_not. Use one of the other integration test methods: ' <<
                                ':have_executed_but_not_cascaded, :have_executed_and_cascaded, ' <<
                                ':have_executed_and_cascaded_block_only, :execute_or_cascade, :have_cascaded_but_not_executed.'
    matched, fail_string = included_modules?( inheriting_instance, *include_modules )
    matched, fail_string = extended_modules?( inheriting_instance, *extend_modules ) unless fail_string
    matched, fail_string = cascaded_includes?( ::Module::Cluster, 
                                               event_context, 
                                               inheriting_instance, 
                                               clustered_instance, 
                                               *include_modules ) unless fail_string or 
                                                                         ! inheriting_instance.is_a?( ::Module )
    matched, fail_string = cascaded_extends?( ::Module::Cluster, 
                                              event_context, 
                                              inheriting_instance, 
                                              clustered_instance, 
                                              *extend_modules ) unless fail_string
    matched, fail_string = cascaded_block?( ::Module::Cluster, 
                                            event_context, 
                                            inheriting_instance, 
                                            clustered_instance, 
                                            block_state ) unless fail_string
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

###########################################
#  have_executed_and_cascaded_block_only  #
###########################################

RSpec::Matchers.define :have_executed_and_cascaded_block_only do |clustered_instance, 
                                                                  event_context, 
                                                                  include_modules, 
                                                                  extend_modules, 
                                                                  block_state|
  
  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended
  include Cascaded
  
  match do |inheriting_instance|
    matched = nil
    unexpected_success_string = 'Not designed for :should_not. Use one of the other integration test methods: ' <<
                                ':have_executed_but_not_cascaded, :have_executed_and_cascaded, :have_executed_and_cascaded_block_only, ' <<
                                ':execute_or_cascade, :have_cascaded_but_not_executed.'
    unless fail_string or ! inheriting_instance.is_a?( ::Module )
      matched, fail_string = cascaded_includes?( ::Module::Cluster, 
                                                 event_context, 
                                                 inheriting_instance, 
                                                 clustered_instance, 
                                                 *include_modules )
      if matched
        fail_string = 'cascade occured for include of ' << 
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') in ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    unless fail_string
      matched, fail_string = cascaded_extends?( ::Module::Cluster, 
                                                event_context, 
                                                inheriting_instance, 
                                                clustered_instance, 
                                                *extend_modules ) unless fail_string
      if matched
        fail_string = 'cascade occured for extend of ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') with ' <<
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') from ' << clustered_instance.name.to_s << 
                      ' (' << clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    matched, fail_string = cascaded_block?( ::Module::Cluster, 
                                            event_context, 
                                            inheriting_instance, 
                                            clustered_instance, 
                                            block_state ) unless fail_string
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }
  
end

###################################
#  not_have_executed_or_cascaded  #
###################################

RSpec::Matchers.define :not_have_executed_or_cascaded do |clustered_instance, 
                                                          event_context, 
                                                          include_modules, 
                                                          extend_modules, 
                                                          block_state|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended
  include Cascaded
  
  match do |inheriting_instance|
    matched = nil
    unexpected_success_string = 'Not designed for :should_not. Use one of the other integration test methods: ' <<
                                ':have_executed_but_not_cascaded, :have_executed_and_cascaded, :have_executed_and_cascaded_block_only, ' <<
                                ':execute_or_cascade, :have_cascaded_but_not_executed.'
    matched, fail_string = included_modules?( inheriting_instance, *include_modules )
    if matched
      fail_string = 'include occured of ' << 
                    include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                    include_modules.collect( & :to_s ).join( ', ' ) << ') in ' << inheriting_instance.name.to_s << 
                    ' (' << inheriting_instance.to_s << ') from ' << clustered_instance.name.to_s << ' (' << 
                    clustered_instance.to_s << ') but was not expected.'
      matched = false
    else
      matched = true
      fail_string = nil
    end
    unless fail_string
      matched, fail_string = extended_modules?( inheriting_instance, *extend_modules ) unless fail_string
      if matched
        fail_string = 'extend occured of ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') with ' <<
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    unless fail_string or ! inheriting_instance.is_a?( ::Module )
      matched, fail_string = cascaded_includes?( ::Module::Cluster, 
                                                 event_context, 
                                                 inheriting_instance, 
                                                 clustered_instance, 
                                                 *include_modules )
      if matched
        fail_string = 'cascade occured for include of ' << 
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') in ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    unless fail_string
      matched, fail_string = cascaded_extends?( ::Module::Cluster, 
                                                event_context, 
                                                inheriting_instance, 
                                                clustered_instance, 
                                                *extend_modules ) unless fail_string
      if matched
        fail_string = 'cascade occured for extend of ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') with ' <<
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    unless fail_string
      matched, fail_string = cascaded_block?( ::Module::Cluster, 
                                              event_context, 
                                              inheriting_instance, 
                                              clustered_instance, 
                                              block_state ) unless fail_string
      if matched
        fail_string = 'cascade of block (' << block_state.block.to_s << ') occured for ' << 
                      inheriting_instance.name.to_s << ' (' << inheriting_instance.to_s << ') from ' << 
                      clustered_instance.name.to_s << ' (' << clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end    
    end
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

####################################
#  have_cascaded_but_not_executed  #
####################################

RSpec::Matchers.define :have_cascaded_but_not_executed do |clustered_instance, 
                                                           event_context, 
                                                           include_modules, 
                                                           extend_modules, 
                                                           block_state|

  fail_string = nil
  unexpected_success_string = nil

  include IncludedExtended
  include Cascaded
  
  match do |inheriting_instance|
    matched = nil
    unexpected_success_string = 'Not designed for :should_not. Use one of the other integration test methods: ' <<
                                ':have_executed_but_not_cascaded, :have_executed_and_cascaded, :have_executed_and_cascaded_block_only, ' <<
                                ':execute_or_cascade, :have_cascaded_but_not_executed.'
    matched, fail_string = included_modules?( inheriting_instance, *include_modules )
    if matched
      fail_string = 'include occured of ' << 
                    include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                    include_modules.collect( & :to_s ).join( ', ' ) << ') in ' << inheriting_instance.name.to_s << 
                    ' (' << inheriting_instance.to_s << ') from ' << clustered_instance.name.to_s << ' (' << 
                    clustered_instance.to_s << ') but was not expected.'
      matched = false
    else
      matched = true
      fail_string = nil
    end
    unless fail_string
      matched, fail_string = extended_modules?( inheriting_instance, *extend_modules ) unless fail_string
      if matched
        fail_string = 'extend occured of ' << inheriting_instance.name.to_s << 
                      ' (' << inheriting_instance.to_s << ') with ' <<
                      include_modules.collect( & :name ).collect( & :to_s ).join( ', ' ) << ' (' << 
                      include_modules.collect( & :to_s ).join( ', ' ) << ') from ' << clustered_instance.name.to_s << ' (' << 
                      clustered_instance.to_s << ') but was not expected.'
        matched = false
      else
        matched = true
        fail_string = nil
      end
    end
    matched, fail_string = cascaded_includes?( ::Module::Cluster, 
                                               event_context, 
                                               inheriting_instance, 
                                               clustered_instance, 
                                               *include_modules ) unless fail_string
    matched, fail_string = cascaded_extends?( ::Module::Cluster, 
                                              event_context, 
                                              inheriting_instance, 
                                              clustered_instance, 
                                              *extend_modules ) unless fail_string
    matched, fail_string = cascaded_block?( ::Module::Cluster, 
                                            event_context, 
                                            inheriting_instance, 
                                            clustered_instance, 
                                            block_state ) unless fail_string
    matched
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

