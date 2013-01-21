
shared_examples_for :ClassInheritingFromModuleSubclassStacksIntegration do
  
  let( :clustered_instance ) do
    clustered_instance = ::Class.new( ::Module ).name( :CascadeEnabledClassInheritingFromModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    cluster.subclass.cascade_to( *cascade_contexts ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  let( :subclass_of_class_inheriting_from_module ) { ::Class.new( clustered_instance ).name( :SubclassOfClassInheritingFromModule ) }
  let( :instance_of_class_inheriting_from_module ) { clustered_instance.new.name( :InstanceOfClassInheritingFromModule ) }

  let( :cascade_args ) { [ include_modules, extend_modules, block_state ] }

  let( :event_context ) { :subclass }
  
  context 'class => class' do
    
    context 'cascade_context is nil' do
      it 'will execute but not cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                        event_context, 
                                                                                        *cascade_args )
      end
    end

    context 'cascade_context is :any' do
      let( :cascade_contexts ) { [ :any ] }
      it 'will execute and cascade block only' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded_block_only( clustered_instance, 
                                                                                               event_context, 
                                                                                               *cascade_args )
      end
    end

    context 'cascade_context is :class' do
      let( :cascade_contexts ) { [ :class ] }
      it 'will not execute or cascade' do
        subclass_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module' do
      let( :cascade_contexts ) { [ :module ] }
      it 'will cascade but not execute' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        event_context, 
                                                                                        *cascade_args )
      end
    end

    context 'cascade_context is :subclass' do
      let( :cascade_contexts ) { [ :subclass ] }
      it 'will execute and cascade block only' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded_block_only( clustered_instance, 
                                                                                               event_context, 
                                                                                               *cascade_args )
      end
    end

    context 'cascade_context is :each_subclass' do
      let( :cascade_contexts ) { [ :each_subclass ] }
      it 'will execute and cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    event_context, 
                                                                                    *cascade_args )
      end
    end

    context 'cascade_context is :module, :class' do
      let( :cascade_contexts ) { [ :module, :class ] }
      it 'will execute and cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    event_context, 
                                                                                    *cascade_args )
      end
    end

    context 'cascade_context is :module, :class, :subclass' do
       let( :cascade_contexts ) { [ :module, :class, :subclass ] }
       it 'will execute and cascade block only' do
         subclass_of_class_inheriting_from_module.should have_executed_and_cascaded_block_only( clustered_instance, 
                                                                                                event_context, 
                                                                                                *cascade_args )
       end
    end

    context 'cascade_context is :module, :class, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
      it 'will execute and cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    event_context, 
                                                                                    *cascade_args )
      end
    end

    context 'cascade_context is :module, :subclass' do
      let( :cascade_contexts ) { [ :module, :subclass ] }
      it 'will execute and cascade block only' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded_block_only( clustered_instance, 
                                                                                               event_context, 
                                                                                               *cascade_args )
      end
    end

    context 'cascade_context is :module, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :each_subclass ] }
      it 'will execute and cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    event_context, 
                                                                                    *cascade_args )
      end
    end

    context 'cascade_context is :class, :subclass' do
      let( :cascade_contexts ) { [ :class, :subclass ] }
      it 'will execute and cascade block only' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded_block_only( clustered_instance, 
                                                                                               event_context, 
                                                                                               *cascade_args )
      end
    end

    context 'cascade_context is :class, :each_subclass' do
      let( :cascade_contexts ) { [ :class, :each_subclass ] }
      it 'will execute and cascade' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    event_context, 
                                                                                    *cascade_args )
      end
    end

  end

  context 'class => module (class.new)' do

    context 'cascade_context is nil' do
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :any' do
      let( :cascade_contexts ) { [ :any ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :class' do
      let( :cascade_contexts ) { [ :class ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module' do
      let( :cascade_contexts ) { [ :module ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :subclass' do
      let( :cascade_contexts ) { [ :subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :each_subclass' do
      let( :cascade_contexts ) { [ :each_subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module, :class' do
      let( :cascade_contexts ) { [ :module, :class ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module, :class, :subclass' do
       let( :cascade_contexts ) { [ :module, :class, :subclass ] }
       it 'will not execute or cascade' do
         instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                        event_context, 
                                                                                        *cascade_args )
       end
    end

    context 'cascade_context is :module, :class, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module, :subclass' do
      let( :cascade_contexts ) { [ :module, :subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :module, :each_subclass' do
      let( :cascade_contexts ) { [ :module, :each_subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :class, :subclass' do
      let( :cascade_contexts ) { [ :class, :subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

    context 'cascade_context is :class, :each_subclass' do
      let( :cascade_contexts ) { [ :class, :each_subclass ] }
      it 'will not execute or cascade' do
        instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                       event_context, 
                                                                                       *cascade_args )
      end
    end

  end
  
end
