
require_relative '../../lib/module/cluster.rb'

shared_examples_for :ModuleExecutionIntegration do
    
  let( :clustered_instance ) do
    clustered_instance = ::Module.new.name( :ExecutionEnabledModule ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    cluster.__send__( event_context ).include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  context 'for hooked module' do
    it 'will execute but not cascade' do
      module_instance.should have_executed_but_not_cascaded( *integration_args )
    end
  end

  context 'for hooked class' do
    it 'will execute but not cascade' do
      class_instance.should have_executed_but_not_cascaded( *integration_args )
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
