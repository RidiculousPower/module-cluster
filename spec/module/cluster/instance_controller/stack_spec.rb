
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController::Stack do

  before :all do
    MockFrame = ::Struct.new( :modules )
  end

  before :each do
    @a = MockFrame.new( [ :A ] )
    @b = MockFrame.new( [ :B ] )
    @c = MockFrame.new( [ :C ] )
    @stack = ::Module::Cluster::InstanceController::Stack.new( [ @a, @b, @c ] )
  end
  
  it 'is an array' do
    @stack.is_a?( ::Array ).should == true
  end

  #############################
  #  insert_before_and_after  #
  #############################

  it 'can insert modules before other modules' do
    @stack.insert_before_and_after( [ :B, :C ], [ ], :A1 )
    @stack.should == [ @a, :A1, @b, @c ]
  end
  
  it 'can insert modules after other modules' do
    @stack.insert_before_and_after( [ ], [ :A, :B ], :A1 )
    @stack.should == [ @a, @b, :A1, @c ]
  end
  
  it 'can insert modules before and after other modules' do
    @stack.insert_before_and_after( [ :B, :C ], [ :A ], :A1 )
    @stack.should == [ @a, :A1, @b, @c ]
  end
  
  it 'will raise an exception if before/after are not compatible' do
    ::Proc.new { @stack.insert_before_and_after( [ :B, :C ], [ :A, :B ], :A1 ) }.should raise_error( ::ArgumentError )
  end

end
