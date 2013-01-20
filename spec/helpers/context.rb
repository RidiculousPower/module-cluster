
RSpec::Matchers.define :have_added_hook_context do |*hook_contexts|
  match do |frame_definer|
    matched = nil
    frame_definer.instance_eval do
      hook_contexts.all? { |this_hook_context| @hook_contexts.has_key?( this_hook_context ) }
    end
  end
  failure_message_for_should { "failed to add hook context :" << hook_contexts.collect( & :to_s ).join( ', :' ).to_s }
end

RSpec::Matchers.define :have_added_execution_context do |*execution_contexts|
  match do |frame_definer|
    matched = nil
    frame_definer.instance_eval do
      execution_contexts.all? { |this_execution_context| @execution_contexts.has_key?( this_execution_context ) }
    end
  end
  failure_message_for_should { "failed to add instance context" }
end

RSpec::Matchers.define :have_added_cascade_context do |*cascade_contexts|
  match do |frame_definer|
    matched = nil
    frame_definer.instance_eval do
      cascade_contexts.all? { |this_cascade_context| @cascade_contexts.has_key?( this_cascade_context ) }
    end
  end
  failure_message_for_should { "failed to add cascade context" }
end

RSpec::Matchers.define :have_added_before_module_context do |include_or_extend, before_modules|
  fail_string = nil
  match do |frame_definer|
    matched = true
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
end

RSpec::Matchers.define :have_added_after_module_context do |include_or_extend, after_modules|
  fail_string = nil
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
end

RSpec::Matchers.define :have_cleared_contexts do
  fail_string = nil
  match do |frame_definer|
    frame_definer.instance_eval do
      matched = true
      unless matched = @hook_contexts.empty?
        fail_string = 'failed to clear hook contexts'
      end
      if @execution_contexts
        unless matched = @execution_contexts.empty?
          fail_string = 'failed to clear execution contexts'
        end
      end
      if @cascade_contexts
        unless matched = @cascade_contexts.empty?
          fail_string = 'failed to clear execution contexts'
        end
      end
      matched
    end
  end
  failure_message_for_should { fail_string }
end
