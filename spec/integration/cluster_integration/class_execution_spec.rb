
shared_examples_for :ClassExecutionIntegration do

  let( :clustered_instance ) do
    clustered_instance = ::Class.new.name( :ExecutionEnabledClass ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name ).subclass
    cluster.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end
  
  let( :first_subclass ) { ::Class.new( clustered_instance ).name( :FirstSubclass ) }
  
  context 'class => subclass' do
    let( :first_subclass ) { ::Class.new( clustered_instance ).name( :FirstSubclass ) }
    it 'will execute for the first subclass but not cascade' do
      first_subclass.should have_executed_but_not_cascaded( *integration_args )
    end
  end
  
end
