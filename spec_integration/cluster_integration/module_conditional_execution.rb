# -*- encoding : utf-8 -*-

shared_examples_for :ModuleConditionalExecutionIntegration do
  
  let( :clustered_instance ) do
    clustered_instance = ::Module.new.name( :ConditionalExecutionEnabledModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name ).__send__( event_context, *execution_contexts )
    cluster.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  context ':module' do
    
    let( :execution_contexts ) { [ :module ] }
    
    context 'for hooked module' do
      it 'will execute but not cascade' do
        module_instance.should have_executed_but_not_cascaded( *integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute or cascade' do
        class_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end
  
  context ':class' do

    let( :execution_contexts ) { [ :class ] }

    context 'for hooked module' do
      it 'will not execute or cascade' do
        module_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

    context 'for hooked class' do
      it 'will execute but not cascade' do
        class_instance.should have_executed_but_not_cascaded( *integration_args )
      end
    end

    context 'for hooked instance' do
      it 'will not execute or cascade' do
        object_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

  end

  context ':instance' do

    let( :execution_contexts ) { [ :instance ] }

    context 'for hooked module' do
      it 'will not execute or cascade' do
        module_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

    context 'for hooked class' do
      it 'will not execute or cascade' do
        class_instance.should not_have_executed_or_cascaded( *integration_args )
      end
    end

    context 'for hooked instance' do
      let( :event_context ) { :before_extend }
      it 'will execute but not cascade' do
        object_instance.should have_executed_but_not_cascaded( *integration_args )
      end
    end

  end

end
