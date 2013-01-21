
shared_examples_for :ClassInheritingFromModuleModuleStacksIntegration do
  
  let( :clustered_instance ) do
    clustered_instance = ::Class.new( ::Module ).name( :CascadeEnabledClassInheritingFromModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    cluster.before_include.cascade_to( *cascade_contexts ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.before_extend.cascade_to( *cascade_contexts ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_include.cascade_to( *cascade_contexts ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_extend.cascade_to( *cascade_contexts ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  let( :subclass_of_class_inheriting_from_module ) { ::Class.new( clustered_instance ).name( :SubclassOfClassInheritingFromModule ) }
  let( :instance_of_class_inheriting_from_module ) { clustered_instance.new.name( :InstanceOfClassInheritingFromModule ) }

  let( :cascade_args ) { [ include_modules, extend_modules, block_state ] }

  context 'class => class' do

    context 'class => class' do

      context 'execution context is nil' do

        context 'cascade_context is nil' do
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class' do
          let( :cascade_contexts ) { [ :module, :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

         context 'cascade_context is :module, :class, :subclass' do
           let( :cascade_contexts ) { [ :module, :class, :subclass ] }
           it 'will cascade but not execute module hooks' do
             subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                             event_context, 
                                                                                             *cascade_args )
           end
        end

        context 'cascade_context is :module, :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :subclass' do
          let( :cascade_contexts ) { [ :module, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :subclass' do
          let( :cascade_contexts ) { [ :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :each_subclass' do
          let( :cascade_contexts ) { [ :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

      end

      context 'execution context is :any' do
        
        let( :execution_contexts ) { [ :any ] }
        
        context 'cascade_context is nil' do
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class' do
          let( :cascade_contexts ) { [ :module, :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

         context 'cascade_context is :module, :class, :subclass' do
           let( :cascade_contexts ) { [ :module, :class, :subclass ] }
           it 'will cascade but not execute module hooks' do
             subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                             event_context, 
                                                                                             *cascade_args )
           end
        end

        context 'cascade_context is :module, :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :subclass' do
          let( :cascade_contexts ) { [ :module, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :subclass' do
          let( :cascade_contexts ) { [ :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :each_subclass' do
          let( :cascade_contexts ) { [ :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

      end

      context 'execution context is :module' do
        
        let( :execution_contexts ) { [ :module ] }
        
        context 'cascade_context is nil' do
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class' do
          let( :cascade_contexts ) { [ :module, :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

         context 'cascade_context is :module, :class, :subclass' do
           let( :cascade_contexts ) { [ :module, :class, :subclass ] }
           it 'will cascade but not execute module hooks' do
             subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                             event_context, 
                                                                                             *cascade_args )
           end
        end

        context 'cascade_context is :module, :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :subclass' do
          let( :cascade_contexts ) { [ :module, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :subclass' do
          let( :cascade_contexts ) { [ :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end
        
      end

      context 'execution context is :class' do
        
        let( :execution_contexts ) { [ :class ] }
        
        context 'cascade_context is nil' do
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class' do
          let( :cascade_contexts ) { [ :module, :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class, :subclass' do
          let( :cascade_contexts ) { [ :module, :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :subclass' do
          let( :cascade_contexts ) { [ :module, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :subclass' do
          let( :cascade_contexts ) { [ :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :each_subclass' do
          let( :cascade_contexts ) { [ :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end
        
      end

      context 'execution context is :instance' do
        
        let( :execution_contexts ) { [ :instance ] }
        
        context 'cascade_context is nil' do
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :any' do
          let( :cascade_contexts ) { [ :any ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class' do
          let( :cascade_contexts ) { [ :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module' do
          let( :cascade_contexts ) { [ :module ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :subclass' do
          let( :cascade_contexts ) { [ :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :each_subclass' do
          let( :cascade_contexts ) { [ :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :class' do
          let( :cascade_contexts ) { [ :module, :class ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

         context 'cascade_context is :module, :class, :subclass' do
           let( :cascade_contexts ) { [ :module, :class, :subclass ] }
           it 'will cascade but not execute module hooks' do
             subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                             event_context, 
                                                                                             *cascade_args )
           end
        end

        context 'cascade_context is :module, :class, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :subclass' do
          let( :cascade_contexts ) { [ :module, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :module, :each_subclass' do
          let( :cascade_contexts ) { [ :module, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :subclass' do
          let( :cascade_contexts ) { [ :class, :subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

        context 'cascade_context is :class, :each_subclass' do
          let( :cascade_contexts ) { [ :class, :each_subclass ] }
          it 'will cascade but not execute module hooks' do
            subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                            event_context, 
                                                                                            *cascade_args )
          end
        end

      end

    end

  end

  context 'class => module (class.new)' do

    context 'execution context is nil' do

      context 'cascade_context is nil' do
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :any' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class' do
        let( :cascade_contexts ) { [ :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :each_subclass' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class' do
        let( :cascade_contexts ) { [ :module, :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :subclass' do
         let( :cascade_contexts ) { [ :module, :class, :subclass ] }
         it 'will cascade but not execute module hooks' do
           instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                           event_context, 
                                                                                           *cascade_args )
         end
      end

      context 'cascade_context is :module, :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :subclass' do
        let( :cascade_contexts ) { [ :module, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :subclass' do
        let( :cascade_contexts ) { [ :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :each_subclass' do
        let( :cascade_contexts ) { [ :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

    end

    context 'execution context is :any' do
     
      let( :execution_contexts ) { [ :any ] }
      
      context 'cascade_context is nil' do
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :any' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class' do
        let( :cascade_contexts ) { [ :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :each_subclass' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class' do
        let( :cascade_contexts ) { [ :module, :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :subclass' do
         let( :cascade_contexts ) { [ :module, :class, :subclass ] }
         it 'will cascade but not execute module hooks' do
           instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                           event_context, 
                                                                                           *cascade_args )
         end
      end

      context 'cascade_context is :module, :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :subclass' do
        let( :cascade_contexts ) { [ :module, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :subclass' do
        let( :cascade_contexts ) { [ :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :each_subclass' do
        let( :cascade_contexts ) { [ :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

    end

    context 'execution context is :module' do
      
      let( :execution_contexts ) { [ :module ] }
      
      context 'cascade_context is nil' do
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :any' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class' do
        let( :cascade_contexts ) { [ :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :each_subclass' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class' do
        let( :cascade_contexts ) { [ :module, :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :subclass' do
        let( :cascade_contexts ) { [ :module, :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :subclass' do
        let( :cascade_contexts ) { [ :module, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :subclass' do
        let( :cascade_contexts ) { [ :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end
      
    end

    context 'execution context is :class' do
      
      let( :execution_contexts ) { [ :class ] }
      
      context 'cascade_context is nil' do
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :any' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class' do
        let( :cascade_contexts ) { [ :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :each_subclass' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class' do
        let( :cascade_contexts ) { [ :module, :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :subclass' do
        let( :cascade_contexts ) { [ :module, :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :subclass' do
        let( :cascade_contexts ) { [ :module, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :subclass' do
        let( :cascade_contexts ) { [ :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :each_subclass' do
        let( :cascade_contexts ) { [ :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end
      
    end

    context 'execution context is :instance' do
      
      let( :execution_contexts ) { [ :instance ] }
      
      context 'cascade_context is nil' do
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :any' do
        let( :cascade_contexts ) { [ :any ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class' do
        let( :cascade_contexts ) { [ :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module' do
        let( :cascade_contexts ) { [ :module ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :subclass' do
        let( :cascade_contexts ) { [ :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :each_subclass' do
        let( :cascade_contexts ) { [ :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class' do
        let( :cascade_contexts ) { [ :module, :class ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :subclass' do
        let( :cascade_contexts ) { [ :module, :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :class, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :subclass' do
        let( :cascade_contexts ) { [ :module, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :module, :each_subclass' do
        let( :cascade_contexts ) { [ :module, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :subclass' do
        let( :cascade_contexts ) { [ :class, :subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

      context 'cascade_context is :class, :each_subclass' do
        let( :cascade_contexts ) { [ :class, :each_subclass ] }
        it 'will cascade but not execute module hooks' do
          instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                          event_context, 
                                                                                          *cascade_args )
        end
      end

    end
    
  end
  
end
