
shared_examples_for :ModuleCascadeIntegration do

  let( :clustered_instance ) do
    clustered_instance = ::Module.new.name( :CascadeEnabledModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name ).__send__( event_context, *execution_contexts )
    cluster.cascade_to( *cascade_contexts )
    cluster.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end

  let( :nth_module ) do
    _module_instance = module_instance
    ::Module.new.name( :NthModule ).module_eval { include _module_instance }
  end
  
  let( :first_class ) do
    _nth_module = nth_module
    ::Class.new.name( :FirstClass ).module_eval { include _nth_module }
  end

  let( :first_subclass ) { ::Class.new( first_class ).name( :FirstSubclass ) }
  let( :nth_subclass ) { ::Class.new( first_subclass ).name( :NthSubclass ) }
  
  ##########
  #  :any  #
  ##########
  
  context 'to :any' do

    let( :cascade_contexts ) { [ :any ] }
    
    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute for nth module and cascade' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute for the first class and cascade only the block' do
        first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute and cascade only the block' do
        class_instance.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      let( :event_context ) { :before_extend }
      it 'will execute but not cascade' do
        object_instance.should have_executed_but_not_cascaded( *integration_args )
      end
    end

  end
  
  #############
  #  :module  #
  #############
  
  context 'to :module' do
    
    let( :cascade_contexts ) { [ :module ] }
    
    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute for nth module and cascade' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute for the first class or cascade' do
        first_class.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked class' do
      it 'will not execute or cascade' do
        class_instance.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  ############
  #  :class  #
  ############
  
  context 'to :class' do
    
    let( :cascade_contexts ) { [ :class ] }
    
    context 'for hooked module' do
      it 'will not execute but will cascade' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute but not cascade' do
        class_instance.should have_executed_but_not_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end

  ###############
  #  :subclass  #
  ###############
  
  context 'to :subclass' do
    
    let( :cascade_contexts ) { [ :subclass ] }
    
    context 'for hooked module' do
      it 'will not execute but will cascade' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute in the first class but will cascade' do
        first_class.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass but will only cascade the block' do
        first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute but will cascade' do
        class_instance.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass but will only cascade the block' do
        first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  ####################
  #  :each_subclass  #
  ####################
  
  context 'to :each_subclass' do
    
    let( :cascade_contexts ) { [ :each_subclass ] }
    
    context 'for hooked module' do
      it 'will not execute but will cascade' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute in the nth module but will cascade' do
        nth_module.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute in the first class but will cascade' do
        first_class.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked class' do
      it 'will not execute but will cascade' do
        class_instance.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  #######################
  #  :class, :subclass  #
  #######################
  
  context 'to :class, :subclass' do
    
    let( :cascade_contexts ) { [ :class, :subclass ] }
    
    context 'for hooked module' do
      it 'will not execute but will cascade' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will execute in the first class but will cascade only the block' do
        first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute but will cascade only the block' do
        class_instance.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  ############################
  #  :class, :each_subclass  #
  ############################
  
  context 'to :class, :each_subclass' do
    
    let( :cascade_contexts ) { [ :class, :each_subclass ] }
    
    context 'for hooked module' do
      it 'will not execute but will cascade' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute in the nth module but will cascade' do
        nth_module.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will execute in the first class and cascade' do
        first_class.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked class' do
      it 'will execute and cascade' do
        class_instance.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end
    
    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  #####################
  #  :module, :class  #
  #####################
  
  context 'to :module, :class' do

    let( :cascade_contexts ) { [ :module, :class ] }

    context 'for hooked module' do
      it 'will execute and will cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute and will cascade for the nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute in the first class but not cascade' do
        first_class.should have_executed_but_not_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute but not cascade' do
        class_instance.should have_executed_but_not_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  ########################
  #  :module, :subclass  #
  ########################
  
  context 'to :module, :subclass' do

    let( :cascade_contexts ) { [ :module, :subclass ] }

    context 'for hooked module' do
      it 'will execute and will cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute in the first class but will cascade' do
        first_class.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and cascade only the block' do
        first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute but will cascade' do
        class_instance.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and cascade only the block' do
        first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  #############################
  #  :module, :each_subclass  #
  #############################
  
  context 'to :module, :each_subclass' do

    let( :cascade_contexts ) { [ :module, :each_subclass ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute in the first class but will cascade' do
        first_class.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute but will cascade' do
        class_instance.should have_cascaded_but_not_executed( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  ################################
  #  :module, :class, :subclass  #
  ################################
  
  context 'to :module, :class, :subclass' do

    let( :cascade_contexts ) { [ :module, :class, :subclass ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute in the first class and cascade' do
        first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute and cascade' do
        class_instance.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end

  #####################################
  #  :module, :class, :each_subclass  #
  #####################################
  
  context 'to :module, :class, :each_subclass' do

    let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute in the first class and cascade' do
        first_class.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in the first subclass and will cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in each nth subclass and will cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute and cascade' do
        class_instance.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in the first subclass and cascade' do
        first_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
      it 'will execute in the nth subclass and cascade' do
        nth_subclass.should have_executed_and_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
end
