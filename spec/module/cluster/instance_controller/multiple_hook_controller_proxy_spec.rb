
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController::MultipleHookControllerProxy do
  
  before :all do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock

      module Instance
      end
      
      class InstanceControllerMock
        def instance
          return Instance
        end
      end
      
      InstanceController = InstanceControllerMock.new

    end
  end

  #############
  #  include  #
  #############

  it 'can put modules on its stack for including at later event hook' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::IncludeMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      
      multi_hook_controller.include( A, B, C )
      
      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      HookControllerA.stack[ 1 ].module.should == B
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      HookControllerA.stack[ 2 ].module.should == C
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :include
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      HookControllerB.stack[ 1 ].module.should == B
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      HookControllerB.stack[ 2 ].module.should == C
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :include
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

    end
  end

  ############
  #  extend  #
  ############

  it 'can put modules on its stack for extending at later event hook' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      
      multi_hook_controller.extend( A, B, C )
      
      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :extend
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      HookControllerA.stack[ 1 ].module.should == B
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :extend
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      HookControllerA.stack[ 2 ].module.should == C
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :extend
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :extend
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      HookControllerB.stack[ 1 ].module.should == B
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :extend
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      HookControllerB.stack[ 2 ].module.should == C
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :extend
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

    end
  end

  ########################
  #  include_and_extend  #
  ########################

  it 'can put modules on its stack for including and extending at later event hook' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::IncludeAndExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end

      multi_hook_controller.include_and_extend( A, B, C )
      
      # A
      
      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      HookControllerA.stack[ 1 ].module.should == A
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :extend
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil
      
      # B
      
      HookControllerA.stack[ 2 ].module.should == B
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :include
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      HookControllerA.stack[ 3 ].module.should == B
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil

      # C
      
      HookControllerA.stack[ 4 ].module.should == C
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :include
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil
      
      HookControllerA.stack[ 5 ].module.should == C
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :extend
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # A
      
      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      HookControllerB.stack[ 1 ].module.should == A
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :extend
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil
      
      # B
      
      HookControllerB.stack[ 2 ].module.should == B
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :include
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

      HookControllerB.stack[ 3 ].module.should == B
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil

      # C
      
      HookControllerB.stack[ 4 ].module.should == C
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :include
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil
      
      HookControllerB.stack[ 5 ].module.should == C
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :extend
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil
      
    end
  end

  ############
  #  action  #
  ############
  
  it 'can create a block action to perform at hook' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ActionMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )
      
      block_ran = false
      action_proc = ::Proc.new do
        block_ran = true
      end
      
      multi_hook_controller.action( & action_proc )
      
      HookControllerA.stack[ 0 ].module.should == nil
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == nil
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == action_proc

      HookControllerB.stack[ 0 ].module.should == nil
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == nil
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == action_proc

    end
  end

  #################
  #  chain_proxy  #
  #################
  
  it 'can provide a proxy to return context-chained calls to self' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ProxyMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      chain_proxy = multi_hook_controller.chain_proxy
      chain_proxy.is_a?( ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy ).should == true
      chain_proxy.should == multi_hook_controller.chain_proxy
      
    end
  end
  
  ####################
  #  before_include  #
  ####################
  
  it 'can chain methods specifying context for include/extend as before a given module include event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::BeforeIncludeMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
      
      multi_hook_controller.include( A, B ).extend( C, D )
      
      multi_hook_controller.before_include( B ).extend( F )
      multi_hook_controller.before_include( A ).include( E )

      # E
      
      HookControllerA.stack[ 0 ].module.should == E
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # A

      HookControllerA.stack[ 1 ].module.should == A
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # F

      HookControllerA.stack[ 2 ].module.should == F
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :extend
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil
      
      # B
      
      HookControllerA.stack[ 3 ].module.should == B
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :include
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil

      # C
      
      HookControllerA.stack[ 4 ].module.should == C
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :extend
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # D
      
      HookControllerA.stack[ 5 ].module.should == D
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :extend
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # E
      
      HookControllerB.stack[ 0 ].module.should == E
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # A

      HookControllerB.stack[ 1 ].module.should == A
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # F

      HookControllerB.stack[ 2 ].module.should == F
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :extend
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil
      
      # B
      
      HookControllerB.stack[ 3 ].module.should == B
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :include
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil

      # C
      
      HookControllerB.stack[ 4 ].module.should == C
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :extend
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # D
      
      HookControllerB.stack[ 5 ].module.should == D
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :extend
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

    end
  end

  ###################
  #  before_extend  #
  ###################
  
  it 'can chain methods specifying context for include/extend as before a given module extend event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::BeforeExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
      
      multi_hook_controller.include( A, B ).extend( C, D )

      multi_hook_controller.before_extend( C ).extend( F )
      multi_hook_controller.before_extend( D ).include( E )

      # A

      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # B
      
      HookControllerA.stack[ 1 ].module.should == B
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # F

      HookControllerA.stack[ 2 ].module.should == F
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :extend
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil
      
      # C
      
      HookControllerA.stack[ 3 ].module.should == C
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil

      # E
      
      HookControllerA.stack[ 4 ].module.should == E
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :include
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # D
      
      HookControllerA.stack[ 5 ].module.should == D
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :extend
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # A

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # B
      
      HookControllerB.stack[ 1 ].module.should == B
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # F

      HookControllerB.stack[ 2 ].module.should == F
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :extend
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil
      
      # C
      
      HookControllerB.stack[ 3 ].module.should == C
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil

      # E
      
      HookControllerB.stack[ 4 ].module.should == E
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :include
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # D
      
      HookControllerB.stack[ 5 ].module.should == D
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :extend
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

    end
  end

  ##############################
  #  before_include_or_extend  #
  ##############################
  
  it 'can chain methods specifying context for include/extend as before a given module include or extend event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::BeforeIncludeOrExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
      
      multi_hook_controller.include( A, B ).extend( B, C ).include( C ).include_and_extend( D ).extend( A )
      
      multi_hook_controller.before_include_or_extend( B ).extend( F )
      multi_hook_controller.before_include_or_extend( A ).include_and_extend( E )

      # E - include
      
      HookControllerA.stack[ 0 ].module.should == E
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # E - extend
      
      HookControllerA.stack[ 1 ].module.should == E
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :extend
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # A - include

      HookControllerA.stack[ 2 ].module.should == A
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :include
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      # F - extend

      HookControllerA.stack[ 3 ].module.should == F
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil
      
      # B - include
      
      HookControllerA.stack[ 4 ].module.should == B
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :include
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # B - extend
      
      HookControllerA.stack[ 5 ].module.should == B
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :extend
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # C - extend
      
      HookControllerA.stack[ 6 ].module.should == C
      HookControllerA.stack[ 6 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 6 ].action.should == :extend
      HookControllerA.stack[ 6 ].cascades.should == nil
      HookControllerA.stack[ 6 ].block.should == nil

      # C - include
      
      HookControllerA.stack[ 7 ].module.should == C
      HookControllerA.stack[ 7 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 7 ].action.should == :include
      HookControllerA.stack[ 7 ].cascades.should == nil
      HookControllerA.stack[ 7 ].block.should == nil

      # D - include
      
      HookControllerA.stack[ 8 ].module.should == D
      HookControllerA.stack[ 8 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 8 ].action.should == :include
      HookControllerA.stack[ 8 ].cascades.should == nil
      HookControllerA.stack[ 8 ].block.should == nil

      # D - extend
      
      HookControllerA.stack[ 9 ].module.should == D
      HookControllerA.stack[ 9 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 9 ].action.should == :extend
      HookControllerA.stack[ 9 ].cascades.should == nil
      HookControllerA.stack[ 9 ].block.should == nil

      # A - extend
      
      HookControllerA.stack[ 10 ].module.should == A
      HookControllerA.stack[ 10 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 10 ].action.should == :extend
      HookControllerA.stack[ 10 ].cascades.should == nil
      HookControllerA.stack[ 10 ].block.should == nil

      # E - include
      
      HookControllerB.stack[ 0 ].module.should == E
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # E - extend
      
      HookControllerB.stack[ 1 ].module.should == E
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :extend
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # A - include

      HookControllerB.stack[ 2 ].module.should == A
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :include
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

      # F - extend

      HookControllerB.stack[ 3 ].module.should == F
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil
      
      # B - include
      
      HookControllerB.stack[ 4 ].module.should == B
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :include
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # B - extend
      
      HookControllerB.stack[ 5 ].module.should == B
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :extend
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

      # C - extend
      
      HookControllerB.stack[ 6 ].module.should == C
      HookControllerB.stack[ 6 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 6 ].action.should == :extend
      HookControllerB.stack[ 6 ].cascades.should == nil
      HookControllerB.stack[ 6 ].block.should == nil

      # C - include
      
      HookControllerB.stack[ 7 ].module.should == C
      HookControllerB.stack[ 7 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 7 ].action.should == :include
      HookControllerB.stack[ 7 ].cascades.should == nil
      HookControllerB.stack[ 7 ].block.should == nil

      # D - include
      
      HookControllerB.stack[ 8 ].module.should == D
      HookControllerB.stack[ 8 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 8 ].action.should == :include
      HookControllerB.stack[ 8 ].cascades.should == nil
      HookControllerB.stack[ 8 ].block.should == nil

      # D - extend
      
      HookControllerB.stack[ 9 ].module.should == D
      HookControllerB.stack[ 9 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 9 ].action.should == :extend
      HookControllerB.stack[ 9 ].cascades.should == nil
      HookControllerB.stack[ 9 ].block.should == nil

      # A - extend
      
      HookControllerB.stack[ 10 ].module.should == A
      HookControllerB.stack[ 10 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 10 ].action.should == :extend
      HookControllerB.stack[ 10 ].cascades.should == nil
      HookControllerB.stack[ 10 ].block.should == nil

    end
  end
  
  ###################
  #  after_include  #
  ###################
  
  it 'can chain methods specifying context for include/extend as after a given module include event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::AfterIncludeMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
      
      multi_hook_controller.include( A, B ).extend( C, D )
      
      multi_hook_controller.after_include( B ).extend( F )
      multi_hook_controller.after_include( A ).include( E )

      # A

      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # E
      
      HookControllerA.stack[ 1 ].module.should == E
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # B
      
      HookControllerA.stack[ 2 ].module.should == B
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :include
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      # F

      HookControllerA.stack[ 3 ].module.should == F
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil
      
      # C
      
      HookControllerA.stack[ 4 ].module.should == C
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :extend
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # D
      
      HookControllerA.stack[ 5 ].module.should == D
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :extend
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # A

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # E
      
      HookControllerB.stack[ 1 ].module.should == E
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # B
      
      HookControllerB.stack[ 2 ].module.should == B
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :include
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

      # F

      HookControllerB.stack[ 3 ].module.should == F
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil
      
      # C
      
      HookControllerB.stack[ 4 ].module.should == C
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :extend
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # D
      
      HookControllerB.stack[ 5 ].module.should == D
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :extend
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

    end
  end

  ##################
  #  after_extend  #
  ##################
  
  it 'can chain methods specifying context for include/extend as after a given module extend event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::AfterExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end
      
      multi_hook_controller.include( A, B ).extend( C, D )
      
      multi_hook_controller.after_extend( C ).extend( F )
      multi_hook_controller.after_extend( D ).include( E )

      # A

      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # B
      
      HookControllerA.stack[ 1 ].module.should == B
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # C

      HookControllerA.stack[ 2 ].module.should == C
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :extend
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil
      
      # F
      
      HookControllerA.stack[ 3 ].module.should == F
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil

      # D
      
      HookControllerA.stack[ 4 ].module.should == D
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :extend
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # E
      
      HookControllerA.stack[ 5 ].module.should == E
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :include
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # A

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # B
      
      HookControllerB.stack[ 1 ].module.should == B
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # C

      HookControllerB.stack[ 2 ].module.should == C
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :extend
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil
      
      # F
      
      HookControllerB.stack[ 3 ].module.should == F
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil

      # D
      
      HookControllerB.stack[ 4 ].module.should == D
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :extend
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # E
      
      HookControllerB.stack[ 5 ].module.should == E
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :include
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

    end
  end

  #############################
  #  after_include_or_extend  #
  #############################

  it 'can chain methods specifying context for include/extend as after a given module include or extend event' do
    module ::Module::Cluster::InstanceController::MultipleHookControllerProxy::AfterIncludeOrExtendMock

      instance_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy::Mock::InstanceController
      HookControllerA = ::Module::Cluster::InstanceController::HookController.new( :mock_A, instance_controller )
      HookControllerB = ::Module::Cluster::InstanceController::HookController.new( :mock_B, instance_controller )
      multi_hook_controller = ::Module::Cluster::InstanceController::MultipleHookControllerProxy.new( :mock, HookControllerA, HookControllerB )

      module A
      end
      module B
      end
      module C
      end
      module D
      end
      module E
      end
      module F
      end

      multi_hook_controller.include( A, B ).extend( B, C ).include( C ).include_and_extend( D ).extend( A )
      
      multi_hook_controller.after_include_or_extend( B ).extend( F )
      multi_hook_controller.after_include_or_extend( A ).include_and_extend( E )

      # A - include

      HookControllerA.stack[ 0 ].module.should == A
      HookControllerA.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 0 ].action.should == :include
      HookControllerA.stack[ 0 ].cascades.should == nil
      HookControllerA.stack[ 0 ].block.should == nil

      # B - include
      
      HookControllerA.stack[ 1 ].module.should == B
      HookControllerA.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 1 ].action.should == :include
      HookControllerA.stack[ 1 ].cascades.should == nil
      HookControllerA.stack[ 1 ].block.should == nil

      # B - extend
      
      HookControllerA.stack[ 2 ].module.should == B
      HookControllerA.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 2 ].action.should == :extend
      HookControllerA.stack[ 2 ].cascades.should == nil
      HookControllerA.stack[ 2 ].block.should == nil

      # F - extend

      HookControllerA.stack[ 3 ].module.should == F
      HookControllerA.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 3 ].action.should == :extend
      HookControllerA.stack[ 3 ].cascades.should == nil
      HookControllerA.stack[ 3 ].block.should == nil
      

      # C - extend
      
      HookControllerA.stack[ 4 ].module.should == C
      HookControllerA.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 4 ].action.should == :extend
      HookControllerA.stack[ 4 ].cascades.should == nil
      HookControllerA.stack[ 4 ].block.should == nil

      # C - include
      
      HookControllerA.stack[ 5 ].module.should == C
      HookControllerA.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 5 ].action.should == :include
      HookControllerA.stack[ 5 ].cascades.should == nil
      HookControllerA.stack[ 5 ].block.should == nil

      # D - include
      
      HookControllerA.stack[ 6 ].module.should == D
      HookControllerA.stack[ 6 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 6 ].action.should == :include
      HookControllerA.stack[ 6 ].cascades.should == nil
      HookControllerA.stack[ 6 ].block.should == nil

      # D - extend
      
      HookControllerA.stack[ 7 ].module.should == D
      HookControllerA.stack[ 7 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 7 ].action.should == :extend
      HookControllerA.stack[ 7 ].cascades.should == nil
      HookControllerA.stack[ 7 ].block.should == nil

      # A - extend
      
      HookControllerA.stack[ 8 ].module.should == A
      HookControllerA.stack[ 8 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 8 ].action.should == :extend
      HookControllerA.stack[ 8 ].cascades.should == nil
      HookControllerA.stack[ 8 ].block.should == nil

      # E - include
      
      HookControllerA.stack[ 9 ].module.should == E
      HookControllerA.stack[ 9 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 9 ].action.should == :include
      HookControllerA.stack[ 9 ].cascades.should == nil
      HookControllerA.stack[ 9 ].block.should == nil

      # E - extend
      
      HookControllerA.stack[ 10 ].module.should == E
      HookControllerA.stack[ 10 ].owner.should == instance_controller.instance
      HookControllerA.stack[ 10 ].action.should == :extend
      HookControllerA.stack[ 10 ].cascades.should == nil
      HookControllerA.stack[ 10 ].block.should == nil

      # A - include

      HookControllerB.stack[ 0 ].module.should == A
      HookControllerB.stack[ 0 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 0 ].action.should == :include
      HookControllerB.stack[ 0 ].cascades.should == nil
      HookControllerB.stack[ 0 ].block.should == nil

      # B - include
      
      HookControllerB.stack[ 1 ].module.should == B
      HookControllerB.stack[ 1 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 1 ].action.should == :include
      HookControllerB.stack[ 1 ].cascades.should == nil
      HookControllerB.stack[ 1 ].block.should == nil

      # B - extend
      
      HookControllerB.stack[ 2 ].module.should == B
      HookControllerB.stack[ 2 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 2 ].action.should == :extend
      HookControllerB.stack[ 2 ].cascades.should == nil
      HookControllerB.stack[ 2 ].block.should == nil

      # F - extend

      HookControllerB.stack[ 3 ].module.should == F
      HookControllerB.stack[ 3 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 3 ].action.should == :extend
      HookControllerB.stack[ 3 ].cascades.should == nil
      HookControllerB.stack[ 3 ].block.should == nil
      

      # C - extend
      
      HookControllerB.stack[ 4 ].module.should == C
      HookControllerB.stack[ 4 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 4 ].action.should == :extend
      HookControllerB.stack[ 4 ].cascades.should == nil
      HookControllerB.stack[ 4 ].block.should == nil

      # C - include
      
      HookControllerB.stack[ 5 ].module.should == C
      HookControllerB.stack[ 5 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 5 ].action.should == :include
      HookControllerB.stack[ 5 ].cascades.should == nil
      HookControllerB.stack[ 5 ].block.should == nil

      # D - include
      
      HookControllerB.stack[ 6 ].module.should == D
      HookControllerB.stack[ 6 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 6 ].action.should == :include
      HookControllerB.stack[ 6 ].cascades.should == nil
      HookControllerB.stack[ 6 ].block.should == nil

      # D - extend
      
      HookControllerB.stack[ 7 ].module.should == D
      HookControllerB.stack[ 7 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 7 ].action.should == :extend
      HookControllerB.stack[ 7 ].cascades.should == nil
      HookControllerB.stack[ 7 ].block.should == nil

      # A - extend
      
      HookControllerB.stack[ 8 ].module.should == A
      HookControllerB.stack[ 8 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 8 ].action.should == :extend
      HookControllerB.stack[ 8 ].cascades.should == nil
      HookControllerB.stack[ 8 ].block.should == nil

      # E - include
      
      HookControllerB.stack[ 9 ].module.should == E
      HookControllerB.stack[ 9 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 9 ].action.should == :include
      HookControllerB.stack[ 9 ].cascades.should == nil
      HookControllerB.stack[ 9 ].block.should == nil

      # E - extend
      
      HookControllerB.stack[ 10 ].module.should == E
      HookControllerB.stack[ 10 ].owner.should == instance_controller.instance
      HookControllerB.stack[ 10 ].action.should == :extend
      HookControllerB.stack[ 10 ].cascades.should == nil
      HookControllerB.stack[ 10 ].block.should == nil

    end
  end

end
