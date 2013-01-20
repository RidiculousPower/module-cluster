
shared_examples_for :ClassCascadeIntegration do

  let( :clustered_instance ) do
    clustered_instance = ::Class.new.name( :CascadeEnabledClass ).extend( ::Module::Cluster )
    cluster = clustered_instance.cluster( cluster_name ).subclass.cascade_to( *cascade_contexts )
    cluster.include( *include_modules ).extend( *extend_modules ).action( & block_action )
    clustered_instance
  end

  let( :first_subclass ) { ::Class.new( clustered_instance ).name( :FirstSubclass ) }

  context 'to :any' do
    let( :cascade_contexts ) { [ :any ] }
    it 'will execute for the first subclass and cascade the block only (since include/extend cascade implicitly)' do
      first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
    end
  end

  context 'to :subclass' do
    let( :cascade_contexts ) { [ :subclass ] }
    it 'will execute for the first subclass and cascade the block only (since include/extend cascade implicitly)' do
      first_subclass.should have_executed_and_cascaded_block_only( *class_integration_args )
    end
  end

  context 'to :each_subclass' do
    let( :cascade_contexts ) { [ :each_subclass ] }
    it 'will execute for the first subclass and cascade (if explicit include/extend cascading is desired)' do
      first_subclass.should have_executed_and_cascaded( *class_integration_args )
    end
    it 'will execute for the nth subclass and cascade (if explicit include/extend cascading is desired)' do
      first_subclass.should have_executed_and_cascaded( *class_integration_args )
    end
  end
  
end
