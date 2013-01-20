
require_relative '../setup.rb'

describe :ClassInheritingFromModuleCascadeIntegration do
  
  setup_integration_tests

  let( :clustered_instance ) do
    clustered_instance = ::Class.new( ::Module ).name( :CascadeEnabledClassInheritingFromModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    
    cluster.subclass.cascade_to( *cascade_contexts ).include( *include_modules ).
                                                     extend( *extend_modules ).
                                                     action( & block_action )
                                                     
    cluster.before_include.cascade_to( *cascade_contexts ).include( *include_modules ).
                                                           extend( *extend_modules ).
                                                           action( & block_action )
                                                           
    cluster.before_extend.cascade_to( *cascade_contexts ).include( *include_modules ).
                                                          extend( *extend_modules ).
                                                          action( & block_action )
                                                          
    cluster.after_include.cascade_to( *cascade_contexts ).include( *include_modules ).
                                                          extend( *extend_modules ).
                                                          action( & block_action )
                                                          
    cluster.after_extend.cascade_to( *cascade_contexts ).include( *include_modules ).
                                                         extend( *extend_modules ).
                                                         action( & block_action )
    clustered_instance
  end
  
  let( :subclass_of_class_inheriting_from_module ) { ::Class.new( clustered_instance ).name( :SubclassOfClassInheritingFromModule ) }
  let( :instance_of_class_inheriting_from_module ) { clustered_instance.new.name( :InstanceOfClassInheritingFromModule ) }

  let( :cascade_args ) { [ include_modules, extend_modules, block_state ] }
  
  context 'class => class' do

    context 'cascade to :any' do
      
      let( :cascade_contexts ) { [ :any ] }

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will cascade but not execute :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_instance, 
                                                                                        *cascade_args )
      end

    end

    context 'cascade to :module' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :class' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :each_subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end
    
    context 'cascade to :module, :class' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :module, :class, :subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :module, :class, :each_subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :module, :subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :module, :each_subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :class, :subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end

    context 'cascade to :class, :each_subclass' do

      it 'will cascade but not execute :before_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_include hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_include, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :before_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :before_extend, 
                                                                                        *cascade_args )
      end

      it 'will cascade but not execute :after_extend hooks' do
        subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                        :after_extend, 
                                                                                        *cascade_args )
      end

      it 'will execute and cascade :subclass hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_and_cascaded( clustered_instance, 
                                                                                    :subclass, 
                                                                                    *cascade_args )
      end

      it 'will execute and cascade :instance hooks' do
        subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
      end

    end
    
  end  
  
  context 'class => module (class.new)' do

    context 'cascade to :any' do
    end

    context 'cascade to :module' do
    end

    context 'cascade to :class' do
    end

    context 'cascade to :subclass' do
    end

    context 'cascade to :each_subclass' do
    end
    
    context 'cascade to :module, :class' do
    end

    context 'cascade to :module, :class, :subclass' do
    end

    context 'cascade to :module, :class, :each_subclass' do
    end

    context 'cascade to :module, :subclass' do
    end

    context 'cascade to :module, :each_subclass' do
    end

    context 'cascade to :class, :subclass' do
    end

    context 'cascade to :class, :each_subclass' do
    end

    it 'will cascade :before_include hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_include, 
                                                                                      *cascade_args )
    end

    it 'will cascade :after_include hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_include, 
                                                                                      *cascade_args )
    end

    it 'will cascade :before_extend hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_extend, 
                                                                                      *cascade_args )
    end

    it 'will cascade :after_extend hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_extend, 
                                                                                      *cascade_args )
    end

    it 'will cascade :subclass hooks' do
      instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                     :subclass, 
                                                                                     *cascade_args )
    end
    
    it 'will execute but not cascade :instance hooks' do
      instance_of_class_inheriting_from_module.should have_executed_but_not_cascaded( *class_integration_args )
    end
    
  end
  
end
