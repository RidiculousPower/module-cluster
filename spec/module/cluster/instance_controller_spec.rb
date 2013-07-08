# -*- encoding : utf-8 -*-

require_relative '../../../lib/module/cluster.rb'

require_relative '../../support/named_class_and_module.rb'

require_relative '../../helpers/support.rb'

describe ::Module::Cluster::InstanceController do

  let( :cluster_instance ) { ::Module.new.name( :Instance ) }
  let( :instance_controller ) { ::Module::Cluster::InstanceController.new( cluster_instance ) }
  let( :cluster_name ) { :cluster_name }
  let( :cluster ) { instance_controller.cluster( cluster_name ) }

  context '========  Initialization  =======' do

    ##############
    #  instance  #
    ##############
  
    context '#instance' do
      let( :instance ) { cluster.instance }
      it 'has an instance' do
        instance.should == cluster_instance
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
      let( :has_cluster? ) { cluster ; instance_controller.has_cluster?( cluster_name ) }
      it 'can report if it has a cluster' do
        has_cluster?.should == true
      end
    end
  
  end
  
  context '========  Stacks  =======' do

    ####################
    #  subclass_stack  #
    ####################
  
    context '#subclass_stack' do
      let( :subclass_stack ) { instance_controller.subclass_stack }
      it 'has a subclass stack' do
        subclass_stack.should be_a_stack
      end
    end
  
    ##########################
    #  before_include_stack  #
    ##########################
  
    context '#before_include_stack' do
      let( :before_include_stack ) { instance_controller.before_include_stack }
      it 'has a before-include stack' do
        before_include_stack.should be_a_stack
      end
    end

    #########################
    #  before_extend_stack  #
    #########################

    context '#before_extend_stack' do
      let( :before_extend_stack ) { instance_controller.before_extend_stack }
      it 'has a before-extend stack' do
        before_extend_stack.should be_a_stack
      end
    end

    #########################
    #  after_include_stack  #
    #########################
  
    context '#after_include_stack' do
      let( :after_include_stack ) { instance_controller.after_include_stack }
      it 'has an after-include stack' do
        after_include_stack.should be_a_stack
      end
    end

    ########################
    #  after_extend_stack  #
    ########################

    context '#after_extend_stack' do
      let( :after_extend_stack ) { instance_controller.after_extend_stack }
      it 'has an after-extend stack' do
        after_extend_stack.should be_a_stack
      end
    end
  
    ##########################
    #  after_instance_stack  #
    ##########################

    context '#after_instance_stack' do
      let( :after_instance_stack ) { instance_controller.after_instance_stack }
      it 'has a after-instance stack' do
        after_instance_stack.should be_a_stack
      end
    end
  
    ###########
    #  stack  #
    ###########
  
    context '#stack' do

      let( :stack ) { instance_controller.stack( event_context ) }

      context ':subclass' do
        let( :event_context ) { :subclass }
        it 'can return a stack for an event context: :subclass' do
          stack.should == instance_controller.subclass_stack
        end
      end

      context ':before_include' do
        let( :event_context ) { :before_include }
        it 'can return a stack for an event context: :before_include' do
          stack.should == instance_controller.before_include_stack
        end
      end

      context ':before_extend' do
        let( :event_context ) { :before_extend }
        it 'can return a stack for an event context: :before_extend' do
          stack.should == instance_controller.before_extend_stack
        end
      end

      context ':after_include' do
        let( :event_context ) { :after_include }
        it 'can return a stack for an event context: :after_include' do
          stack.should == instance_controller.after_include_stack
        end
      end

      context ':after_extend' do
        let( :event_context ) { :after_extend }
        it 'can return a stack for an event context: :after_extend' do
          stack.should == instance_controller.after_extend_stack
        end
      end

      context ':before_instance' do
        let( :event_context ) { :before_instance }
        it 'can return a stack for an event context: :before_instance' do
          stack.should == instance_controller.before_instance_stack
        end
      end

      context ':after_instance' do
        let( :event_context ) { :after_instance }
        it 'can return a stack for an event context: :after_instance' do
          stack.should == instance_controller.after_instance_stack
        end
      end

    end

    #########################
    #  has_subclass_stack?  #
    #########################
  
    context '#has_subclass_stack?' do
      let( :has_subclass_stack? ) do
        instance_controller.subclass_stack
        instance_controller.has_subclass_stack?
      end
      it 'can report if it has a subclass stack' do
        has_subclass_stack?.should == true
      end
    end
  
    ###############################
    #  has_before_include_stack?  #
    ###############################
  
    context '#has_before_include_stack?' do
      let( :has_before_include_stack? ) do
        instance_controller.before_include_stack
        instance_controller.has_before_include_stack?
      end
      it 'can report if it has a before-include stack' do
        has_before_include_stack?.should == true
      end
    end

    ##############################
    #  has_before_extend_stack?  #
    ##############################

    context '#has_before_extend_stack?' do
      let( :has_before_extend_stack? ) do
        instance_controller.before_extend_stack
        instance_controller.has_before_extend_stack?
      end
      it 'can report if it has a before-extend stack' do
        has_before_extend_stack?.should == true
      end
    end

    ##############################
    #  has_after_include_stack?  #
    ##############################
  
    context '#has_after_include_stack?' do
      let( :has_after_include_stack? ) do
        instance_controller.after_include_stack 
        instance_controller.has_after_include_stack?
      end
      it 'can report if it has an after-include stack' do
        has_after_include_stack?.should == true
      end
    end

    #############################
    #  has_after_extend_stack?  #
    #############################

    context '#has_after_extend_stack?' do
      let( :has_after_extend_stack? ) do
        instance_controller.after_extend_stack
        instance_controller.has_after_extend_stack?
      end
      it 'can report if it has an after-extend stack' do
        has_after_extend_stack?.should == true
      end
    end

    ###############################
    #  has_after_instance_stack?  #
    ###############################

    context '#has_after_instance_stack?' do
      let( :has_after_instance_stack? ) do
        instance_controller.after_instance_stack
        instance_controller.has_after_instance_stack?
      end
      it 'can report if it has an after-instance stack' do
        has_after_instance_stack?.should == true
      end
    end
  
  end
  
end
