
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController do

  let( :instance ) { ::Module.new }
  let( :instance_controller ) { ::Module::Cluster::InstanceController.new( instance ) }
  let( :cluster_name ) { :cluster_name }
  let( :cluster ) { instance_controller.cluster( cluster_name ) }

  context '========  Initialization  =======' do

    ##############
    #  instance  #
    ##############
  
    context '#instance' do
      it 'has an instance' do
        cluster.instance.should == instance
      end
    end
  
    #############
    #  cluster  #
    #############
  
    context '#cluster' do
      it 'has clusters' do
        cluster.should == instance_controller.cluster( :cluster_name )
      end
    end

    ##################
    #  has_cluster?  #
    ##################
  
    context '#has_cluster?' do
      let( :instance_controller_with_cluster ) { cluster ; instance_controller }
      it 'can report if it has a cluster' do
        instance_controller_with_cluster.has_cluster?( :cluster_name ).should == true
      end
    end
  
  end
  
  context '========  Stacks  =======' do

    RSpec::Matchers.define :be_a_stack do
      match { |actual| actual.is_a?( ::Module::Cluster::InstanceController::Stack ) }
      failure_message_for_should { "expected stack to be a #{::Module::Cluster::InstanceController::Stack}" }
    end

    ####################
    #  subclass_stack  #
    ####################
  
    context '#subclass_stack' do
      it 'has a subclass stack' do
        instance_controller.subclass_stack.should be_a_stack
      end
    end
  
    ##########################
    #  before_include_stack  #
    ##########################
  
    context '#before_include_stack' do
      it 'has a before-include stack' do
        instance_controller.before_include_stack.should be_a_stack
      end
    end

    #########################
    #  before_extend_stack  #
    #########################

    context '#before_extend_stack' do
      it 'has a before-extend stack' do
        instance_controller.before_extend_stack.should be_a_stack
      end
    end

    #########################
    #  after_include_stack  #
    #########################
  
    context '#after_include_stack' do
      it 'has an after-include stack' do
        instance_controller.after_include_stack.should be_a_stack
      end
    end

    ########################
    #  after_extend_stack  #
    ########################

    context '#after_extend_stack' do
      it 'has an after-extend stack' do
        instance_controller.after_extend_stack.should be_a_stack
      end
    end
  
    ###########
    #  stack  #
    ###########
  
    context '#stack' do
      it 'can return a stack for an event context: :subclass' do
        instance_controller.stack( :subclass ).should == instance_controller.subclass_stack
      end

      it 'can return a stack for an event context: :before_include' do
        instance_controller.stack( :before_include ).should == instance_controller.before_include_stack
      end

      it 'can return a stack for an event context: :before_extend' do
        instance_controller.stack( :before_extend ).should == instance_controller.before_extend_stack
      end

      it 'can return a stack for an event context: :after_include' do
        instance_controller.stack( :after_include ).should == instance_controller.after_include_stack
      end
  
      it 'can return a stack for an event context: :after_extend' do
        instance_controller.stack( :after_extend ).should == instance_controller.after_extend_stack
      end
    end

    #########################
    #  has_subclass_stack?  #
    #########################
  
    context '#has_subclass_stack?' do
      it 'can report if it has a subclass stack' do
        instance_controller.has_subclass_stack?.should == false
        instance_controller.subclass_stack
        instance_controller.has_subclass_stack?.should == true
      end
    end
  
    ###############################
    #  has_before_include_stack?  #
    ###############################
  
    context '#has_before_include_stack?' do
      it 'can report if it has a before-include stack' do
        instance_controller.has_before_include_stack?.should == false
        instance_controller.before_include_stack
        instance_controller.has_before_include_stack?.should == true
      end
    end

    ##############################
    #  has_before_extend_stack?  #
    ##############################

    context '#has_before_extend_stack?' do
      it 'can report if it has a before-extend stack' do
        instance_controller.has_before_extend_stack?.should == false
        instance_controller.before_extend_stack
        instance_controller.has_before_extend_stack?.should == true
      end
    end

    ##############################
    #  has_after_include_stack?  #
    ##############################
  
    context '#has_after_include_stack?' do
      it 'can report if it has an after-include stack' do
        instance_controller.has_after_include_stack?.should == false
        instance_controller.after_include_stack
        instance_controller.has_after_include_stack?.should == true
      end
    end

    #############################
    #  has_after_extend_stack?  #
    #############################

    context '#has_after_extend_stack?' do
      it 'can report if it has an after-extend stack' do
        instance_controller.has_after_extend_stack?.should == false
        instance_controller.after_extend_stack
        instance_controller.has_after_extend_stack?.should == true
      end
    end
  
  end
  
end
