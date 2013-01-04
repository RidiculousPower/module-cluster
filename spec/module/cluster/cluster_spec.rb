
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
      hook_controller.stack[ 0 ].include_or_extend.should == nil
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
      hook_controller.stack[ 0 ].include_or_extend.should == nil
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
      hook_controller.stack[ 0 ].include_or_extend.should == nil
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
      hook_controller.stack[ 0 ].include_or_extend.should == nil
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
      hook_controller.stack[ 0 ].include_or_extend.should == nil
      hook_controller.stack[ 0 ].context.should == [ ]
      hook_controller.stack[ 0 ].cascades.should == [ ]
      hook_controller.stack[ 0 ].block.should == block_instance
      
    end
  end
  
end
