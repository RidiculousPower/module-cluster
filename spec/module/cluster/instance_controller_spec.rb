
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController do

  before :each do
    @instance = ::Module.new
    @instance_controller = ::Module::Cluster::InstanceController.new( @instance )
    @cluster = @instance_controller.cluster( :cluster_name )
  end

  ##############
  #  instance  #
  ##############
  
  it 'has an instance' do
    @cluster.instance.should == @instance
  end
  
  #############
  #  cluster  #
  #############
  
  it 'has clusters' do
    @instance_controller.cluster( :cluster_name ).should == @cluster
  end

  ##################
  #  has_cluster?  #
  ##################
  
  it 'can report if it has a cluster' do
    @instance_controller.has_cluster?( :cluster_name ).should == true
  end

  ####################
  #  subclass_stack  #
  ####################
  
  it 'has a subclass stack' do
    @instance_controller.subclass_stack.is_a?( ::Module::Cluster::InstanceController::Stack ).should == true
  end
  
  ##########################
  #  before_include_stack  #
  ##########################
  
  it 'has a before-include stack' do
    @instance_controller.before_include_stack.is_a?( ::Module::Cluster::InstanceController::Stack ).should == true
  end

  #########################
  #  before_extend_stack  #
  #########################

  it 'has a before-extend stack' do
    @instance_controller.before_extend_stack.is_a?( ::Module::Cluster::InstanceController::Stack ).should == true
  end

  #########################
  #  after_include_stack  #
  #########################
  
  it 'has an after-include stack' do
    @instance_controller.after_include_stack.is_a?( ::Module::Cluster::InstanceController::Stack ).should == true
  end

  ########################
  #  after_extend_stack  #
  ########################

  it 'has an after-extend stack' do
    @instance_controller.after_extend_stack.is_a?( ::Module::Cluster::InstanceController::Stack ).should == true
  end
  
  ###########
  #  stack  #
  ###########
  
  it 'can return a stack for an event context: :subclass' do
    @instance_controller.stack( :subclass ).should == @instance_controller.subclass_stack
  end

  it 'can return a stack for an event context: :before_include' do
    @instance_controller.stack( :before_include ).should == @instance_controller.before_include_stack
  end

  it 'can return a stack for an event context: :before_extend' do
    @instance_controller.stack( :before_extend ).should == @instance_controller.before_extend_stack
  end

  it 'can return a stack for an event context: :after_include' do
    @instance_controller.stack( :after_include ).should == @instance_controller.after_include_stack
  end
  
  it 'can return a stack for an event context: :after_extend' do
    @instance_controller.stack( :after_extend ).should == @instance_controller.after_extend_stack
  end

  #########################
  #  has_subclass_stack?  #
  #########################
  
  it 'can report if it has a subclass stack' do
    @instance_controller.has_subclass_stack?.should == false
    @instance_controller.subclass_stack
    @instance_controller.has_subclass_stack?.should == true
  end
  
  ###############################
  #  has_before_include_stack?  #
  ###############################
  
  it 'can report if it has a before-include stack' do
    @instance_controller.has_before_include_stack?.should == false
    @instance_controller.before_include_stack
    @instance_controller.has_before_include_stack?.should == true
  end

  ##############################
  #  has_before_extend_stack?  #
  ##############################

  it 'can report if it has a before-extend stack' do
    @instance_controller.has_before_extend_stack?.should == false
    @instance_controller.before_extend_stack
    @instance_controller.has_before_extend_stack?.should == true
  end

  ##############################
  #  has_after_include_stack?  #
  ##############################
  
  it 'can report if it has an after-include stack' do
    @instance_controller.has_after_include_stack?.should == false
    @instance_controller.after_include_stack
    @instance_controller.has_after_include_stack?.should == true
  end

  #############################
  #  has_after_extend_stack?  #
  #############################

  it 'can report if it has an after-extend stack' do
    @instance_controller.has_after_extend_stack?.should == false
    @instance_controller.after_extend_stack
    @instance_controller.has_after_extend_stack?.should == true
  end
  
end
