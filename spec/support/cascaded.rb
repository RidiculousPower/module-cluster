
module Cascaded
  
  def cascaded_block?( controller, event_context, inheriting_instance, clustered_instance, block_state )

    fail_string = nil
    matched = nil
    
    inheriting_stack = controller.instance_controller( inheriting_instance ).stack( event_context )

    unless matched = inheriting_stack.any? { |this_frame| this_frame.block_action == block_state.block }
      fail_string = 'block did not cascade to ' << inheriting_instance.to_s << 
                    ' from ' << clustered_instance.to_s << '.'
    end
    
    return matched, fail_string
    
  end
  
  def cascaded_includes?( controller, event_context, inheriting_instance, clustered_instance, *modules )
    
    fail_string = nil
    matched = nil

    inheriting_stack = controller.instance_controller( inheriting_instance ).stack( event_context )

    unless modules.nil? or modules.empty?
      modules.each do |this_include_module|
        unless matched = inheriting_stack.any? { |this_frame| this_frame.modules                                 &&
                                                              this_frame.modules.include?( this_include_module ) &&
                                                              ( this_frame.include_or_extend == :include            ||
                                                                this_frame.include_or_extend == :include_and_extend ||
                                                                this_frame.include_or_extend == :extend_and_include ) }
          fail_string = 'include for ' << this_include_module.name.to_s << ' was not found on :' << 
                        event_context.to_s << ' stack for inheriting instance ' << inheriting_instance.to_s << 
                        ' from clustered instance ' << clustered_instance.to_s << '.'
        end
      end
    end
    
    return matched, fail_string
    
  end

  def cascaded_extends?( controller, event_context, inheriting_instance, clustered_instance, *modules )

    fail_string = nil
    matched = nil
    
    inheriting_stack = controller.instance_controller( inheriting_instance ).stack( event_context )
    
    unless modules.nil? or modules.empty?
      modules.each do |this_extend_module|
        unless matched = inheriting_stack.any? { |this_frame| this_frame.modules                                &&
                                                              this_frame.modules.include?( this_extend_module ) &&
                                                              ( this_frame.include_or_extend == :extend             ||
                                                                this_frame.include_or_extend == :include_and_extend ||
                                                                this_frame.include_or_extend == :extend_and_include ) }
          fail_string = 'extend for ' << this_extend_module.name.to_s << ' was not found on :' << 
                        event_context.to_s << ' stack for inheriting instance ' << inheriting_instance.to_s << 
                        ' from clustered instance ' << clustered_instance.to_s << '.'
        end
      end
    end

    return matched, fail_string
    
  end
  
end