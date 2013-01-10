
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::Cluster do
  
  let( :instance ) { ::Module.new }
  let( :cluster ) { ::Module::Cluster::Cluster.new( instance, :cluster_name ) }

  context '========  Initialization  ========' do
    
    ###############
    #  instance   #
    ###############
  
    context '#instance' do
      it 'is owned by an instance' do
        cluster.instance.should == instance
      end
    end
  
    ##########################
    #  instance_controller   #
    ##########################
  
    context '#instance_controller' do
      it 'keeps a reference to its the controller for its instance' do
        cluster.instance_controller.should == ::Module::Cluster.instance_controller( instance )
      end
    end
  
    ##########
    #  name  #
    ##########
  
    context '#name' do
      it 'has a name that uniquely describes it for the instance' do
        cluster.name.should == :cluster_name
      end
    end

  end
  
  context '========  Status  ========' do
  
    ###############
    #  enabled?   #
    ###############
  
    context '#enabled?' do
      it 'can report whether it is enabled' do
        cluster.enabled?.should == true
      end
    end
  
    ################
    #  disabled?   #
    ################

    context '#disabled?' do
      it 'can report whether it is disabled' do
        cluster.disabled?.should == false
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
      it 'can be disabled' do
        cluster.disable
        cluster.disabled?.should == true
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
      it 'can be enabled' do
        cluster.enable
        cluster.disabled?.should == false    
      end
    end
  
  end
  
  context '========  Relay Methods  ========' do
  
    RSpec::Matchers.define :have_called_frame_definer do |method, *args, & block|
      match do |cluster|
        fail_string = nil
        cluster.__send__( method, *args, & block )
        frame_definer = cluster.frame_definer
        unless fail_string or matched = frame_definer.last_method_called.should == method
          fail_string = 'last method called was #' << frame_definer.last_method_called.to_s + 
                        ' but expected :' << method.to_s + '.'
        end
        unless fail_string or matched = frame_definer.last_args.should == args
          fail_string = 'last method args were #' << frame_definer.last_args.to_s + 
                        ' but expected :' << args.to_s + '.'
        end
        unless fail_string or frame_definer.last_block.should == block
          fail_string = 'last method block was #' << frame_definer.last_block.to_s + 
                        ' but expected :' << block.to_s + '.'
        end
        matched
      end
      failure_message_for_should { fail_string }
    end
  
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
    
    let( :cluster ) do
      cluster = ::Module::Cluster::Cluster.new( instance, :cluster_name )
      cluster.instance_eval { @frame_definer = MockFrameDefiner.new }
      cluster
    end

    let( :args ) { [ :A, :B, :C ] }
    let( :block ) { ::Proc.new { puts 'block' } }
    
    #############
    #  context  #
    #############

    context '#context' do
      let( :method ) { :context }
      it 'can create hook frames for a given instance context' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    #############
    #  cascade  #
    #############
  
    context '#cascade' do
      let( :method ) { :cascade }
      let( :args ) { [ ] }
      it 'can cause hook frames to cascade' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ################
    #  cascade_to  #
    ################
  
    context '#cascade_to' do
      let( :method ) { :cascade_to }
      it 'can cause hook frames to cascade to a given context' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ####################
    #  before_include  #
    ####################

    context '#before_include' do
      let( :method ) { :before_include }
      it 'can create hook frames to be run prior to module being included' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ###################
    #  after_include  #
    ###################

    context '#after_include' do
      let( :method ) { :after_include }
      it 'can create hook frames to be run after module is included' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ###################
    #  before_extend  #
    ###################

    context '#before_extend' do
      let( :method ) { :before_extend }
      it 'can create hook frames to be run prior to module being extended' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ##################
    #  after_extend  #
    ##################

    context '#after_extend' do
      let( :method ) { :after_extend }
      it 'can create hook frames to be run after module is extended' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

    ##############
    #  subclass  #
    ##############

    context '#subclass' do
      let( :method ) { :subclass }
      let( :args ) { [ ] }
      it 'can create hook frames to be run when class is subclassed' do
        cluster.should have_called_frame_definer( method, *args, & block )
      end
    end

  end
    
end
