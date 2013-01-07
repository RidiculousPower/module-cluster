
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::Cluster do
  
  let( :instance ) { ::Module.new }
  let( :cluster ) { ::Module::Cluster::Cluster.new( instance, :cluster_name ) }

  ###############
  #  instance   #
  ###############
  
  it 'is owned by an instance' do
    cluster.instance.should == instance
  end
  
  ##########################
  #  instance_controller   #
  ##########################
  
  it 'keeps a reference to its the controller for its instance' do
    cluster.instance_controller.should == ::Module::Cluster.instance_controller( instance )
  end
  
  ##########
  #  name  #
  ##########
  
  it 'has a name that uniquely describes it for the instance' do
    cluster.name.should == :cluster_name
  end

  ###############
  #  enabled?   #
  ###############
  
  it 'can report whether it is enabled' do
    cluster.enabled?.should == true
  end
  
  ################
  #  disabled?   #
  ################

  it 'can report whether it is disabled' do
    cluster.disabled?.should == false
  end

  ################
  #  suspended?  #
  ################
  
  it 'aliases disabled? with suspended?' do
    ::Module::Cluster::Cluster.instance_method( :suspended? ).should == ::Module::Cluster::Cluster.instance_method( :disabled? )
  end
  
  #############
  #  disable  #
  #############

  it 'can be disabled' do
    cluster.disable
    cluster.disabled?.should == true
  end

  #############
  #  suspend  #
  #############
  
  it 'aliases disable with suspend' do
    ::Module::Cluster::Cluster.instance_method( :suspend ).should == ::Module::Cluster::Cluster.instance_method( :disable )
  end

  ############
  #  enable  #
  ############
  
  it 'can be enabled' do
    cluster.enable
    cluster.disabled?.should == false    
  end
  
  #############
  #  context  #
  #############

  it 'can create hook frames for a given instance context' do
    cluster.context( :module, :class ).should == cluster
    cluster.instance_contexts.should == { :module => true, :class => true }
  end

  #############
  #  cascade  #
  #############
  
  it 'can cause hook frames to cascade' do
    cluster.cascade.should == cluster
    cluster.cascade_contexts.should == { :any => true }
  end

  ################
  #  cascade_to  #
  ################
  
  it 'can cause hook frames to cascade to a given context' do
    cluster.cascade_to( :module, :class ).should == cluster
    cluster.cascade_contexts.should == { :module => true, :class => true }
  end

  context 'event hooks' do
    
    def hooks_verify?( return_value, event_context )
      return_value.is_a?( ::Module::Cluster::Cluster::FrameDefiner ).should == true
      cluster.hook_contexts.has_key?( event_context ).should == true
      if contexts
        contexts.each do |this_context|
          cluster.instance_contexts.has_key?( this_context ).should == true
        end
      end
      if block
        cluster.instance_controller.stack( event_context ).select do |this_frame|
          this_frame.block_action
        end.count.should == 1
      end
    end
    
    context 'when no context or block' do
      
      let( :contexts ) { nil }
      let( :block ) { nil }
      
      ####################
      #  before_include  #
      ####################
  
      it 'can create hook frames to be run prior to module being included' do
        hooks_verify?( cluster.before_include, :before_include )
      end
  
      ###################
      #  after_include  #
      ###################
  
      it 'can create hook frames to be run after module is included' do
        hooks_verify?( cluster.after_include, :after_include )
      end
  
      ###################
      #  before_extend  #
      ###################
  
      it 'can create hook frames to be run prior to module being extended' do
        hooks_verify?( cluster.before_extend, :before_extend )
      end
  
      ##################
      #  after_extend  #
      ##################
  
      it 'can create hook frames to be run after module is extended' do
        hooks_verify?( cluster.after_extend, :after_extend )
      end
  
      ##############
      #  subclass  #
      ##############
  
      it 'can create hook frames to be run when class is subclassed' do
        hooks_verify?( cluster.subclass, :subclass )
      end
  
    end

    context 'when context, no block' do
      
      let( :contexts ) { nil }
      let( :block ) { nil }
      
      ####################
      #  before_include  #
      ####################
  
      it 'can create hook frames to be run prior to module being included' do
        hooks_verify?( cluster.before_include, :before_include )
      end
  
      ###################
      #  after_include  #
      ###################
  
      it 'can create hook frames to be run after module is included' do
        hooks_verify?( cluster.after_include, :after_include )
      end
  
      ###################
      #  before_extend  #
      ###################
  
      it 'can create hook frames to be run prior to module being extended' do
        hooks_verify?( cluster.before_extend, :before_extend )
      end
  
      ##################
      #  after_extend  #
      ##################
  
      it 'can create hook frames to be run after module is extended' do
        hooks_verify?( cluster.after_extend, :after_extend )
      end
  
      ##############
      #  subclass  #
      ##############
  
      it 'can create hook frames to be run when class is subclassed' do
        hooks_verify?( cluster.subclass, :subclass )
      end

    end

    context 'when no context, block' do
      
      let( :contexts ) { nil }
      let( :block ) { nil }
      
      ####################
      #  before_include  #
      ####################
  
      it 'can create hook frames to be run prior to module being included' do
        hooks_verify?( cluster.before_include, :before_include )
      end
  
      ###################
      #  after_include  #
      ###################
  
      it 'can create hook frames to be run after module is included' do
        hooks_verify?( cluster.after_include, :after_include )
      end
  
      ###################
      #  before_extend  #
      ###################
  
      it 'can create hook frames to be run prior to module being extended' do
        hooks_verify?( cluster.before_extend, :before_extend )
      end
  
      ##################
      #  after_extend  #
      ##################
  
      it 'can create hook frames to be run after module is extended' do
        hooks_verify?( cluster.after_extend, :after_extend )
      end
  
      ##############
      #  subclass  #
      ##############
  
      it 'can create hook frames to be run when class is subclassed' do
        hooks_verify?( cluster.subclass, :subclass )
      end

    end

    context 'when context and block' do

      let( :contexts ) { nil }
      let( :block ) { nil }
      
      ####################
      #  before_include  #
      ####################
  
      it 'can create hook frames to be run prior to module being included' do
        hooks_verify?( cluster.before_include, :before_include )
      end
  
      ###################
      #  after_include  #
      ###################
  
      it 'can create hook frames to be run after module is included' do
        hooks_verify?( cluster.after_include, :after_include )
      end
  
      ###################
      #  before_extend  #
      ###################
  
      it 'can create hook frames to be run prior to module being extended' do
        hooks_verify?( cluster.before_extend, :before_extend )
      end
  
      ##################
      #  after_extend  #
      ##################
  
      it 'can create hook frames to be run after module is extended' do
        hooks_verify?( cluster.after_extend, :after_extend )
      end
  
      ##############
      #  subclass  #
      ##############
  
      it 'can create hook frames to be run when class is subclassed' do
        hooks_verify?( cluster.subclass, :subclass )
      end

    end

  end
  
  ###########
  #  clear  #
  ###########
  
  it '' do
    
  end
  
  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################
  
  ######################
  #  add_hook_context  #
  ######################
  
  it '' do
    
  end
  
  ##########################
  #  add_instance_context  #
  ##########################
  
  it '' do
    
  end

  #########################
  #  add_cascade_context  #
  #########################
  
  it '' do
    
  end
  
end
