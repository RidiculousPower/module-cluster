
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::Controller do
  
  let( :mock_controller ) { ::Module.new.extend( ::Module::Cluster::Controller ) }

  let( :module_instance ) { ::Module.new }
  let( :controller_for_module ) { mock_controller.instance_controller( module_instance ) }

  let( :class_instance ) { ::Class.new }
  let( :controller_for_class ) { mock_controller.instance_controller( class_instance ) }

  let( :instance_of_class ) { class_instance.new }

  let( :class_inheriting_from_module ) { ::Class.new( ::Module ) }
  let( :class_inheriting_from_module_controller ) { mock_controller.instance_controller( class_inheriting_from_module ) }

  let( :instance_of_class_inheriting_from_module ) { ::Module.new }
  let( :controller_for_instance_of_class_inheriting_from_module ) { mock_controller.instance_controller( instance_of_class_inheriting_from_module ) }

  let( :subclass ) { ::Class.new( class_instance ) }
  let( :controller_for_subclass ) { mock_controller.instance_controller( subclass ) }
  
  # symbols mock frame objects, whose functionality we aren't testing
  let( :nil_stack ) { nil }
  let( :empty_stack ) { [ ] }
  let( :full_stack ) { [ :A, :B, :C ] }
  
  context '========  Initialization  ========' do
    
    ###################
    #  self.extended  #
    ###################
  
    context '::extended' do
      def initialized_instance_tracking?
        mock_controller.instance_variable_defined?( :@instances )
      end
      it 'will automatically initialize an instances hash' do
         initialized_instance_tracking?.should == true
      end
    end
  
    #########################
    #  instance_controller  #
    #########################
  
    context '#instance_controller' do
      def initialized_reference_to_instance_controller?
        controller_for_module.is_a?( ::Module::Cluster::InstanceController ).should == true
        mock_controller.instance_controller( module_instance ).should == controller_for_module
      end
      it 'creates and tracks instances controllers for instances' do
        initialized_reference_to_instance_controller?.should == true
      end
    end
  
  end
  
  context '========  Cascading Support  ========' do
  
    ################################
    #  enable_with_module_cluster  #
    ################################
  
    context '#enable_with_module_cluster' do
    
      RSpec::Matchers.define :have_class_support do
        match do |actual|
          actual.is_a?( ::Module::Cluster::ClassSupport ) 
        end
        failure_message_for_should { "expected instance to be extended with #{::Module::Cluster::ClassSupport}" }
      end

      RSpec::Matchers.define :have_module_support do
        match { |actual| actual.is_a?( ::Module::Cluster::ModuleSupport ) }
        failure_message_for_should { "expected instance to be extended with #{::Module::Cluster::ModuleSupport}" }
      end
    
      before :each do
        mock_controller.enable_with_module_cluster( instance )
      end
    
      context 'when instance is a module' do
        let( :instance ) { module_instance }    
        it 'enables as module cluster module' do
          instance.should have_module_support
          instance.should_not have_class_support
        end
      end
    
      context 'when instance is a class' do
        let( :instance ) { class_instance }    
        it 'can enable a class with module cluster' do
          instance.should have_class_support
          instance.should_not have_module_support
        end
      end
    
      context 'when instance is a class subclassing Module' do
        let( :instance ) { class_inheriting_from_module }
        let( :instance_of_instance ) { instance.new }
        it 'can enable a class that subclasses Module with module cluster' do
          instance.should have_class_support
          instance.should_not have_module_support
          instance_of_instance.should have_module_support
          instance_of_instance.should_not have_class_support
        end
      end

    end
  
  end
  
  context '========  Cascading Stacks  ========' do

    ###################################
    #  cascade_include_extend_stacks  #
    ###################################
    
    context '#cascade_include_extend_stacks' do
      
      context 'when include/extend stacks exist' do
      
        RSpec::Matchers.define :have_inherited_cascaded_module_class_stacks do
          match do |instance_controller|
            has_stack = stack ? true : false
            instance_controller.has_before_include_stack?.should == has_stack
            instance_controller.has_before_extend_stack?.should == has_stack
            instance_controller.has_after_include_stack?.should == has_stack
            instance_controller.has_after_extend_stack?.should == has_stack
            if has_stack
              instance_controller.before_include_stack.should == stack
              instance_controller.before_extend_stack.should == stack
              instance_controller.after_include_stack.should == stack
              instance_controller.after_extend_stack.should == stack
            end
          end
          failure_message_for_should { "stacks were not inherited" }
        end
        
        let( :controller_for_instance_of_class_inheriting_from_module ) do
          instance_controller = mock_controller.instance_controller( instance_of_class_inheriting_from_module )
          if stack
            controller_for_module.before_include_stack.push( *stack )
            controller_for_module.before_extend_stack.push( *stack )
            controller_for_module.after_include_stack.push( *stack )
            controller_for_module.after_extend_stack.push( *stack )
          end
          mock_controller.cascade_include_extend_stacks( instance_of_class_inheriting_from_module, module_instance )
          instance_controller
        end
      
        context 'when include/extend stacks have members' do
          let( :stack ) { full_stack }
          it 'can cause an instance to inherit include/extend stacks from another instance' do
            controller_for_instance_of_class_inheriting_from_module.should have_inherited_cascaded_module_class_stacks
          end
        end

        context 'when include/extend stacks are empty' do
          let( :stack ) { empty_stack }    
          it 'can cause an instance to inherit include/extend stacks from another instance' do
            controller_for_instance_of_class_inheriting_from_module.should have_inherited_cascaded_module_class_stacks
          end
        end

      end
    
      context 'when include/extend stacks do not exist' do
        let( :stack ) { nil_stack }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          controller_for_instance_of_class_inheriting_from_module.should_not have_inherited_cascaded_module_class_stacks
        end
      end
    
    end
    
    ############################
    #  cascade_subclass_stack  #
    ############################
  
    context '#cascade_subclass_stack' do
      
      context 'when subclass stack exists' do
    
        RSpec::Matchers.define :have_inherited_cascaded_subclass_stacks do
          match do |instance_controller|
            has_stack = stack ? true : false
            instance_controller.has_subclass_stack?.should == true
            if has_stack
              instance_controller.subclass_stack.should == stack
            end
          end
          failure_message_for_should { "subclass stack was not inherited" }
        end
    
        let( :controller_for_instance_of_class_inheriting_from_module ) do
          instance_controller = mock_controller.instance_controller( instance_of_class_inheriting_from_module )
          if stack
            controller_for_module.subclass_stack.push( *stack )
          end
          mock_controller.cascade_subclass_stack( instance_of_class_inheriting_from_module, module_instance )
          instance_controller
        end
    
        context 'when subclass stack has members' do
          let( :stack ) { full_stack }
          it 'can cause an instance to inherit include/extend stacks from another instance' do
            controller_for_instance_of_class_inheriting_from_module.should have_inherited_cascaded_subclass_stacks
          end
        end

        context 'when subclass stack is empty' do
          let( :stack ) { empty_stack }    
          it 'can cause an instance to inherit include/extend stacks from another instance' do
            controller_for_instance_of_class_inheriting_from_module.should have_inherited_cascaded_subclass_stacks
          end
        end

      end

      context 'when subclass stack does not exist' do
        let( :stack ) { nil_stack }
        it 'can cause an instance to inherit the subclass stack from another instance when it does not exist' do
          controller_for_instance_of_class_inheriting_from_module.should_not have_inherited_cascaded_subclass_stacks
        end
      end
      
    end
    
  end
  
  context '========  Evaluating Frames  ========' do
    
    let( :frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cluster_name, cascade_contexts, instance_contexts, modules, include_or_extend, block_action ) }
    let( :cascade_contexts ) { nil }
    let( :instance_contexts ) { nil }
    let( :modules ) { nil }
    let( :include_or_extend ) { nil }
    let( :block_action ) { nil }
    let( :event_context ) { :before_include }
    let( :module_a ) { ::Module.new }
    
    ###########################
    #  frame_should_cascade?  #
    ###########################
  
    context '#frame_should_cascade?' do

      let( :instance_contexts ) { nil }

      RSpec::Matchers.define :have_cascaded do
        match do |instance|
          mock_controller.frame_should_cascade?( frame, instance, event_context )
        end
        failure_message_for_should { "frame will not cascade" }
      end

      context 'when cascade context is nil' do
        let( :cascade_contexts ) { nil }
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end

      context 'when cascade context is empty' do
        let( :cascade_contexts ) { [ ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end
  
      context 'when cascade context is :any' do
        let( :cascade_contexts ) { [ :any ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end

      context 'when cascade context contains :class' do
        let( :cascade_contexts ) { [ :class ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will not cascade for a module' do
            module_instance.should_not have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end

      context 'when cascade context contains :module' do
        let( :cascade_contexts ) { [ :module ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end

      context 'when cascade context contains :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will not cascade for a class' do
            class_instance.should_not have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'will cascade for a module' do
            module_instance.should have_cascaded
          end
          it 'will cascade for a class' do
            class_instance.should have_cascaded
          end
          it 'will not cascade for an instance' do
            instance_of_class.should_not have_cascaded
          end
        end
      end

    end
    
    ###########################
    #  frame_should_execute?  #
    ###########################
    
    context '#frame_should_execute?' do

      RSpec::Matchers.define :have_executed do
        match do |instance|
          mock_controller.frame_should_execute?( frame, instance, event_context )
        end
        failure_message_for_should { "frame will not execute" }
      end
      
      context 'when instance context is nil' do
        let( :instance_contexts ) { nil }
        it 'class instance should execute' do
          class_instance.should have_executed
        end
        it 'subclass instance should execute' do
          subclass.should have_executed
        end
        it 'module instance should execute' do
          module_instance.should have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should have_executed
        end
      end

      context 'when instance context is empty' do
        let( :instance_contexts ) { [ ] }
        it 'class instance should execute' do
          class_instance.should have_executed
        end
        it 'subclass instance should execute' do
          subclass.should have_executed
        end
        it 'module instance should execute' do
          module_instance.should have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should have_executed
        end
      end

      context 'when instance context is :any' do
        let( :instance_contexts ) { [ :any ] }
        it 'class instance should execute' do
          class_instance.should have_executed
        end
        it 'subclass instance should execute' do
          subclass.should have_executed
        end
        it 'module instance should execute' do
          module_instance.should have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should have_executed
        end
      end

      context 'when instance context is :class' do
        let( :instance_contexts ) { [ :class ] }
        it 'class instance should execute' do
          class_instance.should have_executed
        end
        it 'subclass instance should execute' do
          subclass.should have_executed
        end
        it 'module instance should execute' do
          module_instance.should_not have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should_not have_executed
        end
      end

      context 'when instance context is :module' do
        let( :instance_contexts ) { [ :module ] }
        it 'class instance should execute' do
          class_instance.should_not have_executed
        end
        it 'subclass instance should execute' do
          subclass.should_not have_executed
        end
        it 'module instance should execute' do
          module_instance.should have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should_not have_executed
        end
      end

      context 'when instance context is subclass and event is not subclass' do
        let( :instance_contexts ) { [ :subclass ] }
        it 'class instance should execute' do
          class_instance.should_not have_executed
        end
        it 'subclass instance should execute' do
          subclass.should_not have_executed
        end
        it 'module instance should execute' do
          module_instance.should_not have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should_not have_executed
        end
      end

      context 'when instance context is subclass and event is subclass' do
        let( :instance_contexts ) { [ :subclass ] }
        let( :event_context ) { :subclass }
        it 'class instance should execute' do
          class_instance.should have_executed
        end
        it 'subclass instance should execute' do
          subclass.should have_executed
        end
        it 'module instance should execute' do
          module_instance.should_not have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should_not have_executed
        end
      end

      context 'when instance context is instance' do
        let( :instance_contexts ) { [ :instance ] }
        it 'class instance should execute' do
          class_instance.should_not have_executed
        end
        it 'subclass instance should execute' do
          subclass.should_not have_executed
        end
        it 'module instance should execute' do
          module_instance.should_not have_executed
        end
        it 'instance of class should execute' do
          instance_of_class.should have_executed
        end
      end

    end
    
    ###########################
    #  execute_frame_cascade  #
    ###########################
  
    context '#execute_frame_cascade' do
      
      RSpec::Matchers.define :have_executed_cascade do
        match do |instance|
          mock_controller.instance_controller( instance ).before_include_stack.should == [ ]
          mock_controller.execute_frame_cascade( frame, instance, event_context )
          mock_controller.instance_controller( instance ).before_include_stack.should == [ frame ]
        end
        failure_message_for_should { "frame cascade will not execute" }
      end
      
      it 'can cause a frame to cascade to the next inheriting instance' do
        module_instance.should have_executed_cascade
      end
      
    end
    
    ############################
    #  evaluate_frame_cascade  #
    ############################

    context '#evaluate_frame_cascade' do
      
      RSpec::Matchers.define :have_evaluated_and_executed_cascade do |inheriting_instance|
        match do |instance|
          mock_controller.evaluate_frame_cascade( frame, inheriting_instance, instance, event_context ).should == should_cascade
          controller_for_inheriting_instance = mock_controller.instance_controller( inheriting_instance )
          if should_cascade
            controller_for_inheriting_instance.stack( event_context ).should == [ frame ]
          else
            controller_for_inheriting_instance.stack( event_context ).should == [ ]
          end
        end
        failure_message_for_should { "frame cascade will not execute" }
      end
      
      context 'when it should not cascade' do
        let( :should_cascade ) { false }
        it 'will not execute cascade if frame should not cascade and report did not cascade' do
          module_instance.should have_evaluated_and_executed_cascade( instance_of_class_inheriting_from_module )
        end
      end

      context 'when it should cascade' do
        let( :cascade_contexts ) { [ :any ] }
        let( :should_cascade ) { true }
        it 'will execute cascade if frame should cascade and report cascades' do
          module_instance.should have_evaluated_and_executed_cascade( instance_of_class_inheriting_from_module )
        end
      end
      
    end

    ########################
    #  execute_frame_hook  # 
    ########################

    context '#execute_frame_hook' do

      RSpec::Matchers.define :have_executed_frame_hook do |inheriting_instance|
        match do |instance|
          block_ran = false
          frame.block_action = ::Proc.new { block_ran = true }
          mock_controller.execute_frame_hook( frame, inheriting_instance, instance )
          case include_or_extend
            when :include
              inheriting_instance.ancestors.include?( module_a ).should == true
              inheriting_instance.is_a?( module_a ).should == false
            when :extend
              inheriting_instance.ancestors.include?( module_a ).should == false
              inheriting_instance.is_a?( module_a ).should == true
            when :include_and_extend, :extend_and_include
              inheriting_instance.ancestors.include?( module_a ).should == true
              inheriting_instance.is_a?( module_a ).should == true
          end
          block_ran.should == true
        end
        failure_message_for_should { "frame hook will not execute" }
      end

      let( :modules ) { [ module_a ] }

      context 'when :include' do
        let( :include_or_extend ) { :include }
        it 'will include modules' do
          module_instance.should have_executed_frame_hook( instance_of_class_inheriting_from_module )
        end
      end
      
      context 'when :extend' do
        let( :include_or_extend ) { :extend }
        it 'will extend modules' do
          module_instance.should have_executed_frame_hook( instance_of_class_inheriting_from_module )
        end
      end
      
      context 'when :include and :extend' do
        let( :include_or_extend ) { :include_and_extend }
        it 'will include and then extend modules' do
          module_instance.should have_executed_frame_hook( instance_of_class_inheriting_from_module )
        end
      end
      
      context 'when :extend and :include' do
        let( :include_or_extend ) { :extend_and_include }
        it 'will extend and then include modules' do
          module_instance.should have_executed_frame_hook( instance_of_class_inheriting_from_module )
        end
      end

      it 'will execute block action' do
        module_instance.should have_executed_frame_hook( instance_of_class_inheriting_from_module )
      end
      
    end

    #########################
    #  evaluate_frame_hook  #
    #########################

    context '#evaluate_frame_hook' do

      RSpec::Matchers.define :have_evaluated_frame_hook do |inheriting_instance|
        match do |instance|
          mock_controller.evaluate_frame_hook( frame, inheriting_instance, instance, event_context ).should == should_execute
          inheriting_instance.is_a?( module_a ).should == should_execute
        end
        failure_message_for_should { "frame hook evaluation failed" }
      end

      let( :modules ) { [ module_a ] }
      let( :include_or_extend ) { :extend }

      context 'frame should not execute' do
        let( :instance_contexts ) { [ :instance ] }
        let( :should_execute ) { false }
        it 'will not execute and return false' do
          module_instance.should have_evaluated_frame_hook( instance_of_class_inheriting_from_module )
        end
      end
      context 'frame should execute' do
        let( :should_execute ) { true }
        it 'will execute and return true' do
          module_instance.should have_evaluated_frame_hook( instance_of_class_inheriting_from_module )
        end
      end
    end

    ############################
    #  evaluate_cluster_stack  #
    ############################

    context '#evaluate_cluster_stack' do
      
      RSpec::Matchers.define :have_evaluated_cluster_stack do |inheriting_instance|
        match do |instance|
          mock_controller.evaluate_cluster_stack( instance_of_class_inheriting_from_module, module_instance, event_context )
          # check cascade
          mock_controller.instance_controller( instance_of_class_inheriting_from_module ).before_include_stack.should == [ cascade_frame, cascade_and_execute_frame ]
          # check execute
          instance_of_class_inheriting_from_module.is_a?( module_a ).should == false
          instance_of_class_inheriting_from_module.is_a?( module_b ).should == true
          instance_of_class_inheriting_from_module.is_a?( module_c ).should == true
          instance_of_class_inheriting_from_module.is_a?( module_d ).should == false
        end
        failure_message_for_should { "frame hook evaluation failed" }
      end
      
      let( :module_a ) { ::Module.new }
      let( :module_b ) { ::Module.new }
      let( :module_c ) { ::Module.new }
      let( :module_d ) { ::Module.new }
      let( :cascade_modules ) { [ module_a ] }
      let( :execute_modules ) { [ module_b ] }
      let( :cascade_and_execute_modules ) { [ module_c ] }
      let( :disabled_modules ) { [ module_d ] }
      let( :include_or_extend ) { :extend }
    
      let( :cascade_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cascade_cluster, [ :any ], [ :instance ], cascade_modules, include_or_extend, block_action ) }
      let( :execute_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :execute_cluster, cascade_contexts, instance_contexts, execute_modules, include_or_extend, block_action ) }
      let( :cascade_and_execute_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cascade_and_execute_cluster, [ :any ], instance_contexts, cascade_and_execute_modules, include_or_extend, block_action ) }
      let( :disabled_frame ) do
        controller_for_module = mock_controller.instance_controller( module_instance )
        controller_for_module.cluster( :disabled_cluster ).disable
        ::Module::Cluster::Cluster::Frame.new( module_instance, :disabled_cluster, cascade_contexts, instance_contexts, disabled_modules, include_or_extend, block_action )
      end
      
      let( :enabled_module_instance ) do
        # put frames on stack for enabled instance
        mock_controller.instance_controller( module_instance ).before_include_stack.push( cascade_frame, execute_frame, cascade_and_execute_frame, disabled_frame )
        module_instance
      end
    
      it 'will evaluate frames' do
        enabled_module_instance.should have_evaluated_cluster_stack( instance_of_class_inheriting_from_module )
      end
    
    end
  
  end

end
