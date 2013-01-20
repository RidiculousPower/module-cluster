
require_relative '../setup.rb'

describe :ClassInheritingFromModuleExecutionIntegration do
  
  setup_integration_tests
  
  let( :clustered_instance ) do
    clustered_instance = ::Class.new( ::Module ).name( :CascadeEnabledClassInheritingFromModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    cluster.subclass.include( *subclass_include_modules ).
                     extend( *subclass_extend_modules ).
                     action( & subclass_block_action )
    cluster.before_initialize.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_initialize.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.before_instance.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_instance.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.before_include.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.before_extend.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_include.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    cluster.after_extend.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  let( :subclass_of_class_inheriting_from_module ) { ::Class.new( clustered_instance ).name( :SubclassOfClassInheritingFromModule ) }
  let( :instance_of_class_inheriting_from_module ) { clustered_instance.new.name( :InstanceOfClassInheritingFromModule ) }

  let( :cascade_args ) { [ include_modules, extend_modules, block_state ] }

  context 'class => class' do

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
    
    it 'will execute but not cascade :subclass hooks' do
      subclass_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                      :subclass, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :before_instance hooks' do
      subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_instance, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :after_instance hooks' do
      subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_instance, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :before_initialize hooks' do
      subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_initialize, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :after_initialize hooks' do
      subclass_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_initialize, 
                                                                                      *cascade_args )
    end
    
  end

  context 'class => module (class.new)' do

    it 'will cascade but not execute :before_include hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_include, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :after_include hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_include, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :before_extend hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :before_extend, 
                                                                                      *cascade_args )
    end

    it 'will cascade but not execute :after_extend hooks' do
      instance_of_class_inheriting_from_module.should have_cascaded_but_not_executed( clustered_instance, 
                                                                                      :after_extend, 
                                                                                      *cascade_args )
    end

    it 'will not cascade or execute :subclass hooks' do
      instance_of_class_inheriting_from_module.should not_have_executed_or_cascaded( clustered_instance, 
                                                                                     :subclass, 
                                                                                     *cascade_args )
    end
  
    it 'will execute but not cascade :before_instance hooks' do
      instance_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                      :before_instance, 
                                                                                      *cascade_args )
    end

    it 'will execute but not cascade :after_instance hooks' do
      instance_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                      :after_instance, 
                                                                                      *cascade_args )
    end

    it 'will execute but not cascade :before_initialize hooks' do
      instance_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                      :before_initialize, 
                                                                                      *cascade_args )
    end

    it 'will execute but not cascade :after_initialize hooks' do
      instance_of_class_inheriting_from_module.should have_executed_but_not_cascaded( clustered_instance, 
                                                                                      :after_initialize, 
                                                                                      *cascade_args )
    end
    
  end
  
end
