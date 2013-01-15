
RSpec::Matchers.define :have_created_frame do |hook_contexts, frame_creation_method, modules, block_status|

  unexpected_success_string = nil
  fail_string = nil

  match do |frame_definer|

    unexpected_success_string = frame_creation_method.to_s << ' frame was created for :' << 
                                hook_contexts.join( ', :' ).to_s << ' on ' << frame_definer.to_s << ' but not expected.'

    matched = nil
    
    hook_contexts.each do |this_hook_context|
      
      stack = frame_definer.cluster.instance_controller.stack( this_hook_context )

      unless ! frame_creation_method  or 
               matched = stack.any? { |this_frame| this_frame.modules == modules && 
                                                   this_frame.include_or_extend == frame_creation_method }
        fail_string = frame_creation_method.to_s << ' frame (' << modules.collect( & :to_s ).join( ', ' ) << 
                      ') was not created for :' << this_hook_context.to_s << ' on ' << frame_definer.to_s << '.'
        break
      end

      unless fail_string           or 
             ! block_status.block  or 
             matched = stack.any? { |this_frame| this_frame.block_action == block_status.block }
        fail_string = 'frame with block ( ' << block_status.block.to_s << 
                      ' ) was not created for :' << this_hook_context.to_s << ' on ' << frame_definer.to_s << '.'
        break
      end

    end
    
    matched

  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

RSpec::Matchers.define :have_created_new_stack_frame do |frame_definer, 
                                                         hook_contexts, 
                                                         include_or_extend, 
                                                         modules, 
                                                         block_action|
  match_error = nil
  match do |new_frame|
    matches = true
    unless matches = new_frame.cluster_owner == module_instance
      match_error = 'cluster owner did not match'
    end
    unless matches = new_frame.cluster_name == cluster_name
      match_error = 'cluster name did not match'
    end
    if cascade_contexts
      unless matches = new_frame.cascade_contexts == cascade_contexts
        match_error = 'cascade contexts did not match'
      end
      unless matches = ! new_frame.cascade_contexts.equal?( cascade_contexts )
        match_error = 'cascade contexts were identical'
      end
    end
    if execution_contexts
      unless matches = new_frame.execution_contexts == execution_contexts
        match_error = 'execution contexts did not match'
      end
      unless matches = ! new_frame.execution_contexts.equal?( execution_contexts )
        match_error = 'execution contexts were identical'
      end
    end
    if modules
      unless matches = new_frame.modules == modules
        match_error = 'modules did not match'
      end
    end
    if block_action
      unless matches = new_frame.block_action == block_action
        match_error = 'block action did not match'
      end
    end
    unless matches = new_frame.include_or_extend == include_or_extend
      match_error = 'include or extend did not match'
    end
    # instance controller's stack(s) should have new frame
    hook_contexts.each do |this_hook_context|
      unless matches = frame_definer.cluster.instance_controller.stack( this_hook_context ).include?( new_frame )
        match_error = 'frames were not added to stack defined in hook context (:' << this_hook_context.to_s + ')'
        break
      end
    end
    matches
  end
  failure_message_for_should { match_error }
end

class MockFrameDefiner
  attr_reader :last_method_called, :last_args, :last_block
  def method_missing( method_name, *args, & block )
    @last_method_called = method_name
    @last_args = args
    @last_block = block
  end
end
class ::Module::Cluster::Cluster
  attr_reader :frame_definer
end

RSpec::Matchers.define :have_called_frame_definer do |method, *args, & block|
  fail_string = nil
  match do |cluster|
    matched = nil
    frame_definer = cluster.frame_definer
    unless matched = frame_definer.last_method_called == method
      fail_string = 'last method called was #' << frame_definer.last_method_called.to_s + 
                    ' but expected :' << method.to_s + '.'
    end
    unless fail_string or matched = frame_definer.last_args == args
      fail_string = 'last method args were #' << frame_definer.last_args.to_s + 
                    ' but expected :' << args.to_s + '.'
    end
    unless fail_string or frame_definer.last_block == block
      fail_string = 'last method block was #' << frame_definer.last_block.to_s + 
                    ' but expected :' << block.to_s + '.'
    end
    matched
  end
  failure_message_for_should { fail_string }
end
