
#############################
#  have_added_hook_context  #
#############################

RSpec::Matchers.define :have_added_hook_context do |*hook_contexts|

  fail_string = nil
  unexpected_success_string = nil

  match do |frame_definer|

    unexpected_success_string = 'hook contexts :' << hook_contexts.join( ', :' ) << ' were defined but not expected.'

    matched = nil

    frame_definer.instance_eval do
      hook_contexts.all? do |this_hook_context|
        unless matched = @hook_contexts.has_key?( this_hook_context )
          fail_string = "failed to add hook context :" << this_hook_context.to_s
          break
        end
      end
    end
    
    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

##################################
#  have_added_execution_context  #
##################################

RSpec::Matchers.define :have_added_execution_context do |*execution_contexts|

  fail_string = nil
  unexpected_success_string = nil

  match do |frame_definer|

    unexpected_success_string = 'execution contexts :' << execution_contexts.join( ', :' ) << 
                                ' were defined but not expected.'

    matched = nil

    frame_definer.instance_eval do
      execution_contexts.all? do |this_execution_context|
        unless matched = @execution_contexts.has_key?( this_execution_context )
          fail_string = "failed to add hook context :" << this_execution_context.to_s
          break
        end
      end
    end
    
    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

################################
#  have_added_cascade_context  #
################################

RSpec::Matchers.define :have_added_cascade_context do |*cascade_contexts|

  fail_string = nil
  unexpected_success_string = nil

  match do |frame_definer|

    unexpected_success_string = 'cascade contexts :' << cascade_contexts.join( ', :' ) << 
                                ' were defined but not expected.'

    matched = nil

    frame_definer.instance_eval do
      cascade_contexts.all? do |this_cascade_context|
        unless matched = @cascade_contexts.has_key?( this_cascade_context )
          fail_string = "failed to add hook context :" << this_cascade_context.to_s
          break
        end
      end
    end
    
    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

######################################
#  have_added_before_module_context  #
######################################

RSpec::Matchers.define :have_added_before_module_context do |include_or_extend, before_modules|

  fail_string = nil
  unexpected_success_string = nil

  match do |frame_definer|

    matched = true

    unexpected_success_string = 'before module contexts ' << before_modules.collect( & :name ).join( ', ' ) << 
                                ' (:' << include_or_extend.to_s << ') were defined but not expected.'

    frame_definer.instance_eval do
      before_modules.each do |this_module|
        unless matched = @before_modules[ this_module ] == include_or_extend
          if @before_modules.empty?
            fail_string = 'before modules were empty and therefore '
          else
            fail_string = 'before modules '
          end
          fail_string << 'did not include requested module (:' << this_module.to_s + ')'
          break
        end
      end
    end

    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#####################################
#  have_added_after_module_context  #
#####################################

RSpec::Matchers.define :have_added_after_module_context do |include_or_extend, after_modules|

  fail_string = nil
  unexpected_success_string = nil

  unexpected_success_string = 'after module contexts ' << after_modules.collect( & :name ).join( ', ' ) << 
                              ' (:' << include_or_extend.to_s << ') were defined but not expected.'

  match do |frame_definer|

    matched = true

    frame_definer.instance_eval do
      after_modules.each do |this_module|
        unless matched = @after_modules[ this_module ] == include_or_extend
          if @after_modules.empty?
            fail_string = 'before modules were empty and therefore '
          else
            fail_string = 'before modules '
          end
          fail_string << 'did not include requested module (:' << this_module.to_s + ')'
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
#  have_cleared_contexts  #
###########################

RSpec::Matchers.define :have_cleared_contexts do

  fail_string = nil
  unexpected_success_string = 'all contexts were cleared but not expected to be'

  match do |frame_definer|

    matched = true

    frame_definer.instance_eval do

      unless matched = @hook_contexts.empty?
        fail_string = 'failed to clear hook contexts'
      end

      if @execution_contexts
        unless fail_string or matched = @execution_contexts.empty?
          fail_string = 'failed to clear execution contexts'
        end
      end

      if @cascade_contexts
        unless fail_string or matched = @cascade_contexts.empty?
          fail_string = 'failed to clear execution contexts'
        end
      end

      matched

    end

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end
