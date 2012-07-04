
require_relative '../../../../lib/module/cluster.rb'

describe ::Module::Cluster::InstanceController::HookController do
  
  before :all do
    module ::Module::Cluster::InstanceController::HookController::Mock

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
  
  ################
  #  initialize  #
  #  stack       #
  ################
  
  it 'can initialize for a parent instance controller' do
    module ::Module::Cluster::InstanceController::HookController::InitializeMock
      
      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )
      
      hook_controller.instance_variable_get( :@parent_instance_controller ).should == instance_controller
      hook_controller.stack.is_a?( ::Array ).should == true

    end
  end

  #############
  #  include  #
  #############

  it 'can put modules on its stack for including at later event hook' do
    module ::Module::Cluster::InstanceController::HookController::IncludeMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

      module A
      end
      module B
      end
      module C
      end
      
      hook_controller.include( A, B, C )
      
      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      hook_controller.stack[ 1 ].module.should == B
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      hook_controller.stack[ 2 ].module.should == C
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :include
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

    end
  end

  ############
  #  extend  #
  ############

  it 'can put modules on its stack for extending at later event hook' do
    module ::Module::Cluster::InstanceController::HookController::ExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

      module A
      end
      module B
      end
      module C
      end
      
      hook_controller.extend( A, B, C )
      
      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :extend
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      hook_controller.stack[ 1 ].module.should == B
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :extend
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      hook_controller.stack[ 2 ].module.should == C
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :extend
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

    end
  end

  ########################
  #  include_and_extend  #
  ########################

  it 'can put modules on its stack for including and extending at later event hook' do
    module ::Module::Cluster::InstanceController::HookController::IncludeAndExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

      module A
      end
      module B
      end
      module C
      end

      hook_controller.include_and_extend( A, B, C )
      
      # A
      
      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      hook_controller.stack[ 1 ].module.should == A
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :extend
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil
      
      # B
      
      hook_controller.stack[ 2 ].module.should == B
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :include
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

      hook_controller.stack[ 3 ].module.should == B
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil

      # C
      
      hook_controller.stack[ 4 ].module.should == C
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :include
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil
      
      hook_controller.stack[ 5 ].module.should == C
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :extend
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil
      
    end
  end

  ##################################################################################################
  #  private  ######################################################################################
  ##################################################################################################  


  #############
  #  indexes  #
  #############
  
  it 'can return indexes corresponding to include actions on event stack' do
    rspec = self
    ::Module::Cluster::InstanceController::HookController::IndexesMock = ::Module.new
    ::Module::Cluster::InstanceController::HookController::IndexesMock.module_eval do

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D ).include( E ).extend( F ).instance_eval do
      
        indexes( :include, A, B ).should == [ 0, 1 ]
        indexes( :include, E, B ).should == [ 1, 4 ]
        indexes( :include, E ).should == [ 4 ]
        indexes( :extend, C, D ).should == [ 2, 3 ]
        indexes( :extend, D ).should == [ 3 ]
        indexes( :extend, F ).should == [ 5 ]

        ::Proc.new { indexes( :include, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { indexes( :include, A, B, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { indexes( :extend, A, B ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { indexes( :extend, E ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )

      end
      
    end
  end

  ##################
  #  lowest_index  #
  ##################

  it 'can return the highest index for provided modules; throws exception if module provided is not found in stack' do
    rspec = self
    ::Module::Cluster::InstanceController::HookController::LowestIndexMock = ::Module.new
    ::Module::Cluster::InstanceController::HookController::LowestIndexMock.module_eval do

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D ).include( E ).extend( F ).instance_eval do
      
        lowest_index( :include, A, B ).should == 0
        lowest_index( :include, E, B ).should == 1
        lowest_index( :include, E ).should == 4
        lowest_index( :extend, D, C ).should == 2
        lowest_index( :extend, D ).should == 3
        lowest_index( :extend, F ).should == 5

        ::Proc.new { lowest_index( :include, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { lowest_index( :include, A, B, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { lowest_index( :extend, A, B ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { lowest_index( :extend, E ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )

      end
      
    end
  end

  ###################
  #  highest_index  #
  ###################  
    
  it 'can return the highest index for provided modules; throws exception if module provided is not found in stack' do
    rspec = self
    ::Module::Cluster::InstanceController::HookController::HighestIndexMock = ::Module.new
    ::Module::Cluster::InstanceController::HookController::HighestIndexMock.module_eval do

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D ).include( E ).extend( F ).instance_eval do
      
        highest_index( :include, A, B ).should == 1
        highest_index( :include, E, B ).should == 4
        highest_index( :include, E ).should == 4
        highest_index( :extend, C, D ).should == 3
        highest_index( :extend, D ).should == 3
        highest_index( :extend, F ).should == 5

        ::Proc.new { highest_index( :include, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { highest_index( :include, A, B, C ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { highest_index( :extend, A, B ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )
        ::Proc.new { highest_index( :extend, E ) }.should rspec.raise_error( ::Module::Cluster::Exception::ModuleNotInStack )

      end

    end
  end

  ##################################################################################################
  #  public  #######################################################################################
  ##################################################################################################
  
  ############
  #  action  #
  ############
  
  it 'can create a block action to perform at hook' do
    module ::Module::Cluster::InstanceController::HookController::ActionMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )
      
      block_ran = false
      action_proc = ::Proc.new do
        block_ran = true
      end
      hook_controller.action( & action_proc )
      
      hook_controller.stack[ 0 ].module.should == nil
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == nil
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == action_proc

    end
  end

  ###########
  #  proxy  #
  ###########
  
  it 'can provide a proxy to return context-chained calls to self' do
    module ::Module::Cluster::InstanceController::HookController::ProxyMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

      chain_proxy = hook_controller.chain_proxy
      chain_proxy.is_a?( ::Module::Cluster::InstanceController::HookController::ChainProxy ).should == true
      chain_proxy.should == hook_controller.chain_proxy
      
    end
  end
  
  ####################
  #  before_include  #
  ####################
  
  it 'can chain methods specifying context for include/extend as before a given module include event' do
    module ::Module::Cluster::InstanceController::HookController::BeforeIncludeMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D )
      
      hook_controller.before_include( B ).extend( F )
      hook_controller.before_include( A ).include( E )

      # E
      
      hook_controller.stack[ 0 ].module.should == E
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # A

      hook_controller.stack[ 1 ].module.should == A
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # F

      hook_controller.stack[ 2 ].module.should == F
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :extend
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil
      
      # B
      
      hook_controller.stack[ 3 ].module.should == B
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :include
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil

      # C
      
      hook_controller.stack[ 4 ].module.should == C
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :extend
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # D
      
      hook_controller.stack[ 5 ].module.should == D
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :extend
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

    end
  end

  ###################
  #  before_extend  #
  ###################
  
  it 'can chain methods specifying context for include/extend as before a given module extend event' do
    module ::Module::Cluster::InstanceController::HookController::BeforeExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D )
      
      hook_controller.before_extend( C ).extend( F )
      hook_controller.before_extend( D ).include( E )

      # A

      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # B
      
      hook_controller.stack[ 1 ].module.should == B
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # F

      hook_controller.stack[ 2 ].module.should == F
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :extend
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil
      
      # C
      
      hook_controller.stack[ 3 ].module.should == C
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil

      # E
      
      hook_controller.stack[ 4 ].module.should == E
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :include
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # D
      
      hook_controller.stack[ 5 ].module.should == D
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :extend
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

    end
  end

  ##############################
  #  before_include_or_extend  #
  ##############################
  
  it 'can chain methods specifying context for include/extend as before a given module include or extend event' do
    module ::Module::Cluster::InstanceController::HookController::BeforeIncludeOrExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( B, C ).include( C ).include_and_extend( D ).extend( A )
      
      hook_controller.before_include_or_extend( B ).extend( F )
      hook_controller.before_include_or_extend( A ).include_and_extend( E )

      # E - include
      
      hook_controller.stack[ 0 ].module.should == E
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # E - extend
      
      hook_controller.stack[ 1 ].module.should == E
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :extend
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # A - include

      hook_controller.stack[ 2 ].module.should == A
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :include
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

      # F - extend

      hook_controller.stack[ 3 ].module.should == F
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil
      
      # B - include
      
      hook_controller.stack[ 4 ].module.should == B
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :include
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # B - extend
      
      hook_controller.stack[ 5 ].module.should == B
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :extend
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

      # C - extend
      
      hook_controller.stack[ 6 ].module.should == C
      hook_controller.stack[ 6 ].owner.should == instance_controller.instance
      hook_controller.stack[ 6 ].action.should == :extend
      hook_controller.stack[ 6 ].cascades.should == nil
      hook_controller.stack[ 6 ].block.should == nil

      # C - include
      
      hook_controller.stack[ 7 ].module.should == C
      hook_controller.stack[ 7 ].owner.should == instance_controller.instance
      hook_controller.stack[ 7 ].action.should == :include
      hook_controller.stack[ 7 ].cascades.should == nil
      hook_controller.stack[ 7 ].block.should == nil

      # D - include
      
      hook_controller.stack[ 8 ].module.should == D
      hook_controller.stack[ 8 ].owner.should == instance_controller.instance
      hook_controller.stack[ 8 ].action.should == :include
      hook_controller.stack[ 8 ].cascades.should == nil
      hook_controller.stack[ 8 ].block.should == nil

      # D - extend
      
      hook_controller.stack[ 9 ].module.should == D
      hook_controller.stack[ 9 ].owner.should == instance_controller.instance
      hook_controller.stack[ 9 ].action.should == :extend
      hook_controller.stack[ 9 ].cascades.should == nil
      hook_controller.stack[ 9 ].block.should == nil

      # A - extend
      
      hook_controller.stack[ 10 ].module.should == A
      hook_controller.stack[ 10 ].owner.should == instance_controller.instance
      hook_controller.stack[ 10 ].action.should == :extend
      hook_controller.stack[ 10 ].cascades.should == nil
      hook_controller.stack[ 10 ].block.should == nil

    end
  end
  
  ###################
  #  after_include  #
  ###################
  
  it 'can chain methods specifying context for include/extend as after a given module include event' do
    module ::Module::Cluster::InstanceController::HookController::AfterIncludeMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D )
      
      hook_controller.after_include( B ).extend( F )
      hook_controller.after_include( A ).include( E )

      # A

      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # E
      
      hook_controller.stack[ 1 ].module.should == E
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # B
      
      hook_controller.stack[ 2 ].module.should == B
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :include
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

      # F

      hook_controller.stack[ 3 ].module.should == F
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil
      
      # C
      
      hook_controller.stack[ 4 ].module.should == C
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :extend
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # D
      
      hook_controller.stack[ 5 ].module.should == D
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :extend
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

    end
  end

  ##################
  #  after_extend  #
  ##################
  
  it 'can chain methods specifying context for include/extend as after a given module extend event' do
    module ::Module::Cluster::InstanceController::HookController::AfterExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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
      
      hook_controller.include( A, B ).extend( C, D )
      
      hook_controller.after_extend( C ).extend( F )
      hook_controller.after_extend( D ).include( E )

      # A

      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # B
      
      hook_controller.stack[ 1 ].module.should == B
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # C

      hook_controller.stack[ 2 ].module.should == C
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :extend
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil
      
      # F
      
      hook_controller.stack[ 3 ].module.should == F
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil

      # D
      
      hook_controller.stack[ 4 ].module.should == D
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :extend
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # E
      
      hook_controller.stack[ 5 ].module.should == E
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :include
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

    end
  end

  #############################
  #  after_include_or_extend  #
  #############################
  
  it 'can chain methods specifying context for include/extend as after a given module include or extend event' do
    module ::Module::Cluster::InstanceController::HookController::AfterIncludeOrExtendMock

      instance_controller = ::Module::Cluster::InstanceController::HookController::Mock::InstanceController
      hook_controller = ::Module::Cluster::InstanceController::HookController.new( :mock, instance_controller )

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

      hook_controller.include( A, B ).extend( B, C ).include( C ).include_and_extend( D ).extend( A )
      
      hook_controller.after_include_or_extend( B ).extend( F )
      hook_controller.after_include_or_extend( A ).include_and_extend( E )

      # A - include

      hook_controller.stack[ 0 ].module.should == A
      hook_controller.stack[ 0 ].owner.should == instance_controller.instance
      hook_controller.stack[ 0 ].action.should == :include
      hook_controller.stack[ 0 ].cascades.should == nil
      hook_controller.stack[ 0 ].block.should == nil

      # B - include
      
      hook_controller.stack[ 1 ].module.should == B
      hook_controller.stack[ 1 ].owner.should == instance_controller.instance
      hook_controller.stack[ 1 ].action.should == :include
      hook_controller.stack[ 1 ].cascades.should == nil
      hook_controller.stack[ 1 ].block.should == nil

      # B - extend
      
      hook_controller.stack[ 2 ].module.should == B
      hook_controller.stack[ 2 ].owner.should == instance_controller.instance
      hook_controller.stack[ 2 ].action.should == :extend
      hook_controller.stack[ 2 ].cascades.should == nil
      hook_controller.stack[ 2 ].block.should == nil

      # F - extend

      hook_controller.stack[ 3 ].module.should == F
      hook_controller.stack[ 3 ].owner.should == instance_controller.instance
      hook_controller.stack[ 3 ].action.should == :extend
      hook_controller.stack[ 3 ].cascades.should == nil
      hook_controller.stack[ 3 ].block.should == nil
      

      # C - extend
      
      hook_controller.stack[ 4 ].module.should == C
      hook_controller.stack[ 4 ].owner.should == instance_controller.instance
      hook_controller.stack[ 4 ].action.should == :extend
      hook_controller.stack[ 4 ].cascades.should == nil
      hook_controller.stack[ 4 ].block.should == nil

      # C - include
      
      hook_controller.stack[ 5 ].module.should == C
      hook_controller.stack[ 5 ].owner.should == instance_controller.instance
      hook_controller.stack[ 5 ].action.should == :include
      hook_controller.stack[ 5 ].cascades.should == nil
      hook_controller.stack[ 5 ].block.should == nil

      # D - include
      
      hook_controller.stack[ 6 ].module.should == D
      hook_controller.stack[ 6 ].owner.should == instance_controller.instance
      hook_controller.stack[ 6 ].action.should == :include
      hook_controller.stack[ 6 ].cascades.should == nil
      hook_controller.stack[ 6 ].block.should == nil

      # D - extend
      
      hook_controller.stack[ 7 ].module.should == D
      hook_controller.stack[ 7 ].owner.should == instance_controller.instance
      hook_controller.stack[ 7 ].action.should == :extend
      hook_controller.stack[ 7 ].cascades.should == nil
      hook_controller.stack[ 7 ].block.should == nil

      # A - extend
      
      hook_controller.stack[ 8 ].module.should == A
      hook_controller.stack[ 8 ].owner.should == instance_controller.instance
      hook_controller.stack[ 8 ].action.should == :extend
      hook_controller.stack[ 8 ].cascades.should == nil
      hook_controller.stack[ 8 ].block.should == nil

      # E - include
      
      hook_controller.stack[ 9 ].module.should == E
      hook_controller.stack[ 9 ].owner.should == instance_controller.instance
      hook_controller.stack[ 9 ].action.should == :include
      hook_controller.stack[ 9 ].cascades.should == nil
      hook_controller.stack[ 9 ].block.should == nil

      # E - extend
      
      hook_controller.stack[ 10 ].module.should == E
      hook_controller.stack[ 10 ].owner.should == instance_controller.instance
      hook_controller.stack[ 10 ].action.should == :extend
      hook_controller.stack[ 10 ].cascades.should == nil
      hook_controller.stack[ 10 ].block.should == nil

    end
  end
  
end
