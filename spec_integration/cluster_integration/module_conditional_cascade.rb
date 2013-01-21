
shared_examples_for :ModuleConditionalCascadeIntegration do

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
    
  context 'conditional for :module' do

    let( :execution_contexts ) { [ :module ] }

    context 'cascade to :module' do
      let( :cascade_contexts ) { [ :module ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
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

    context 'cascade to :class' do
      let( :cascade_contexts ) { [ :class ] }
      context 'for hooked module' do
        it 'will not execute but will cascade' do
          module_instance.should have_cascaded_but_not_executed( *integration_args )
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

    context 'cascade to :subclass' do
      let( :cascade_contexts ) { [ :subclass ] }
      context 'for hooked module' do
        it 'will not execute but will cascade' do
          module_instance.should have_cascaded_but_not_executed( *integration_args )
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
    
    context 'cascade to :each_subclass' do
      let( :cascade_contexts ) { [ :each_subclass ] }
      context 'for hooked module' do
        it 'will not execute but will cascade' do
          module_instance.should have_cascaded_but_not_executed( *integration_args )
        end
        it 'first class will not execute but will cascade' do
          first_class.should have_cascaded_but_not_executed( *class_integration_args )
        end
        it 'will execute for the first subclass and cascade (if explicit include/extend cascading is desired)' do
          first_subclass.should have_executed_and_cascaded( *class_integration_args )
        end
        it 'will execute for the nth subclass and cascade (if explicit include/extend cascading is desired)' do
          nth_subclass.should have_executed_and_cascaded( *class_integration_args )
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
    
    context 'cascade to :module, :class' do
      let( :cascade_contexts ) { [ :module, :class ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
        end
        it 'nth module will execute and cascade' do
          nth_module.should have_executed_and_cascaded( *integration_args )
        end
        it 'will execute in the first class but not cascade' do
          first_class.should have_executed_but_not_cascaded( *class_integration_args )
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
    
    context 'cascade to :module, :subclass' do
      let( :cascade_contexts ) { [ :module, :subclass ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
        end
        it 'nth module will execute and cascade' do
          nth_module.should have_executed_and_cascaded( *integration_args )
        end
        it 'first class will not execute but will cascade' do
          first_class.should have_cascaded_but_not_executed( *class_integration_args )
        end
        it 'first subclass will execute and cascade only the block' do
          first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
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
    
    context 'cascade to :module, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :each_subclass ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
        end
        it 'nth module will execute and cascade' do
          nth_module.should have_executed_and_cascaded( *integration_args )
        end
        it 'first class will not execute but will cascade' do
          first_class.should have_cascaded_but_not_executed( *class_integration_args )
        end
        it 'nth subclass will execute and cascade' do
          nth_subclass.should have_executed_and_cascaded( *class_integration_args )
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
    
    context 'cascade to :module, :class, :subclass' do
      let( :cascade_contexts ) { [ :module, :class, :subclass ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
        end
        it 'nth module will execute and cascade' do
          nth_module.should have_executed_and_cascaded( *integration_args )
        end
        it 'first class will execute and cascade only the block' do
          first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
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
    
    context 'cascade to :module, :class, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
      context 'for hooked module' do
        it 'will execute and cascade' do
          module_instance.should have_executed_and_cascaded( *integration_args )
        end
        it 'nth module will execute and cascade' do
          nth_module.should have_executed_and_cascaded( *integration_args )
        end
        it 'first class will execute and cascade' do
          first_class.should have_executed_and_cascaded( *class_integration_args )
        end
        it 'first subclass will execute and cascade' do
          first_subclass.should have_executed_and_cascaded( *class_integration_args )
        end
        it 'nth subclass will execute and cascade' do
          nth_subclass.should have_executed_and_cascaded( *class_integration_args )
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
    
    context 'cascade to :class, :subclass' do
      let( :cascade_contexts ) { [ :class, :subclass ] }
      context 'for hooked module' do
        it 'will not execute but will cascade' do
          module_instance.should have_cascaded_but_not_executed( *integration_args )
        end
        it 'nth module will not execute but will cascade' do
          nth_module.should have_cascaded_but_not_executed( *integration_args )
        end
        it 'first class will execute and cascade only the block' do
          first_class.should have_executed_and_cascaded_block_only( *class_integration_args )
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
    
    context 'cascade to :class, :each_subclass' do
      let( :cascade_contexts ) { [ :class, :each_subclass ] }
      context 'for hooked module' do
        it 'will not execute but will cascade' do
          module_instance.should have_cascaded_but_not_executed( *integration_args )
        end
        it 'nth module will not execute but will cascade' do
          nth_module.should have_cascaded_but_not_executed( *integration_args )
        end
        it 'first class will execute and cascade' do
          first_class.should have_executed_and_cascaded( *class_integration_args )
        end
        it 'first subclass will execute and cascade' do
          first_subclass.should have_executed_and_cascaded( *class_integration_args )
        end
        it 'nth subclass will execute and cascade' do
          nth_subclass.should have_executed_and_cascaded( *class_integration_args )
        end
      end
      context 'for hooked class' do
        it 'will not execute or cascade' do
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        end
      end
      context 'for hooked instance' do
        it 'will not execute or cascade' do
          object_instance.should not_have_executed_or_cascaded( *integration_args )
        end
      end
    end
  end
  
  context 'conditional for :class' do

    let( :execution_contexts ) { [ :class ] }

    context 'cascade to :subclass' do
      let( :cascade_contexts ) { [ :subclass ] }
      context 'for hooked module' do
        it 'will not execute or cascade' do
          module_instance.should not_have_executed_or_cascaded( *integration_args )
        end
      end
      context 'for hooked class' do
        let( :first_subclass ) { ::Class.new( class_instance ).name( :FirstSubclass ) }
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

    context 'cascade to :each_subclass' do
      let( :cascade_contexts ) { [ :each_subclass ] }
      context 'for hooked module' do
        it 'will not execute or cascade' do
          module_instance.should not_have_executed_or_cascaded( *integration_args )
        end
      end
      context 'for hooked class' do
        let( :first_subclass ) { ::Class.new( class_instance ).name( :FirstSubclass ) }
        it 'will not execute but will cascade' do
          class_instance.should have_cascaded_but_not_executed( *class_integration_args )
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
  
  context 'conditional for :instance' do

    let( :execution_contexts ) { [ :instance ] }

    context 'cascade to :any' do
      let( :cascade_contexts ) { [ :any ] }
      it 'will execute but not cascade' do
      end
    end

    context 'cascade to :module' do
      let( :cascade_contexts ) { [ :module ] }
      it 'will not execute or cascade' do
      end
    end

    context 'cascade to :class' do
      let( :cascade_contexts ) { [ :class ] }
      it 'will not execute or cascade' do
      end
    end

    context 'cascade to :subclass' do
      let( :cascade_contexts ) { [ :subclass ] }
      it 'will not execute or cascade' do
      end
    end

    context 'cascade to :each_subclass' do
      let( :cascade_contexts ) { [ :each_subclass ] }
      it 'will not execute or cascade' do
      end
    end

  end

end
