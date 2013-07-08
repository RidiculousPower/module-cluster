# -*- encoding : utf-8 -*-

require_relative '../../../lib/module/cluster.rb'

require_relative '../../helpers/created.rb'

require_relative '../../support/named_class_and_module.rb'

describe ::Module::Cluster::Cluster do
  
  let( :cluster_instance ) { ::Module.new.name( :Instance ) }
  let( :cluster ) { ::Module::Cluster::Cluster.new( cluster_instance, :cluster_name ) }
  
  before :all do
    
    class MockFrameDefiner
      attr_reader :last_method_called, :last_args, :last_block
      def method_missing( method_name, *args, & block )
        @last_method_called = method_name
        @last_args = args
        @last_block = block
      end
    end

    class ::Module::Cluster::Cluster
      attr_reader :frame_definer
    end

  end
  
  context '========  Initialization  ========' do
    
    ###############
    #  instance   #
    ###############
  
    context '#instance' do
      let( :instance ) { cluster.instance }
      it 'is owned by an instance' do
        instance.should == cluster_instance
      end
    end
  
    ##########################
    #  instance_controller   #
    ##########################
  
    context '#instance_controller' do
      let( :instance_controller ) { cluster.instance_controller }
      it 'keeps a reference to its the controller for its instance' do
        instance_controller.should == ::Module::Cluster.instance_controller( cluster_instance )
      end
    end
  
    ##########
    #  name  #
    ##########
  
    context '#name' do
      let( :name ) { cluster.name }
      it 'has a name that uniquely describes it for the instance' do
        name.should == :cluster_name
      end
    end

  end
  
  context '========  Status  ========' do
  
    ##############
    #  enabled?  #
    ##############
  
    context '#enabled?' do
      let( :enabled? ) { cluster.enabled? }
      it 'can report whether it is enabled' do
        enabled?.should == true
      end
    end
  
    ###############
    #  disabled?  #
    ###############

    context '#disabled?' do
      let( :disabled? ) { cluster.disabled? }
      it 'can report whether it is disabled' do
        disabled?.should == false
      end
    end

    ################
    #  suspended?  #
    ################
  
    context '#suspended?' do
      it 'aliases disabled? with suspended?' do
        ::Module::Cluster::Cluster.instance_method( :suspended? ).should == ::Module::Cluster::Cluster.instance_method( :disabled? )
      end
    end
  
    #############
    #  disable  #
    #############

    context '#disable' do
      let( :disable ) { cluster.disable }
      it 'can be disabled' do
        disable.disabled?.should be true
      end
      it 'can disable for a block' do
        cluster.disabled?.should be false
        cluster.disable { cluster.disabled?.should be true }
        cluster.disabled?.should be false
      end
    end

    #############
    #  suspend  #
    #############
  
    context '#suspend' do
      it 'aliases disable with suspend' do
        ::Module::Cluster::Cluster.instance_method( :suspend ).should == ::Module::Cluster::Cluster.instance_method( :disable )
      end
    end

    ############
    #  enable  #
    ############
  
    context '#enable' do
      let( :enable ) { cluster.enable }
      it 'can be enabled' do
        enable.disabled?.should == false    
      end
      it 'can enable for a block' do
        cluster.disable
        cluster.enable { cluster.enabled?.should be true }
        cluster.enabled?.should be false
      end
    end
  
  end
  
  context '========  Relay Methods  ========' do
    
    let( :cluster_with_mock_definer ) do
      cluster = ::Module::Cluster::Cluster.new( cluster_instance, :cluster_name )
      cluster.instance_eval { @frame_definer = MockFrameDefiner.new }
      cluster.__send__( method, *args, & block )
      cluster
    end

    let( :args ) { [ :A, :B, :C ] }
    let( :block ) { ::Proc.new { puts 'block' } }
    
    ####################
    #  before_include  #
    ####################

    context '#before_include' do
      let( :method ) { :before_include }
      let( :before_include ) { cluster_with_mock_definer }
      it 'can create hook frames to be run prior to module being included' do
        before_include.should have_called_frame_definer( method, *args, & block )
      end
    end

    ###################
    #  after_include  #
    ###################

    context '#after_include' do
      let( :method ) { :after_include }
      let( :after_include ) { cluster_with_mock_definer }
      it 'can create hook frames to be run after module is included' do
        after_include.should have_called_frame_definer( method, *args, & block )
      end
    end

    ###################
    #  before_extend  #
    ###################

    context '#before_extend' do
      let( :method ) { :before_extend }
      let( :before_extend ) { cluster_with_mock_definer }
      it 'can create hook frames to be run prior to module being extended' do
        before_extend.should have_called_frame_definer( method, *args, & block )
      end
    end

    ##################
    #  after_extend  #
    ##################

    context '#after_extend' do
      let( :method ) { :after_extend }
      let( :after_extend ) { cluster_with_mock_definer }
      it 'can create hook frames to be run after module is extended' do
        after_extend.should have_called_frame_definer( method, *args, & block )
      end
    end

    ##############
    #  subclass  #
    ##############

    context '#subclass' do
      let( :method ) { :subclass }
      let( :args ) { [ ] }
      let( :subclass ) { cluster_with_mock_definer }
      it 'can create hook frames to be run when class is subclassed' do
        subclass.should have_called_frame_definer( method, *args, & block )
      end
    end

    #####################
    #  before_instance  #
    #####################

    context '#before_instance' do
      let( :method ) { :before_instance }
      let( :args ) { [ ] }
      let( :before_instance ) { cluster_with_mock_definer }
      it 'can add :before_instance to hook context to apply to hook frames defined next' do
        before_instance.should have_called_frame_definer( method, *args, & block )
      end
    end

    ####################
    #  after_instance  #
    ####################

    context '#after_instance' do
      let( :method ) { :after_instance }
      let( :args ) { [ ] }
      let( :after_instance ) { cluster_with_mock_definer }
      it 'can add :after_instance to hook context to apply to hook frames defined next' do
        after_instance.should have_called_frame_definer( method, *args, & block )
      end
    end

  end
    
end
