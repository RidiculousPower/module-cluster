
require_relative '../../../lib/module/cluster.rb'

describe ::Module::Cluster::Cluster do
  
  ################
  #  initialize  #
  #  name        #
  ################
  
  it 'can be created to maintain hooks in a common stack by separate named clusters' do
    module ::Module::Cluster::Cluster::InitializeMock
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      cluster_instance.instance.should == Instance
      cluster_instance.name.should == :some_cluster
    end
  end
  
  ####################
  #  before_include  #
  ####################
  
  it 'can create before-include hooks' do
    module ::Module::Cluster::Cluster::BeforeIncludeMock
            
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.before_include( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_hook_controller.name.should == :before_include
      proxy.contexts.should == [ :class, :module ]
      proxy.cascades_to.should == [ :class ]
      
      hook_controller = proxy.parent_hook_controller
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == Instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].context.should == [ :class, :module ]
      hook_controller.stack[ 0 ].cascades.should == [ :class ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end

  ###################
  #  after_include  #
  ###################
  
  it 'can create after-include hooks' do
    module ::Module::Cluster::Cluster::AfterIncludeMock

      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.after_include( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_hook_controller.name.should == :after_include
      proxy.contexts.should == [ :class, :module ]
      hook_controller = proxy.parent_hook_controller
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == Instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].context.should == [ :class, :module ]
      hook_controller.stack[ 0 ].cascades.should == [ :class ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end
  
  ###################
  #  before_extend  #
  ###################
  
  it 'can create before-extend hooks' do
    module ::Module::Cluster::Cluster::BeforeExtendMock

      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      proxy = cluster_instance.before_extend( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_hook_controller.name.should == :before_extend
      proxy.contexts.should == [ :class, :module ]
      hook_controller = proxy.parent_hook_controller
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == Instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].context.should == [ :class, :module ]
      hook_controller.stack[ 0 ].cascades.should == [ :class ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end
  
  ##################
  #  after_extend  #
  ##################
  
  it 'can create after-extend hooks' do
    module ::Module::Cluster::Cluster::AfterExtendMock
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      proxy = cluster_instance.after_extend( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_hook_controller.name.should == :after_extend
      proxy.contexts.should == [ :class, :module ]
      hook_controller = proxy.parent_hook_controller
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == Instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].context.should == [ :class, :module ]
      hook_controller.stack[ 0 ].cascades.should == [ :class ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end
  
  ##############
  #  subclass  #
  ##############
  
  it 'can create subclass hooks' do
    module ::Module::Cluster::Cluster::SubclassMock
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :some_cluster )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      proxy = cluster_instance.subclass( & block_instance )
      
      proxy.parent_hook_controller.name.should == :subclass
      proxy.contexts.should == [ ]
      hook_controller = proxy.parent_hook_controller
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == Instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].context.should == [ ]
      hook_controller.stack[ 0 ].cascades.should == [ ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end
  
  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  it 'can create before-include-or-extend hooks' do
    module ::Module::Cluster::Cluster::BeforeIncludeExtendMock
      
      ::Module::Cluster::Cluster.instance_method( :before_include_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :before_extend_or_include )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :before_include_extend )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.before_include_or_extend( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :before_include_extend

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  it 'can create after-include-or-extend hooks' do
    module ::Module::Cluster::Cluster::AfterIncludeExtendMock
      
      ::Module::Cluster::Cluster.instance_method( :after_include_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :after_extend_or_include )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :after_include_extend )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.after_include_or_extend( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :after_include_extend

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end
  
  ################################
  #  before_include_or_subclass  #
  #  before_subclass_or_include  #
  ################################
  
  it 'can create before-include-or-subclass hooks' do
    module ::Module::Cluster::Cluster::BeforeIncludeSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :before_include_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :before_subclass_or_include )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :before_include_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.before_include_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :before_include_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end

  ###############################
  #  after_include_or_subclass  #
  #  after_subclass_or_include  #
  ###############################
  
  it 'can create after-include-or-subclass hooks' do
    module ::Module::Cluster::Cluster::AfterIncludeSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :after_include_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :after_subclass_or_include )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :after_include_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.after_include_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :after_include_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end
  
  ###############################
  #  before_extend_or_subclass  #
  #  before_subclass_or_extend  #
  ###############################
  
  it 'can create before-extend-or-subclass hooks' do
    module ::Module::Cluster::Cluster::BeforeExtendSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :before_extend_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :before_subclass_or_extend )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :before_extend_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.before_extend_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :before_extend_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end

  ##############################
  #  after_extend_or_subclass  #
  #  after_subclass_or_extend  #
  ##############################
  
  it 'can create after-extend-or-subclass hooks' do
    module ::Module::Cluster::Cluster::AfterExtendSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :after_extend_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :after_subclass_or_extend )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :after_extend_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.after_extend_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :after_extend_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end
  
  ##########################################
  #  before_include_or_extend_or_subclass  #
  #  before_include_or_subclass_or_extend  #
  #  before_extend_or_include_or_subclass  #
  #  before_extend_or_subclass_or_include  #
  #  before_subclass_or_include_or_extend  #
  #  before_subclass_or_extend_or_include  #
  ##########################################
  
  it 'can create before-include-or-extend-or-subclass hooks' do
    module ::Module::Cluster::Cluster::BeforeIncludeExtendSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :before_include_or_subclass_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :before_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :before_extend_or_include_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :before_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :before_extend_or_subclass_or_include ).should == ::Module::Cluster::Cluster.instance_method( :before_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :before_subclass_or_include_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :before_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :before_subclass_or_extend_or_include ).should == ::Module::Cluster::Cluster.instance_method( :before_include_or_extend_or_subclass )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :before_include_extend_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end
      
      proxy = cluster_instance.before_include_or_extend_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :before_include_extend_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end

  #########################################
  #  after_include_or_extend_or_subclass  #
  #  after_include_or_subclass_or_extend  #
  #  after_extend_or_include_or_subclass  #
  #  after_extend_or_subclass_or_include  #
  #  after_subclass_or_include_or_extend  #
  #  after_subclass_or_extend_or_include  #
  #########################################
  
  it 'can create after-include-or-extend-or-subclass hooks' do
    module ::Module::Cluster::Cluster::AfterIncludeExtendSubclassMock
      
      ::Module::Cluster::Cluster.instance_method( :after_include_or_subclass_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :after_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :after_extend_or_include_or_subclass ).should == ::Module::Cluster::Cluster.instance_method( :after_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :after_extend_or_subclass_or_include ).should == ::Module::Cluster::Cluster.instance_method( :after_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :after_subclass_or_include_or_extend ).should == ::Module::Cluster::Cluster.instance_method( :after_include_or_extend_or_subclass )
      ::Module::Cluster::Cluster.instance_method( :after_subclass_or_extend_or_include ).should == ::Module::Cluster::Cluster.instance_method( :after_include_or_extend_or_subclass )
      
      Instance = ::Module.new
      cluster_instance = ::Module::Cluster::Cluster.new( Instance, :after_include_extend_subclass )
      
      block_ran = false
      block_instance = ::Proc.new do
        block_ran = true
      end

      proxy = cluster_instance.after_include_or_extend_or_subclass( :class, :module ).cascade_to( :class, & block_instance )
      
      proxy.parent_multiple_hook_controller_proxy.name.should == :after_include_extend_subclass

      proxy.proxies.each do |this_proxy|
        this_proxy.contexts.should == [ :class, :module ]
        this_hook_controller = this_proxy.parent_hook_controller
        this_hook_controller.stack[ 0 ].module.should == nil
        this_hook_controller.stack[ 0 ].owner.should == Instance
        this_hook_controller.stack[ 0 ].action.should == nil
        this_hook_controller.stack[ 0 ].context.should == [ :class, :module ]
        this_hook_controller.stack[ 0 ].cascades.should == [ :class ]
        this_hook_controller.stack[ 0 ].block.should == block_instance
      end
      
    end
  end
  
end
