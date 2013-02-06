
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
    _include_or_extend = include_or_extend
    ::Module.new.name( :NthModule ).module_eval { __send__( _include_or_extend, _module_instance ) }
  end
  
  let( :first_class ) do
    _nth_module = nth_module
    _include_or_extend = include_or_extend
    ::Class.new.name( :FirstClass ).module_eval { __send__( _include_or_extend, _nth_module ) }
  end

  let( :first_subclass ) { ::Class.new( first_class ).name( :FirstSubclass ) }
  let( :nth_subclass ) { ::Class.new( first_subclass ).name( :NthSubclass ) }
  
  let( :instance_extended_with_first_module ) do
    object_intance = ::Object.new.extend( module_instance )
    object_intance.name( :InstanceExtendedwithFirstModule )
    object_intance
  end

  let( :instance_extended_with_nth_module ) do
    object_intance = ::Object.new.extend( nth_module )
    object_intance.name( :InstanceExtendedwithNthModule )
    object_intance
  end
  
  ##########
  #  :any  #
  ##########
  
  context 'to :any' do

    let( :cascade_contexts ) { [ :any ] }
    
    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute for nth module and cascade' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will execute but not cascade' do
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will execute for nth module and cascade' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will not execute in the nth module but will cascade' do
        nth_module.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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

  ###############
  #  :instance  #
  ###############
  
  context 'to :instance' do

    let( :cascade_contexts ) { [ :instance ] }
    
    context 'for hooked module' do
      it 'will cascade but not execute' do
        module_instance.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will execute but not cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will cascade but not execute' do
        nth_module.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will execute but not cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will not execute or cascade for first class' do
        first_class.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute or cascade' do
        class_instance.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will execute but not cascade' do
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will not execute in the nth module but will cascade' do
        nth_module.should have_cascaded_but_not_executed( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will execute and will cascade for the nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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
  #  :module, :instance  #
  ########################

  context 'to :module, :instance' do

    let( :cascade_contexts ) { [ :module, :instance ] }
    
    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will not execute or cascade for first class' do
        first_class.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute or cascade' do
        class_instance.should not_have_executed_or_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will execute but not cascade' do
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
      end
    end

  end

  ################################
  #  :module, :class, :instance  #
  ################################
  
  context 'to :module, :class, :instance' do

    let( :cascade_contexts ) { [ :module, :class, :instance ] }
    
    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute for nth module and cascade' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will execute but not cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute for the first class but not cascade' do
        first_class.should have_executed_but_not_cascaded( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute but not cascade' do
        class_instance.should have_executed_but_not_cascaded( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will execute but not cascade' do
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
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
  
  ###################################
  #  :module, :subclass, :instance  #
  ###################################

  context 'to :module, :subclass, :instance' do

    let( :cascade_contexts ) { [ :module, :subclass, :instance ] }

    context 'for hooked module' do
      it 'will execute and will cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
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
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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

  ########################################
  #  :module, :each_subclass, :instance  #
  ########################################

  context 'to :module, :each_subclass, :instance' do

    let( :cascade_contexts ) { [ :module, :each_subclass, :instance ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
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
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
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

  ###########################################
  #  :module, :class, :subclass, :instance  #
  ###########################################

  context 'to :module, :class, :subclass, :instance' do

    let( :cascade_contexts ) { [ :module, :class, :subclass, :instance ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute in the first class and cascade block only' do
        first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute and cascade block only' do
        class_instance.should have_executed_and_cascaded_block_only( *class_integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
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
      it 'will not execute or cascade for instance extended with first module' do
        instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
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

  ################################################
  #  :module, :class, :each_subclass, :instance  #
  ################################################

  context 'to :module, :class, :each_subclass, :instance' do

    let( :cascade_contexts ) { [ :module, :class, :each_subclass, :instance ] }

    context 'for hooked module' do
      it 'will execute and cascade' do
        module_instance.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with first module' do
        if include_or_extend == :include
          instance_extended_with_first_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_first_module.should have_executed_but_not_cascaded( *integration_args )
        end
      end
      it 'will execute and cascade for nth module' do
        nth_module.should have_executed_and_cascaded( *integration_args )
      end
      it 'will not execute or cascade for instance extended with nth module' do
        if include_or_extend == :include
          instance_extended_with_nth_module.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          instance_extended_with_nth_module.should have_executed_but_not_cascaded( *integration_args )
        end
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
        if include_or_extend == :include
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        elsif include_or_extend == :extend
          object_instance.should have_executed_but_not_cascaded( *integration_args )
        end
      end
    end

  end
  
end
