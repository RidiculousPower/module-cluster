
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::Cluster::FrameDefiner do

  before :all do
    MockCluster = ::Class.new do
      define_method( :instance ) do
        @module_instance ||= ::Module.new
      end
      define_method( :instance_controller ) do
        @instance_controller ||= ::Module::Cluster.instance_controller( @module_instance )
      end
      define_method( :name ) do
        @name ||= :cluster_name
      end
    end
  end
  
  let( :module_instance ) { mock_cluster.instance }
  let( :controller_for_module ) { mock_cluster.instance_controller }
  
  let( :cluster_name ) { mock_cluster.name }
  let( :frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, cluster_name, cascade_contexts, execution_contexts, modules, include_or_extend, block_action ) }
  let( :modules ) { nil }
  let( :include_or_extend ) { nil }
  let( :block_action ) { nil }
  
  let( :mock_cluster ) { ::MockCluster.new }
  let( :frame_definer ) { ::Module::Cluster::Cluster::FrameDefiner.new( mock_cluster ) }

  let( :module_a ) { ::Module.new }
  let( :module_b ) { ::Module.new }
  let( :module_c ) { ::Module.new }
  let( :module_d ) { ::Module.new }

  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################
  
  context '========  Internal State Administration  ========' do
    
    ######################
    #  add_hook_context  #
    ######################
  
    context '#add_hook_context' do
    
      RSpec::Matchers.define :have_added_hook_context do
        match do |frame_definer|
          which_hook_context = hook_context
          frame_definer.instance_eval do
            add_hook_context( which_hook_context )
            @hook_contexts.has_key?( which_hook_context )
          end
        end
        failure_message_for_should { "failed to add hook context" }
      end
      
      let( :hook_context ) { :before_include }
    
      it 'can add a hook context to apply to hook frames defined next' do
        frame_definer.should have_added_hook_context
      end

    end
  
    ###########################
    #  add_execution_context  #
    ###########################
  
    context '#add_execution_context' do
    
      RSpec::Matchers.define :have_added_execution_context do |execution_context|
        match do |frame_definer|
          frame_definer.instance_eval do
            add_execution_context( execution_context )
            @execution_contexts.has_key?( execution_context )
          end
        end
        failure_message_for_should { "failed to add instance context" }
      end
      
      let( :execution_context ) { :module }
    
      it 'can add an instance context to apply to hook frames defined next' do
        frame_definer.should have_added_execution_context( execution_context )
      end
    
    end

    #########################
    #  add_cascade_context  #
    #########################
  
    context '#add_cascade_context' do
    
      RSpec::Matchers.define :have_added_cascade_context do |cascade_context|
        match do |frame_definer|
          frame_definer.instance_eval do
            add_cascade_context( cascade_context )
            @cascade_contexts.has_key?( cascade_context )
          end
        end
        failure_message_for_should { "failed to add cascade context" }
      end
      
      let( :cascade_context ) { :module }
    
      it 'can add a cascade context to apply to hook frames defined next' do
        frame_definer.should have_added_cascade_context( cascade_context )
      end
    
    end
  
    #####################
    #  new_stack_frame  #
    #####################
  
    context '#new_stack_frame' do
    
      RSpec::Matchers.define :have_created_new_stack_frame do |hook_contexts, include_or_extend, modules, block_action|
        match_error = nil
        match do |frame_definer|
          matches = true
          frame_definer.instance_eval do
            add_hook_context( *hook_contexts )
          end
          new_frame = frame_definer.instance_eval do
            new_stack_frame( include_or_extend, modules, block_action )
          end
          unless matches = new_frame.cluster_owner == module_instance
            match_error = 'cluster owner did not match'
          end
          unless matches = new_frame.cluster_name == cluster_name
            match_error = 'cluster name did not match'
          end
          if cascade_contexts and ! cascade_contexts.empty?
            unless matches = new_frame.cascade_contexts == cascade_contexts
              match_error = 'cascade contexts did not match'
            end
            unless matches = ! new_frame.cascade_contexts.equal?( cascade_contexts )
              match_error = 'cascade contexts were identical'
            end
          end
          if execution_contexts and ! execution_contexts.empty?
            unless matches = new_frame.execution_contexts == execution_contexts
              match_error = 'execution contexts did not match'
            end
            unless matches = ! new_frame.execution_contexts.equal?( execution_contexts )
              match_error = 'execution contexts were identical'
            end
          end
          if modules and ! modules.empty?
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

      # hook context always exists otherwise the frame doesn't occur anywhere
      let( :hook_contexts ) { [ :before_include ] }
    
      context 'when no context' do
        let( :cascade_contexts ) { nil }
        let( :execution_contexts ) { nil }
        it 'creates a frame with nil context' do
          frame_definer.should have_created_new_stack_frame( hook_contexts, include_or_extend, modules, block_action )
        end
      end

      context 'when empty contexts' do
        let( :cascade_contexts ) { [ ] }
        let( :execution_contexts ) { [ ] }
        it 'creates a frame with nil context' do
          frame_definer.should have_created_new_stack_frame( hook_contexts, include_or_extend, modules, block_action )
        end
      end
    
      context 'when context contents' do
        let( :cascade_contexts ) { [ :class ] }
        let( :execution_contexts ) { [ :module ] }
        it 'creates a frame with context arrays duplicated' do
          frame_definer.should have_created_new_stack_frame( hook_contexts, include_or_extend, modules, block_action )
        end
      
      end
    
    end
  
  end
  
  ######################################################################################################################
  #   public ###########################################################################################################
  ######################################################################################################################
  
  context '========  Context Definition  ========' do
  
    #############
    #  cluster  #
    #############

    context '#cluster' do
      it 'is for a cluster' do
        frame_definer.cluster.should == mock_cluster
      end
    end
  
    #############
    #  context  #
    #############

    context '#context' do
      
      RSpec::Matchers.define :have_declared_execution_context do |execution_contexts|
        match do |frame_definer|
          frame_definer.context( *execution_contexts )
          frame_definer.instance_eval do
            @execution_contexts.keys.should == execution_contexts
          end
        end
        failure_message_for_should { "failed to add hook context" }
      end
      
      let( :execution_contexts ) { [ :class ] }
      
      it 'declares an instance context to apply to hook frames defined next' do
        frame_definer.should have_declared_execution_context( execution_contexts )
      end
    
    end
  
    ###########
    #  clear  #
    ###########
  
    context '#clear' do
  
      RSpec::Matchers.define :have_cleared_contexts do
        fail_string = nil
        match do |frame_definer|
          frame_definer.instance_eval do
            matched = true
            unless matched = clear == @cluster
              fail_string = 'did not receive cluster in return'
            end
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
  
      context 'when no context' do
        it 'should remain as is' do
          frame_definer.should have_cleared_contexts
        end
      end

      context 'when empty contexts' do
        it 'should remain as is' do
          frame_definer.should have_cleared_contexts
        end
      end
    
      context 'when context contents' do
        it 'should clear context state' do
          frame_definer.should have_cleared_contexts
        end
      end
    
    end

    context '=========  Hook Contexts  ========' do

      RSpec::Matchers.define :have_declared_hook_context do |action, hook_contexts|
        fail_string = nil
        match do |frame_definer|
          frame_definer.__send__( action )
          frame_definer.instance_eval do
            matched = true
            hook_contexts.each do |this_hook_context|
              unless matched = @hook_contexts.include?( this_hook_context )
                if @hook_contexts.empty?
                  fail_string = 'hook contexts were empty and therefore '
                else
                  fail_string = 'hook contexts (:' << @hook_contexts.keys.join( ', :' )
                end
                fail_string << 'did not include requested context (:' << this_hook_context.to_s + ')'
                break
              end
            end
            matched
          end
        end
        failure_message_for_should { fail_string }
      end
    
      ####################
      #  before_include  #
      ####################
  
      context '#before_include' do
        let( :action ) { :before_include }
        let( :hook_contexts ) { [ :before_include ] }
        it 'can add :before_include to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end

      end

      ###################
      #  after_include  #
      ###################
  
      context '#after_include' do
        let( :action ) { :after_include }
        let( :hook_contexts ) { [ :after_include ] }
        it 'can add :after_include to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end
  
      ###################
      #  before_extend  #
      ###################
  
      context '#before_extend' do
        let( :action ) { :before_extend }
        let( :hook_contexts ) { [ :before_extend ] }
        it 'can add :before_extend to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end
  
      ##################
      #  after_extend  #
      ##################
  
      context '#after_extend' do
        let( :action ) { :after_extend }
        let( :hook_contexts ) { [ :after_extend ] }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end
  
      ##############
      #  subclass  #
      ##############
  
      context '#subclass' do
        let( :action ) { :subclass }
        let( :hook_contexts ) { [ :subclass ] }
        it 'can add :subclass to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end
    
      ##############################
      #  before_include_or_extend  #
      ##############################

      context '#before_include_or_extend' do
        let( :action ) { :before_include_or_extend }
        let( :hook_contexts ) { [ :before_include, :before_extend ] }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end

      #############################
      #  after_include_or_extend  #
      #############################

      context '#after_include_or_extend' do
        let( :action ) { :after_include_or_extend }
        let( :hook_contexts ) { [ :after_include, :after_extend ] }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          frame_definer.should have_declared_hook_context( action, hook_contexts )
        end
      end
    
    end
    
    context '=========  Cascade Contexts  ========' do

      RSpec::Matchers.define :have_declared_cascade_context do |cascade_context|
        fail_string = nil
        match do |frame_definer|
          frame_definer.instance_eval do
            matched = true
            unless matched = @cascade_contexts.include?( cascade_context )
              if @cascade_contexts.empty?
                fail_string = 'cascade contexts were empty and therefore '
              else
                fail_string = 'cascade contexts (:' << @cascade_contexts.keys.join( ', :' ) << ') '
              end
              fail_string << 'did not include requested context (:' << cascade_context.to_s + ')'
            end
            matched
          end
        end
        failure_message_for_should { fail_string }
      end

      #############
      #  cascade  #
      #############
  
      context '#cascade' do
        let( :cascade_to ) { frame_definer.cascade ; :any } 
        it 'declares cascading for all instances to apply to hook frames defined next' do
          frame_definer.should have_declared_cascade_context( cascade_to )
        end
      end

      ################
      #  cascade_to  #
      ################
  
      context '#cascade_to' do
        let( :cascade_to ) { frame_definer.cascade_to( :module ) ; :module } 
        it 'declares a cascade context to apply to hook frames defined next' do
          frame_definer.should have_declared_cascade_context( cascade_to )
        end
      end

    end
    
    context '=========  Stack Insert Order  ========' do
      
      ############
      #  before  #
      ############

      context '#before' do
        
        RSpec::Matchers.define :have_declared_before_module_context do |include_or_extend, before_modules|
          fail_string = nil
          match do |frame_definer|
            frame_definer.before( include_or_extend, *before_modules )
            frame_definer.instance_eval do
              matched = true
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
              matched
            end
          end
          failure_message_for_should { fail_string }
        end
        
        let( :before_modules ) { [ module_a, module_b ] }

        context 'include_or_extend is nil' do
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include' do
          let( :include_or_extend ) { :include }
          it 'matches any frame where specified modules are included' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend' do
          let( :include_or_extend ) { :extend }
          it 'matches any frame where specified modules are extended' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include_or_extend' do
          let( :include_or_extend ) { :include_or_extend }
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend_or_include' do
          let( :include_or_extend ) { :extend_or_include }
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include_and_extend' do
          let( :include_or_extend ) { :include_and_extend }
          it 'matches any frame where specified modules are included and extended' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend_and_include' do
          let( :include_or_extend ) { :extend_and_include }
          it 'matches any frame where specified modules are extended and included' do
            frame_definer.should have_declared_before_module_context( include_or_extend, before_modules )
          end
        end
              
      end

      ###########
      #  after  #
      ###########

      context '#after' do

        RSpec::Matchers.define :have_declared_after_module_context do |include_or_extend, after_modules|
          fail_string = nil
          match do |frame_definer|
            frame_definer.after( include_or_extend, *after_modules )
            frame_definer.instance_eval do
              matched = true
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
              matched
            end
          end
          failure_message_for_should { fail_string }
        end
        
        let( :after_modules ) { [ module_a, module_b ] }

        context 'include_or_extend is nil' do
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include' do
          let( :include_or_extend ) { :include }
          it 'matches any frame where specified modules are included' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend' do
          let( :include_or_extend ) { :extend }
          it 'matches any frame where specified modules are extended' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include_or_extend' do
          let( :include_or_extend ) { :include_or_extend }
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend_or_include' do
          let( :include_or_extend ) { :extend_or_include }
          it 'matches any frame with specified modules' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include_and_extend' do
          let( :include_or_extend ) { :include_and_extend }
          it 'matches any frame where specified modules are included and extended' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend_and_include' do
          let( :include_or_extend ) { :extend_and_include }
          it 'matches any frame where specified modules are extended and included' do
            frame_definer.should have_declared_after_module_context( include_or_extend, after_modules )
          end
        end

      end
    
    end
    
  end
  
  context '========  Hook Frame Declaration  ========' do

    RSpec::Matchers.define :have_created_frame do |include_or_extend, & block|
      fail_string = nil
      match do |frame_definer|
        matched = nil
        frame_definer.__send__( stack_for_frame )
        if include_or_extend
          frame_definer.__send__( include_or_extend, module_a )
        else
          block_ran = false
          frame_definer.action( & block )
        end
        new_frame = frame_definer.cluster.instance_controller.stack( stack_for_frame ).last
        unless matched = new_frame.include_or_extend == include_or_extend
          fail_string = 'include or extend action (:' << new_frame.include_or_extend.to_s << ') did not match (:' << include_or_extend.to_s << ')'
        end
        unless matched = new_frame.block_action == block
          fail_string = 'block action (:' << new_frame.block_action.to_s << ') did not match (:' << block.to_s << ')'
        end
        matched
      end
      failure_message_for_should { fail_string }
    end

    let( :stack_for_frame ) { :before_include }
  
    #############
    #  include  #
    #############
  
    context '#include' do
      let( :should_include_or_extend ) { :include }
      it 'creates a frame with include_or_extend set to :include' do
        frame_definer.should have_created_frame( should_include_or_extend )
      end
    end
  
    ############
    #  extend  #
    ############

    context '#extend' do
      let( :should_include_or_extend ) { :extend }
      it 'creates a frame with include_or_extend set to :extend' do
        frame_definer.should have_created_frame( should_include_or_extend )
      end
    end

    ########################
    #  include_and_extend  #
    ########################

    context '#include_and_extend' do
      let( :should_include_or_extend ) { :include_and_extend }
      it 'creates a frame with include_or_extend set to :include_and_extend' do
        frame_definer.should have_created_frame( should_include_or_extend )
      end
    end

    ########################
    #  extend_and_include  #
    ########################

    context '#extend_and_include' do
      let( :should_include_or_extend ) { :extend_and_include }
      it 'creates a frame with include_or_extend set to :extend_and_include' do
        frame_definer.should have_created_frame( should_include_or_extend )
      end
    end
  
    ############
    #  action  #
    ############
  
    context '#action' do
      let( :should_include_or_extend ) { nil }
      it 'creates a frame with a block' do
        frame_definer.should have_created_frame( should_include_or_extend ) { nil }
      end
    end

  end
  
end
