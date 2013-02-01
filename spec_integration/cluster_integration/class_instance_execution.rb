
shared_examples_for :ClassInstanceExecution do

  let( :clustered_instance ) do
    clustered_instance = ::Class.new.name( :InstanceExecutionEnabledClass ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name )
    cluster.__send__( event_cascade_context, & block_action ).include( *include_modules ).extend( *extend_modules )
    clustered_instance
  end

  let( :class_instance ) { ::Class.new( clustered_instance ).name( :ClassInstance ) }
  let( :integration_args ) { [ clustered_instance, event_cascade_context, include_modules, extend_modules, block_state ] }

  it 'will execute but not cascade' do
    class_instance.should have_cascaded_but_not_executed( *integration_args )
  end

  it 'will execute when an instance is created' do
    class_instance.new.should have_executed_but_not_cascaded( *integration_args )
  end

end
