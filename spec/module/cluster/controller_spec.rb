
require_relative '../../../lib/module/cluster.rb'

require_relative '../../helpers/support.rb'
require_relative '../../helpers/executed.rb'
require_relative '../../helpers/cascaded.rb'

require_relative '../../support/named_class_and_module.rb'
require_relative '../../support/block_state.rb'

describe ::Module::Cluster::Controller do
  
  let( :mock_controller ) { ::Module.new.name( :MockController ).extend( ::Module::Cluster::Controller ) }

  let( :module_instance ) { ::Module.new.name( :ModuleInstance ) }
  let( :controller_for_module ) { mock_controller.instance_controller( module_instance ) }

  let( :class_instance ) { ::Class.new.name( :ClassInstance ) }
  let( :controller_for_class ) { mock_controller.instance_controller( class_instance ) }

  let( :instance_of_class ) { class_instance.new }

  let( :class_inheriting_from_module ) { ::Class.new( ::Module ).name( :ClassInheritingFromModule ) }
  let( :class_inheriting_from_module_controller ) { mock_controller.instance_controller( class_inheriting_from_module ) }

  let( :instance_of_class_inheriting_from_module ) { class_inheriting_from_module.new }
  let( :controller_for_instance_of_class_inheriting_from_module ) { mock_controller.instance_controller( instance_of_class_inheriting_from_module ) }

  let( :subclass ) { ::Class.new( class_instance ).name( :Subclass ) }
  let( :controller_for_subclass ) { mock_controller.instance_controller( subclass ) }

  let( :clustered_instance ) { clustered_module_instance }
  
  let( :clustered_module_instance ) { ::Module.new.name( :ClusteredModuleInstance ) }
  let( :clustered_class_instance ) { ::Class.new.name( :ClusteredClassInstance ) }
  
  # symbols mock frame objects, whose functionality we aren't testing
  let( :nil_stack ) { nil }
  let( :empty_stack ) { [ ] }
  let( :full_stack ) { [ :A, :B, :C ] }

  let( :block_state ) { BlockState.new }
    
  context '========  Initialization  ========' do
    
    ###################
    #  self.extended  #
    ###################
  
    context '::extended' do
                  
      it 'will automatically initialize an instances hash' do
         mock_controller.should have_initialized_instance_tracking
      end

    end
  
    #########################
    #  instance_controller  #
    #########################
  
    context '#instance_controller' do

      RSpec::Matchers.define :have_initialized_reference_to_instance_controller do
        match do |controller|
          controller.is_a?( ::Module::Cluster::InstanceController ).should == true
          mock_controller.instance_controller( controller.instance ).should == controller
        end
        failure_message_for_should { "controller failed to initialize" }
      end
      
      it 'creates and tracks instances controllers for instances' do
        controller_for_module.should have_initialized_reference_to_instance_controller
      end
      
    end
  
  end
  
  context '========  Cascading Support  ========' do
  
    ################################
    #  enable_with_module_cluster  #
    ################################
  
    context '#enable_with_module_cluster' do
        
      before :each do
        mock_controller.enable_with_module_cluster( hooked_instance, clustered_instance )
      end
    
      context 'when instance is a module' do
        let( :hooked_instance ) { module_instance }    
        it 'enables as module cluster module' do
          module_instance.should have_module_support
          module_instance.should_not have_class_support
        end
      end
    
      context 'when instance is a class' do
        let( :hooked_instance ) { class_instance }    
        it 'can enable a class with module cluster' do
          class_instance.should have_class_support
          class_instance.should_not have_module_support
        end
      end
    
      context 'when instance is a class subclassing Module' do
        let( :hooked_instance ) { class_inheriting_from_module }
        let( :instance_of_instance ) { instance.new }
        it 'can enable a class that subclasses Module with module cluster' do
          class_inheriting_from_module.should have_class_support
          class_inheriting_from_module.should_not have_module_support
          instance_of_class_inheriting_from_module.should have_module_support
          instance_of_class_inheriting_from_module.should_not have_class_support
        end
      end

    end
  
  end
  
  context '========  Cascading Stacks  ========' do

    let( :inherited_args ) { [ clustered_instance, mock_controller, event_contexts, stack ] }
    
    before :each do
      # set up stacks to be tested
      event_contexts.each do |this_event_context|
        mock_controller.instance_controller( clustered_instance ).stack( this_event_context ).push( *stack ) if stack
      end
      # call appropriate cascade method
      mock_controller.__send__( cascade_method, hooked_instance, clustered_instance )
    end
    
    ###########################
    #  cascade_module_stacks  #
    ###########################
    
    context '#cascade_module_stacks' do
      
      let( :event_contexts ) { [ :before_include, :after_include, :before_extend, :after_extend ] }
      
      let( :clustered_instance ) { module_instance }
      let( :hooked_instance ) { instance_of_class_inheriting_from_module }
      
      let( :cascade_method ) { :cascade_module_stacks }
    
      context 'when include/extend stacks have members' do
        let( :stack ) { full_stack }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          hooked_instance.should have_inherited_stacks( *inherited_args )
        end
      end

      context 'when include/extend stacks are empty' do
        let( :stack ) { empty_stack }    
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          hooked_instance.should have_inherited_stacks( *inherited_args )
        end
      end
    
      context 'when include/extend stacks do not exist' do
        let( :stack ) { nil_stack }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          hooked_instance.should_not have_inherited_stacks( *inherited_args )
        end
      end
    
    end
    
    ############################
    #  cascade_subclass_stack  #
    ############################
  
    context '#cascade_subclass_stack' do
      
      let( :event_contexts ) { [ :subclass ] }

      let( :clustered_instance ) { class_instance }
      let( :hooked_instance ) { instance_of_class }

      let( :cascade_method ) { :cascade_subclass_stack }

      context 'when subclass stack has members' do
        let( :stack ) { full_stack }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          hooked_instance.should have_inherited_stacks( *inherited_args )
        end
      end

      context 'when subclass stack is empty' do
        let( :stack ) { empty_stack }    
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          hooked_instance.should have_inherited_stacks( *inherited_args )
        end
      end

      context 'when subclass stack does not exist' do
        let( :stack ) { nil_stack }
        it 'can cause an instance to inherit the subclass stack from another instance when it does not exist' do
          hooked_instance.should_not have_inherited_stacks( *inherited_args )
        end
      end
      
    end
    
    #############################
    #  cascade_instance_stacks  #
    #############################
    
    context '#cascade_instance_stacks' do
      
      let( :event_contexts ) { [ :before_initialize, :after_initialize, :before_instance, :after_instance ] }

      let( :hooked_instance ) { instance_of_class }

      let( :cascade_method ) { :cascade_instance_stacks }

      let( :stack ) { full_stack }

      context 'clustered instance is a module' do
        let( :clustered_instance ) { ::Module.new.name( :ClusteredModuleInstance ) }
        context 'hooked instance is a module' do
          let( :hooked_instance ) { module_instance }
          it 'will inherit instance and initialize clusters but not enable for either' do
            module_instance.should have_inherited_stacks( *inherited_args )
            module_instance.should_not be_enabled_for_instance_hooks
            module_instance.should_not be_enabled_for_initialize_hooks
          end
        end
        context 'hooked instance is a class' do
          let( :hooked_instance ) { class_instance }
          let( :cascade_to_subclass ) do
            mock_controller.cascade_instance_stacks( subclass, class_instance )
            subclass
          end
          it 'will inherit instance and initialize clusters and enable for each' do
            class_instance.should have_inherited_stacks( *inherited_args )
            class_instance.should be_enabled_for_instance_hooks
            class_instance.should be_enabled_for_initialize_hooks
          end
          it 'a subclass will inherit instance and initialize clusters and enable for each' do
            cascade_to_subclass.should have_inherited_stacks( *inherited_args )
            cascade_to_subclass.should be_enabled_for_instance_hooks
            cascade_to_subclass.should be_enabled_for_initialize_hooks
          end
        end
      end

      context 'clustered instance is a class' do
        let( :clustered_instance ) { ::Class.new.name( :ClusteredClassInstance ) }
        context 'hooked instance is a subclass' do
          let( :hooked_instance ) { subclass }
          let( :subclass ) { ::Class.new( clustered_instance ).name( :SubclassInstance ) }
          it 'will inherit instance and initialize clusters and enable for each' do
            subclass.should have_inherited_stacks( *inherited_args )
            subclass.should be_enabled_for_instance_hooks
            subclass.should be_enabled_for_initialize_hooks
          end
        end
      end

      context 'clustered instance is a class inheriting from module' do
        let( :clustered_instance ) { ::Class.new( ::Module ).name( :ClusteredClassInstance ) }
        let( :hooked_instance ) { subclass }
        let( :subclass ) { ::Class.new( clustered_instance ).name( :SubclassInstance ) }
        it 'a subclass will inherit instance and initialize clusters and enable for each' do
          subclass.should have_inherited_stacks( *inherited_args )
          subclass.should be_enabled_for_instance_hooks
          subclass.should be_enabled_for_initialize_hooks
        end
      end

    end
    
  end
  
  context '========  Evaluating Frames  ========' do
    
    let( :cluster_name ) { :cluster_name }
    let( :frame ) { ::Module::Cluster::Cluster::Frame.new( clustered_instance, cluster_name, execution_contexts, cascade_contexts, modules, include_or_extend, block_action ) }
    let( :cascade_contexts ) { nil }
    let( :execution_contexts ) { nil }
    let( :modules ) { nil }
    let( :include_or_extend ) { nil }
    let( :block_action ) { nil }
    let( :event_context ) { :before_include }
    let( :module_a ) { ::Module.new.name( :ModuleA ) }
    let( :module_b ) { ::Module.new.name( :ModuleB ) }
    let( :module_c ) { ::Module.new.name( :ModuleC ) }
    let( :module_d ) { ::Module.new.name( :ModuleD ) }

    let( :enabled_module_instance ) { ::Module.new.name( :EnabledModuleInstance ) }
    let( :enabled_class_instance ) { ::Module.new.name( :EnabledClassInstance ) }
    
    ###########################
    #  frame_should_cascade?  #
    ###########################
  
    context '#frame_should_cascade?' do

      let( :execution_contexts ) { nil }
      
      let( :frame_should_cascade_args ) { [ frame, mock_controller, clustered_instance, event_contexts ] }

      let( :event_contexts ) { [ :before_include, :after_include, :before_extend, :after_extend ] }
      let( :cascade_results ) { [ :cascade, :execute_and_cascade, :cascade_block, :execute_and_cascade_block ] }
      
      context 'when initial enabled instance is a module' do
        let( :clustered_instance ) { clustered_module_instance }
        context 'cascade context is nil' do
          let( :cascade_contexts ) { nil }
          it 'will not execute in or cascade to a module' do
            module_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
          it 'will not execute in or cascade to a class' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
        end
        context 'cascade context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will execute in and cascade to a module' do
            module_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade )
          end
          it 'will execute in and cascade block only to a class' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade_block )
          end
        end
        context 'cascade context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will execute in and cascade to a module' do
            module_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade )
          end
          it 'will not execute in or cascade to a class' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
        end
        context 'cascade context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will not execute in but will cascade to a module' do
            module_instance.should have_determined_to_cascade( *frame_should_cascade_args, :cascade )
          end
          it 'will execute in but not cascade to a class' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade_block )
          end
        end
        context 'cascade context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will not execute in but will cascade to a module' do
            module_instance.should have_determined_to_cascade( *frame_should_cascade_args, :cascade )
          end
          it 'will not execute in but will cascade to a class' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :cascade )
          end
        end
        context 'cascade context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will not execute in but will cascade to a module' do
            module_instance.should have_determined_to_cascade( *frame_should_cascade_args, :cascade )
          end
          it 'will not execute in but will cascade to a class' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :cascade )
          end
        end
      end

      context 'when initial enabled instance is a class' do
        let( :clustered_instance ) { clustered_class_instance }
        context 'cascade context is nil' do
          let( :cascade_contexts ) { nil }
          it 'will not execute in or cascade to a subclass' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
        end
        context 'cascade context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will execute in and cascade block only to a subclass' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade_block )
          end
        end
        context 'cascade context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will not execute in or cascade to a subclass' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
        end
        context 'cascade context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will not execute in or cascade to a subclass' do
            class_instance.should_not have_determined_to_cascade( *frame_should_cascade_args, *cascade_results )
          end
        end
        context 'cascade context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will execute in and cascade block only to a subclass' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade_block )
          end
        end
        context 'cascade context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will execute in and cascade to a subclass' do
            class_instance.should have_determined_to_cascade( *frame_should_cascade_args, :execute_and_cascade )
          end
        end
      end

    end
    
    ############################
    #  frame_should_evaluate?  #
    ############################
    
    context '#frame_should_evaluate?' do

      let( :evaluation_args ) { [ frame, event_context ] }
      let( :clustered_instance ) { enabled_module_instance }
      
      context 'when cluster is disabled' do
        
        before :each do
          mock_controller.instance_controller( clustered_instance ).cluster( frame.cluster_name ).disable
        end
        
        it 'a module instance will not evaluate' do
          module_instance.should_not have_determined_to_evaluate( frame, event_context, enabled_module_instance )
        end
        
        it 'a class instance will not evaluate' do
          class_instance.should_not have_determined_to_evaluate( frame, event_context, enabled_module_instance )
        end
      
      end
      
      context 'when event is :subclass' do
        let( :execution_contexts ) { [ :subclass ] }
        let( :event_context ) { :subclass }
        it 'a subclass instance will always evaluate since subclass events are never direct hooks and are therefore cascading and to be determined by cascade behavior' do
          class_instance.should have_determined_to_evaluate( *evaluation_args, enabled_class_instance )
        end
      end

      context 'when execution context is nil' do
        it 'a module instance will evaluate' do
          module_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'a class instance will evaluate' do
          class_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'an instance will evaluate' do
          instance_of_class.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
      end
      
      context 'when execution context is :any' do
        let( :execution_contexts ) { [ :any ] }
        it 'a module instance will evaluate' do
          module_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'a class instance will evaluate' do
          class_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'an instance will evaluate' do
          instance_of_class.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
      end

      context 'when execution context is :class' do
        let( :execution_contexts ) { [ :class ] }
        it 'a module instance will not evaluate' do
          module_instance.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'a class instance will evaluate' do
          class_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'an instance will not evaluate' do
          instance_of_class.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
      end

      context 'when execution context is :module' do
        let( :execution_contexts ) { [ :module ] }
        it 'a module instance will evaluate' do
          module_instance.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'a class instance will not evaluate' do
          class_instance.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'an instance will not evaluate' do
          instance_of_class.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
      end

      context 'when execution context is :instance' do
        let( :execution_contexts ) { [ :instance ] }
        it 'a module instance will not evaluate' do
          module_instance.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'a class instance will not evaluate' do
          class_instance.should_not have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
        it 'an instance will evaluate' do
          instance_of_class.should have_determined_to_evaluate( *evaluation_args, enabled_module_instance )
        end
      end
              
    end
    
    ###########################
    #  execute_frame_cascade  #
    ###########################
  
    context '#execute_frame_cascade' do
      
      let( :frame_cascade_args ) { [ mock_controller, frame, inherited_contexts, clustered_instance, block_only ] }

      let( :execute_frame_cascade ) do
        event_contexts.each do |this_event_context|
          mock_controller.execute_frame_cascade( frame, this_event_context, hooked_instance, clustered_instance, block_only )
        end
        hooked_instance
      end

      let( :block_action ) { _block_state = block_state ; block_state.block = ::Proc.new { _block_state.block_ran! } }
      
      let( :event_contexts ) { [ :before_include, :before_extend, :after_include, :after_extend ] }
      let( :inherited_contexts ) { [ :before_include, :before_extend, :after_include, :after_extend ] }
      
      context 'when full cascade' do
        let( :block_only ) { false }
        context 'when execution context' do
          context 'module to module' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { module_instance }
            it 'will cascade a new frame without :execution_context' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'module to class' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :execution_context' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'class to class' do
            let( :clustered_instance ) { enabled_class_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :execution_context' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
        end
        context 'when no execution context' do
          context 'module to module' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { module_instance }
            it 'will cascade the same frame' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'module to class' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade the same frame' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'class to class' do
            let( :clustered_instance ) { enabled_class_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade the same frame' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
        end
      end
      
      context 'when block-only cascade' do
        let( :block_only ) { true }
        context 'when execution context' do
          context 'module to module' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { module_instance }
            it 'will cascade a new frame without :execution_context or :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'module to class' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :execution_context or :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'class to class' do
            let( :clustered_instance ) { enabled_class_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :execution_context or :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
        end
        context 'when no execution context' do
          context 'module to module' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { module_instance }
            it 'will cascade a new frame without :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'module to class' do
            let( :clustered_instance ) { enabled_module_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
          context 'class to class' do
            let( :clustered_instance ) { enabled_class_instance }
            let( :hooked_instance ) { class_instance }
            let( :inherited_contexts ) { [ :subclass ] }
            it 'will cascade a new frame without :modules or :include_or_extend' do
              execute_frame_cascade.should have_executed_frame_cascade( *frame_cascade_args )
            end
          end
        end
      end
      
      
    end
    
    ########################
    #  execute_frame_hook  # 
    ########################

    context '#execute_frame_hook' do

      let( :include_extend_match_args ) { [ clustered_instance, *modules ] }
      let( :block_match_args ) { [ clustered_instance, block_state ] }
      
      let( :clustered_instance ) { instance_of_class_inheriting_from_module }
      let( :inheriting_instance ) do
        mock_controller.execute_frame_hook( frame, module_instance, clustered_instance )
        module_instance
      end

      let( :modules ) { [ module_a ] }
      let( :block_action ) { _block_state = block_state ; block_state.block = ::Proc.new { _block_state.block_ran! } }

      context 'when :include' do
        let( :include_or_extend ) { :include }
        it 'will include modules' do
          inheriting_instance.should have_executed_include( *include_extend_match_args )
          inheriting_instance.should_not have_executed_extend( *include_extend_match_args )
          inheriting_instance.should have_executed_block( *block_match_args )
        end
      end
      
      context 'when :extend' do
        let( :include_or_extend ) { :extend }
        it 'will extend modules' do
          inheriting_instance.should have_executed_extend( *include_extend_match_args )
          inheriting_instance.should_not have_executed_include( *include_extend_match_args )
          inheriting_instance.should have_executed_block( *block_match_args )
        end
      end
      
      context 'when :include and :extend' do
        let( :include_or_extend ) { :include_and_extend }
        it 'will include and then extend modules' do
          inheriting_instance.should have_executed_include( *include_extend_match_args )
          inheriting_instance.should have_executed_extend( *include_extend_match_args )
          inheriting_instance.should have_executed_block( *block_match_args )
        end
      end
      
      context 'when :extend and :include' do
        let( :include_or_extend ) { :extend_and_include }
        it 'will extend and then include modules' do
          inheriting_instance.should have_executed_extend( *include_extend_match_args )
          inheriting_instance.should have_executed_include( *include_extend_match_args )
          inheriting_instance.should have_executed_block( *block_match_args )
        end
      end

      it 'will execute block action' do
        inheriting_instance.should have_executed_block( *block_match_args )
      end
      
    end

    ############################
    #  evaluate_cluster_stack  #
    ############################

    context '#evaluate_cluster_stack' do
      
      let( :cluster_stack ) { [ frame_to_evaluate ] }

      let( :event_cascade_context ) { event_context }
      
      let( :execution_args ) { [ clustered_instance, *modules ] }
      let( :cascade_block_args ) { [ mock_controller, clustered_instance, event_cascade_context, block_state ] }
      let( :cascade_module_args ) { [ mock_controller, clustered_instance, event_cascade_context, *modules ] }
      let( :sub_execution_args ) { [ hooked_instance, *modules ] }
      let( :sub_cascade_module_args ) { [ mock_controller, hooked_instance, event_cascade_context, *modules ] }
      let( :sub_cascade_block_args ) { [ mock_controller, hooked_instance, event_cascade_context, block_state ] }

      let ( :include_or_extend ) { :include }
      let ( :modules ) { [ module_a, module_b ] }
      let( :frame_to_evaluate ) { frame }
      
      let( :block_action ) { _block_state = block_state ; block_state.block = ::Proc.new { _block_state.block_ran! } }
      
      let( :instance_frame ) { ::Module::Cluster::Cluster::Frame.new( clustered_instance, cluster_name, nil, nil, modules, include_or_extend, block_action ) }
      let( :instance_stack ) { [ instance_frame ] }
      
      let( :instance_contexts ) { [ :before_initialize, :after_initialize, :before_instance, :after_instance ] }
      let( :instance_stack_args ) { [ clustered_instance, mock_controller, instance_contexts, instance_stack ] }
      
      before( :each ) do
        mock_controller.instance_controller( clustered_instance ).stack( event_context ).concat( cluster_stack )
        instance_contexts.each do |this_instance_context|
          mock_controller.instance_controller( clustered_instance ).stack( this_instance_context ).concat( instance_stack )
        end
        mock_controller.evaluate_cluster_stack( event_context, hooked_instance, clustered_instance )
      end
      
      context 'a disabled cluster' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { module_instance }
        let( :frame_to_evaluate ) do
          mock_controller.instance_controller( frame.cluster_owner ).cluster( frame.cluster_name ).disable
          frame
        end
        it 'will not evaluate a disabled frame' do
          hooked_instance.should_not have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should_not have_cascaded_block( *cascade_block_args )
        end
      end
      context 'module => module hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { module_instance }
        context 'when module' do
          it 'will execute' do
            hooked_instance.should have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'module => class hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { class_instance }
        it 'will execute' do
          hooked_instance.should have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should_not have_cascaded_block( *cascade_block_args )
          hooked_instance.should have_inherited_stacks( *instance_stack_args )
        end
      end
      context' module => instance hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { instance_of_class }
        let ( :include_or_extend ) { :extend }
        it 'will execute' do
          hooked_instance.should have_executed_extend( *execution_args )
          hooked_instance.should_not have_executed_include( *execution_args )
          hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should_not have_cascaded_block( *cascade_block_args )
          hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
        end
      end
      context 'module => module cascade' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { module_instance }
        let( :cascade_contexts ) { [ :module ] }
        it 'will execute and cascade' do
          hooked_instance.should have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should have_cascaded_block( *cascade_block_args )
          hooked_instance.should have_inherited_stacks( *instance_stack_args )
        end
      end
      context 'module => class cascade' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :hooked_instance ) { class_instance }
        let( :cascade_contexts ) { [ :class ] }
        let( :event_cascade_context ) { :subclass }
        it 'will execute and cascade' do
          hooked_instance.should have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should_not have_cascaded_block( *cascade_block_args )
          hooked_instance.should have_inherited_stacks( *instance_stack_args )
        end
      end
      context 'module => subclass cascade' do
        let( :cascade_contexts ) { [ :subclass ] }
        let( :event_cascade_context ) { :subclass }
        let( :clustered_instance ) { clustered_module_instance }
        context 'when module => class => class' do
          let( :hooked_instance ) { class_instance }
          let( :module_to_class_cascade ) { hooked_instance }
          let( :class_to_subclass_cascade ) do
            module_to_class_cascade
            mock_controller.evaluate_cluster_stack( event_cascade_context, subclass, hooked_instance )
            subclass
          end
          it 'will not execute in first class but will cascade' do
            module_to_class_cascade.should_not have_executed_include( *execution_args )
            module_to_class_cascade.should_not have_executed_extend( *execution_args )
            module_to_class_cascade.should have_cascaded_includes( *cascade_module_args )
            module_to_class_cascade.should_not have_cascaded_extends( *cascade_module_args )
            module_to_class_cascade.should have_cascaded_block( *cascade_block_args )
            module_to_class_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will execute in first subclass but will only cascade block' do
            class_to_subclass_cascade.should have_executed_include( *sub_execution_args )
            class_to_subclass_cascade.should_not have_executed_extend( *sub_execution_args )
            class_to_subclass_cascade.should_not have_cascaded_includes( *sub_cascade_module_args )
            class_to_subclass_cascade.should_not have_cascaded_extends( *sub_cascade_module_args )
            class_to_subclass_cascade.should have_cascaded_block( *sub_cascade_block_args )
            class_to_subclass_cascade.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when module => module => class => class' do
          
          let( :hooked_instance ) { module_instance }
          let( :hooked_class_instance ) { class_instance }
          let( :hooked_subclass_instance ) { subclass }
          
          let( :module_to_module_cascade ) { hooked_instance }
          let( :module_to_class_cascade ) do
            module_to_module_cascade
            mock_controller.evaluate_cluster_stack( event_context, hooked_class_instance, hooked_instance )
            hooked_class_instance
          end
          let( :class_to_subclass_cascade ) do
            module_to_class_cascade
            mock_controller.evaluate_cluster_stack( event_cascade_context, 
                                                    hooked_subclass_instance, 
                                                    hooked_class_instance )
            hooked_subclass_instance
          end
          
          let( :module_to_module_execution_args ) { [ clustered_instance, *modules ] }
          let( :module_to_module_cascade_module_args ) { [ mock_controller, clustered_instance, event_context, *modules ] }
          let( :module_to_module_cascade_block_args ) { [ mock_controller, clustered_instance, event_context, block_state ] }
          
          let( :module_to_class_execution_args ) { [ hooked_instance, *modules ] }
          let( :module_to_class_cascade_module_args ) { [ mock_controller, hooked_instance, event_cascade_context, *modules ] }
          let( :module_to_class_cascade_block_args ) { [ mock_controller, hooked_instance, event_cascade_context, block_state ] }
          
          let( :class_to_subclass_execution_args ) { [ hooked_class_instance, *modules ] }
          let( :class_to_subclass_cascade_module_args ) { [ mock_controller, hooked_class_instance, event_cascade_context, *modules ] }
          let( :class_to_subclass_cascade_block_args ) { [ mock_controller, hooked_class_instance, event_cascade_context, block_state ] }

          it 'will not execute in first module but will cascade' do
            module_to_module_cascade.should_not have_executed_include( *module_to_module_execution_args )
            module_to_module_cascade.should_not have_executed_extend( *module_to_module_execution_args )
            module_to_module_cascade.should have_cascaded_includes( *module_to_module_cascade_module_args )
            module_to_module_cascade.should_not have_cascaded_extends( *module_to_module_cascade_module_args )
            module_to_module_cascade.should have_cascaded_block( *module_to_module_cascade_block_args )
            module_to_module_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will not execute in first class but will cascade' do
            module_to_class_cascade.should_not have_executed_include( *module_to_class_execution_args )
            module_to_class_cascade.should_not have_executed_extend( *module_to_class_execution_args )
            module_to_class_cascade.should have_cascaded_includes( *module_to_class_cascade_module_args )
            module_to_class_cascade.should_not have_cascaded_extends( *module_to_class_cascade_module_args )
            module_to_class_cascade.should have_cascaded_block( *module_to_class_cascade_block_args )
            module_to_class_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will execute in first subclass but will only cascade block' do
            class_to_subclass_cascade.should have_executed_include( *class_to_subclass_execution_args )
            class_to_subclass_cascade.should_not have_executed_extend( *class_to_subclass_execution_args )
            class_to_subclass_cascade.should_not have_cascaded_includes( *class_to_subclass_cascade_module_args )
            class_to_subclass_cascade.should_not have_cascaded_extends( *class_to_subclass_cascade_module_args )
            class_to_subclass_cascade.should have_cascaded_block( *class_to_subclass_cascade_block_args )
            class_to_subclass_cascade.should have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'module => each subclass cascade' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        let( :event_cascade_context ) { :subclass }
        let( :clustered_instance ) { clustered_module_instance }
        context 'when module => class => class' do
          let( :hooked_instance ) { class_instance }
          let( :module_to_class_cascade ) { hooked_instance }
          let( :class_to_subclass_cascade ) do
            module_to_class_cascade
            mock_controller.evaluate_cluster_stack( event_cascade_context, subclass, hooked_instance )
            subclass
          end
          it 'will not execute in first class but will cascade' do
            module_to_class_cascade.should_not have_executed_include( *execution_args )
            module_to_class_cascade.should_not have_executed_extend( *execution_args )
            module_to_class_cascade.should have_cascaded_includes( *cascade_module_args )
            module_to_class_cascade.should_not have_cascaded_extends( *cascade_module_args )
            module_to_class_cascade.should have_cascaded_block( *cascade_block_args )
            module_to_class_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will execute in first subclass but will only cascade block' do
            class_to_subclass_cascade.should have_executed_include( *sub_execution_args )
            class_to_subclass_cascade.should_not have_executed_extend( *sub_execution_args )
            class_to_subclass_cascade.should have_cascaded_includes( *sub_cascade_module_args )
            class_to_subclass_cascade.should_not have_cascaded_extends( *sub_cascade_module_args )
            class_to_subclass_cascade.should have_cascaded_block( *sub_cascade_block_args )
            class_to_subclass_cascade.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when module => module => class => class' do
          let( :hooked_instance ) { module_instance }
          let( :hooked_class_instance ) { class_instance }
          let( :hooked_subclass_instance ) { subclass }
          
          let( :module_to_module_cascade ) { hooked_instance }
          let( :module_to_class_cascade ) do
            module_to_module_cascade
            mock_controller.evaluate_cluster_stack( event_context, hooked_class_instance, hooked_instance )
            hooked_class_instance
          end
          let( :class_to_subclass_cascade ) do
            module_to_class_cascade
            mock_controller.evaluate_cluster_stack( event_cascade_context, 
                                                    hooked_subclass_instance, 
                                                    hooked_class_instance )
            hooked_subclass_instance
          end
          
          let( :module_to_module_execution_args ) { [ clustered_instance, *modules ] }
          let( :module_to_module_cascade_module_args ) { [ mock_controller, clustered_instance, event_context, *modules ] }
          let( :module_to_module_cascade_block_args ) { [ mock_controller, clustered_instance, event_context, block_state ] }
          
          let( :module_to_class_execution_args ) { [ hooked_instance, *modules ] }
          let( :module_to_class_cascade_module_args ) { [ mock_controller, hooked_instance, event_cascade_context, *modules ] }
          let( :module_to_class_cascade_block_args ) { [ mock_controller, hooked_instance, event_cascade_context, block_state ] }
          
          let( :class_to_subclass_execution_args ) { [ hooked_class_instance, *modules ] }
          let( :class_to_subclass_cascade_module_args ) { [ mock_controller, hooked_class_instance, event_cascade_context, *modules ] }
          let( :class_to_subclass_cascade_block_args ) { [ mock_controller, hooked_class_instance, event_cascade_context, block_state ] }

          it 'will not execute in first module but will cascade' do
            module_to_module_cascade.should_not have_executed_include( *module_to_module_execution_args )
            module_to_module_cascade.should_not have_executed_extend( *module_to_module_execution_args )
            module_to_module_cascade.should have_cascaded_includes( *module_to_module_cascade_module_args )
            module_to_module_cascade.should_not have_cascaded_extends( *module_to_module_cascade_module_args )
            module_to_module_cascade.should have_cascaded_block( *module_to_module_cascade_block_args )
            module_to_module_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will not execute in first class but will cascade' do
            module_to_class_cascade.should_not have_executed_include( *module_to_class_execution_args )
            module_to_class_cascade.should_not have_executed_extend( *module_to_class_execution_args )
            module_to_class_cascade.should have_cascaded_includes( *module_to_class_cascade_module_args )
            module_to_class_cascade.should_not have_cascaded_extends( *module_to_class_cascade_module_args )
            module_to_class_cascade.should have_cascaded_block( *module_to_class_cascade_block_args )
            module_to_class_cascade.should have_inherited_stacks( *instance_stack_args )
          end
          it 'will execute in first subclass but will only cascade block' do
            class_to_subclass_cascade.should have_executed_include( *class_to_subclass_execution_args )
            class_to_subclass_cascade.should_not have_executed_extend( *class_to_subclass_execution_args )
            class_to_subclass_cascade.should have_cascaded_includes( *class_to_subclass_cascade_module_args )
            class_to_subclass_cascade.should_not have_cascaded_extends( *class_to_subclass_cascade_module_args )
            class_to_subclass_cascade.should have_cascaded_block( *class_to_subclass_cascade_block_args )
            class_to_subclass_cascade.should have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'class => subclass cascade (block only)' do
        let( :clustered_instance ) { clustered_class_instance }
        let( :hooked_instance ) { subclass }
        let( :cascade_contexts ) { [ :subclass ] }
        let( :event_context ) { :subclass }
        it 'will execute and cascade' do
          hooked_instance.should have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should have_cascaded_block( *cascade_block_args )
          hooked_instance.should have_inherited_stacks( *instance_stack_args )
        end
      end
      context 'class => each subclass cascade' do
        let( :clustered_instance ) { clustered_class_instance }
        let( :hooked_instance ) { subclass }
        let( :cascade_contexts ) { [ :each_subclass ] }
        let( :event_context ) { :subclass }
        it 'will execute and cascade' do
          hooked_instance.should have_executed_include( *execution_args )
          hooked_instance.should_not have_executed_extend( *execution_args )
          hooked_instance.should have_cascaded_includes( *cascade_module_args )
          hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
          hooked_instance.should have_cascaded_block( *cascade_block_args )
          hooked_instance.should have_inherited_stacks( *instance_stack_args )
        end
      end
      context 'conditional :module execution hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :execution_contexts ) { [ :module ] }
        context 'when module' do
          let( :hooked_instance ) { module_instance }
          it 'will not execute or cascade' do
            hooked_instance.should have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when class' do
          let( :hooked_instance ) { class_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when instance' do
          let( :hooked_instance ) { instance_of_class }
          let( :include_or_extend ) { :extend }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'conditional :class execution hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :execution_contexts ) { [ :class ] }
        context 'when module' do
          let( :hooked_instance ) { module_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when class' do
          let( :hooked_instance ) { class_instance }
          it 'will not execute or cascade' do
            hooked_instance.should have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when instance' do
          let( :hooked_instance ) { instance_of_class }
          let( :include_or_extend ) { :extend }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'conditional :instance execution hook' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :execution_contexts ) { [ :instance ] }
        context 'when module' do
          let( :hooked_instance ) { module_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when class' do
          let( :hooked_instance ) { class_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when instance' do
          let( :hooked_instance ) { instance_of_class }
          let( :include_or_extend ) { :extend }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'conditional :module execution hook with cascade context' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :execution_contexts ) { [ :module ] }
        let( :cascade_contexts ) { [ :class ] }
        context 'when module' do
          let( :hooked_instance ) { module_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when class' do
          let( :hooked_instance ) { class_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when instance' do
          let( :hooked_instance ) { instance_of_class }
          let( :include_or_extend ) { :extend }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
          end
        end
      end
      context 'conditional :class execution hook with cascade context' do
        let( :clustered_instance ) { clustered_module_instance }
        let( :execution_contexts ) { [ :class ] }
        let( :cascade_contexts ) { [ :subclass ] }
        context 'when module' do
          let( :hooked_instance ) { module_instance }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when class' do
          let( :hooked_instance ) { class_instance }
          let( :event_cascade_context ) { :subclass }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should have_cascaded_block( *cascade_block_args )
            hooked_instance.should have_inherited_stacks( *instance_stack_args )
          end
        end
        context 'when instance' do
          let( :hooked_instance ) { instance_of_class }
          let( :include_or_extend ) { :extend }
          it 'will not execute or cascade' do
            hooked_instance.should_not have_executed_include( *execution_args )
            hooked_instance.should_not have_executed_extend( *execution_args )
            hooked_instance.should_not have_cascaded_includes( *cascade_module_args )
            hooked_instance.should_not have_cascaded_extends( *cascade_module_args )
            hooked_instance.should_not have_cascaded_block( *cascade_block_args )
            hooked_instance.should_not have_inherited_stacks( *instance_stack_args )
          end
        end
      end
    
    end
  
  end

end
