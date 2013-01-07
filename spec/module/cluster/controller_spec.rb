
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::Controller do
  
  let( :mock_controller ) { ::Module.new.extend( ::Module::Cluster::Controller ) }

  let( :module_instance ) { ::Module.new }
  let( :module_instance_controller ) { mock_controller.instance_controller( module_instance ) }

  let( :class_instance ) { ::Class.new }
  let( :class_instance_controller ) { mock_controller.instance_controller( class_instance ) }

  let( :class_inheriting_module_instance ) { ::Class.new( ::Module ) }
  let( :class_inheriting_module_instance_controller ) { mock_controller.instance_controller( class_inheriting_module_instance ) }

  let( :inheriting_module_instance ) { ::Module.new }
  let( :inheriting_module_instance_controller ) { mock_controller.instance_controller( inheriting_module_instance ) }

  let( :inheriting_class_instance ) { ::Class.new( class_instance ) }
  let( :inheriting_class_instance_controller ) { mock_controller.instance_controller( inheriting_class_instance ) }
    
  ###################
  #  self.extended  #
  ###################
  
  it 'should automatically initialize an instances hash' do
    mock_controller.instance_variable_defined?( :@instances ).should == true
  end

  #########################
  #  instance_controller  #
  #########################

  it 'creates and tracks instances controllers for instances' do
    module_instance_controller.is_a?( ::Module::Cluster::InstanceController ).should == true
    mock_controller.instance_controller( module_instance ).should == module_instance_controller
  end
  
  ################################
  #  enable_with_module_cluster  #
  ################################
  
  it 'can enable a module with module cluster' do
    mock_controller.enable_with_module_cluster( module_instance )
    module_instance.is_a?( ::Module::Cluster::ModuleSupport ).should == true
    module_instance.is_a?( ::Module::Cluster::ClassSupport ).should == false
  end

  it 'can enable a class with module cluster' do
    mock_controller.enable_with_module_cluster( class_instance )
    class_instance.is_a?( ::Module::Cluster::ClassSupport ).should == true
    class_instance.is_a?( ::Module::Cluster::ModuleSupport ).should == false
  end

  it 'can enable a class that subclasses Module with module cluster' do
    mock_controller.enable_with_module_cluster( class_inheriting_module_instance )
    class_inheriting_module_instance.is_a?( ::Module::Cluster::ClassSupport ).should == true
    class_inheriting_module_instance.is_a?( ::Module::Cluster::ModuleSupport ).should == false
    module_instance = class_inheriting_module_instance.new
    module_instance.is_a?( ::Module::Cluster::ModuleSupport ).should == true
    module_instance.is_a?( ::Module::Cluster::ClassSupport ).should == false
  end

  context 'cascading stacks' do

    before :each do
      inheriting_module_instance_controller
    end

    ###################################
    #  cascade_include_extend_stacks  #
    ###################################

    context 'when include/extend stacks exist' do
      
      before :each do
        if stack
          module_instance_controller.before_include_stack.push( *stack )
          module_instance_controller.before_extend_stack.push( *stack )
          module_instance_controller.after_include_stack.push( *stack )
          module_instance_controller.after_extend_stack.push( *stack )
        end
        mock_controller.cascade_include_extend_stacks( inheriting_module_instance, module_instance )
      end
      
      def has_cascaded?( instance_controller )
        instance_controller.has_before_include_stack?.should == true
        instance_controller.has_before_extend_stack?.should == true
        instance_controller.has_after_include_stack?.should == true
        instance_controller.has_after_extend_stack?.should == true
        instance_controller.before_include_stack.should == stack
        instance_controller.before_extend_stack.should == stack
        instance_controller.after_include_stack.should == stack
        instance_controller.after_extend_stack.should == stack
      end
      
      context 'when include/extend stacks have members' do
        let( :stack ) { [ :A, :B, :C ] }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          has_cascaded?( inheriting_module_instance_controller ).should == true
        end
      end

      context 'when include/extend stacks are empty' do
        let( :stack ) { [ ] }    
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          has_cascaded?( inheriting_module_instance_controller ).should == true
        end
      end

    end
    
    context 'when include/extend stacks do not exist' do
      let( :stack ) { nil }
      it 'can cause an instance to inherit include/extend stacks from another instance' do
        inheriting_module_instance_controller.has_before_include_stack?.should == false
        inheriting_module_instance_controller.has_before_extend_stack?.should == false
        inheriting_module_instance_controller.has_after_include_stack?.should == false
        inheriting_module_instance_controller.has_after_extend_stack?.should == false
      end
    end
    
    ############################
    #  cascade_subclass_stack  #
    ############################
  
    context 'when subclass stack exists' do
    
      before :each do
        if stack
          module_instance_controller.subclass_stack.push( *stack )
        end
        mock_controller.cascade_subclass_stack( inheriting_module_instance, module_instance )
      end
    
      def has_cascaded?( instance_controller )
        instance_controller.has_subclass_stack?.should == true
        instance_controller.subclass_stack.should == stack
      end
    
      context 'when subclass stack has members' do
        let( :stack ) { [ :A, :B, :C ] }
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          has_cascaded?( inheriting_module_instance_controller ).should == true
        end
      end

      context 'when subclass stack is empty' do
        let( :stack ) { [ ] }    
        it 'can cause an instance to inherit include/extend stacks from another instance' do
          has_cascaded?( inheriting_module_instance_controller ).should == true
        end
      end

    end

    context 'when subclass stack does not exist' do
      let( :stack ) { nil }
      it 'can cause an instance to inherit the subclass stack from another instance when it does not exist' do
        inheriting_module_instance_controller.has_subclass_stack?.should == false
      end
    end

  end
  
  context 'frame parsing' do
    
    let( :frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cluster_name, cascade_contexts, instance_contexts, modules, include_or_extend, block_action ) }
    let( :cascade_contexts ) { nil }
    let( :instance_contexts ) { nil }
    let( :modules ) { nil }
    let( :include_or_extend ) { nil }
    let( :block_action ) { nil }
    let( :event_context ) { :before_include }
    let( :some_module ) { ::Module.new }
    
    ###########################
    #  frame_should_cascade?  #
    ###########################
  
    context 'frame_should_cascade?' do

      let( :instance_contexts ) { nil }

      def cascaded?( instance )
        return mock_controller.frame_should_cascade?( frame, instance, event_context )
      end

      context 'when cascade context is nil' do
        let( :cascade_contexts ) { nil }
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end

      context 'when cascade context is empty' do
        let( :cascade_contexts ) { [ ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end
  
      context 'when cascade context is :any' do
        let( :cascade_contexts ) { [ :any ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end

      context 'when cascade context contains :class' do
        let( :cascade_contexts ) { [ :class ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should not cascade for a module' do
            cascaded?( module_instance ).should == false
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end

      context 'when cascade context contains :module' do
        let( :cascade_contexts ) { [ :module ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end

      context 'when cascade context contains :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }      
        context 'when event context is :before_include' do
          let( :event_context ) { :before_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :before_extend' do
          let( :event_context ) { :before_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_include' do
          let( :event_context ) { :after_include }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :after_extend' do
          let( :event_context ) { :after_extend }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should not cascade for a class' do
            cascaded?( class_instance ).should == false
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
        context 'when event context is :subclass' do
          let( :event_context ) { :subclass }
          it 'should cascade for a module' do
            cascaded?( module_instance ).should == true
          end
          it 'should cascade for a class' do
            cascaded?( class_instance ).should == true
          end
          it 'should not cascade for an instance' do
            cascaded?( class_instance.new ).should == false
          end
        end
      end

    end
    
    ###########################
    #  frame_should_execute?  #
    ###########################
    
    context 'frame_should_execute?' do
            
      def should_execute?( instance )
        return mock_controller.frame_should_execute?( frame, instance, event_context )
      end
      
      context 'when instance context is nil' do
        let( :instance_contexts ) { nil }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == true
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == true
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == true
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == true
        end
      end

      context 'when instance context is empty' do
        let( :instance_contexts ) { [ ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == true
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == true
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == true
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == true
        end
      end

      context 'when instance context is :any' do
        let( :instance_contexts ) { [ :any ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == true
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == true
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == true
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == true
        end
      end

      context 'when instance context is :class' do
        let( :instance_contexts ) { [ :class ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == true
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == true
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == false
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == false
        end
      end

      context 'when instance context is :module' do
        let( :instance_contexts ) { [ :module ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == false
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == false
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == true
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == false
        end
      end

      context 'when instance context is subclass and event is not subclass' do
        let( :instance_contexts ) { [ :subclass ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == false
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == false
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == false
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == false
        end
      end

      context 'when instance context is subclass and event is subclass' do
        let( :instance_contexts ) { [ :subclass ] }
        let( :event_context ) { :subclass }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == true
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == true
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == false
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == false
        end
      end

      context 'when instance context is instance' do
        let( :instance_contexts ) { [ :instance ] }
        it 'class instance should execute' do
          should_execute?( class_instance ).should == false
        end
        it 'subclass instance should execute' do
          should_execute?( inheriting_class_instance ).should == false
        end
        it 'module instance should execute' do
          should_execute?( module_instance ).should == false
        end
        it 'instance instance should execute' do
          should_execute?( ::Object.new ).should == true
        end
      end

    end
    
    ###########################
    #  execute_frame_cascade  #
    ###########################
  
    it 'can cause a frame to cascade to the next inheriting instance' do
      mock_controller.instance_controller( module_instance ).before_include_stack.should == [ ]
      mock_controller.execute_frame_cascade( frame, module_instance, event_context )
      mock_controller.instance_controller( module_instance ).before_include_stack.should == [ frame ]
    end

    ############################
    #  evaluate_frame_cascade  #
    ############################

    context 'evaluate_frame_cascade' do
      
      context 'when it should not cascade' do
        it 'will not execute cascade if frame should not cascade and report did not cascade' do
          mock_controller.evaluate_frame_cascade( frame, inheriting_module_instance, module_instance, event_context ).should == false
          mock_controller.instance_controller( inheriting_module_instance ).stack( event_context ).should == [ ]
        end
      end

      context 'when it should cascade' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will execute cascade if frame should cascade and report cascades' do
          mock_controller.evaluate_frame_cascade( frame, inheriting_module_instance, module_instance, event_context ).should == true
          mock_controller.instance_controller( inheriting_module_instance ).stack( event_context ).should == [ frame ]
        end
      end
      
    end

    ########################
    #  execute_frame_hook  # 
    ########################

    context 'execute_frame_hook' do

      let( :modules ) { [ some_module ] }

      context 'when include' do
        let( :include_or_extend ) { :include }
        it 'should include modules' do
          block_ran = false
          frame.block_action = ::Proc.new { block_ran = true }
          mock_controller.execute_frame_hook( frame, inheriting_module_instance, module_instance )
          inheriting_module_instance.ancestors.include?( some_module ).should == true
          inheriting_module_instance.is_a?( some_module ).should == false
          block_ran.should == true
        end
      end
      
      context 'when extend' do
        let( :include_or_extend ) { :extend }
        it 'should extend modules' do
          block_ran = false
          frame.block_action = ::Proc.new { block_ran = true }
          mock_controller.execute_frame_hook( frame, inheriting_module_instance, module_instance )
          inheriting_module_instance.ancestors.include?( some_module ).should == false
          inheriting_module_instance.is_a?( some_module ).should == true
          block_ran.should == true
        end
      end
      
      context 'when include and extend' do
        let( :include_or_extend ) { :include_and_extend }
        it 'should include and then extend modules' do
          block_ran = false
          frame.block_action = ::Proc.new { block_ran = true }
          mock_controller.execute_frame_hook( frame, inheriting_module_instance, module_instance )
          inheriting_module_instance.ancestors.include?( some_module ).should == true
          inheriting_module_instance.is_a?( some_module ).should == true
          block_ran.should == true
        end
      end
      
      context 'when extend and include' do
        let( :include_or_extend ) { :extend_and_include }
        it 'should extend and then include modules' do
          block_ran = false
          frame.block_action = ::Proc.new { block_ran = true }
          mock_controller.execute_frame_hook( frame, inheriting_module_instance, module_instance )
          inheriting_module_instance.ancestors.include?( some_module ).should == true
          inheriting_module_instance.is_a?( some_module ).should == true
          block_ran.should == true
        end
      end

      it 'should execute block action' do
        block_ran = false
        frame.block_action = ::Proc.new { block_ran = true }
        mock_controller.execute_frame_hook( frame, inheriting_module_instance, module_instance )
        block_ran.should == true
      end
    end

    #########################
    #  evaluate_frame_hook  #
    #########################

    context 'evaluate_frame_hook' do

      let( :modules ) { [ some_module ] }
      let( :include_or_extend ) { :extend }

      context 'frame should not execute' do
        let( :instance_contexts ) { [ :instance ] }
        it 'should not execute and return false' do
          mock_controller.evaluate_frame_hook( frame, inheriting_module_instance, module_instance, event_context ).should == false
          inheriting_module_instance.is_a?( some_module ).should == false
        end
      end
      context 'frame should execute' do
        it 'should execute and return true' do
          mock_controller.evaluate_frame_hook( frame, inheriting_module_instance, module_instance, event_context ).should == true
          inheriting_module_instance.is_a?( some_module ).should == true
        end
      end
    end

    ############################
    #  evaluate_cluster_stack  #
    ############################

    context 'evaluate_cluster_stack' do
      
      let( :module_A ) { ::Module.new }
      let( :module_B ) { ::Module.new }
      let( :module_C ) { ::Module.new }
      let( :module_D ) { ::Module.new }
      let( :cascade_modules ) { [ module_A ] }
      let( :execute_modules ) { [ module_B ] }
      let( :cascade_and_execute_modules ) { [ module_C ] }
      let( :disabled_modules ) { [ module_D ] }
      let( :include_or_extend ) { :extend }
    
      let( :cascade_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cascade_cluster, [ :any ], [ :instance ], cascade_modules, include_or_extend, block_action ) }
      let( :execute_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :execute_cluster, cascade_contexts, instance_contexts, execute_modules, include_or_extend, block_action ) }
      let( :cascade_and_execute_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :cascade_and_execute_cluster, [ :any ], instance_contexts, cascade_and_execute_modules, include_or_extend, block_action ) }
      let( :disabled_frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, :disabled_cluster, cascade_contexts, instance_contexts, disabled_modules, include_or_extend, block_action ) }
    
      before :all do
        module_instance_controller = mock_controller.instance_controller( module_instance )
        module_instance_controller.cluster( :disabled_cluster ).disable
        module_instance_controller.before_include_stack.push( cascade_frame, execute_frame, cascade_and_execute_frame, disabled_frame )
      end
    
      it 'should evaluate frames' do
        mock_controller.evaluate_cluster_stack( inheriting_module_instance, module_instance, event_context )
        # check cascade
        mock_controller.instance_controller( inheriting_module_instance ).before_include_stack.should == [ cascade_frame, cascade_and_execute_frame ]
        # check execute
        inheriting_module_instance.is_a?( module_A ).should == false
        inheriting_module_instance.is_a?( module_B ).should == true
        inheriting_module_instance.is_a?( module_C ).should == true
        inheriting_module_instance.is_a?( module_D ).should == false
      end
    
    end
  
  end

end
