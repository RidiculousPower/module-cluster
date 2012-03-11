
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Suspend::WithoutHooks do

  #######################
  #  without_any_hooks  #
  #######################
  
  it 'can suspend and resume all hooks at once or all hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock01
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_any_hooks do
        all_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      all_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_any_hooks( :name => :one ) do
        all_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == true
        prepend_extend_set_one.suspended.should == true
        include_set_one.suspended.should == true
        extend_set_one.suspended.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      all_hooks_suspended?.should == false
      
    end    
  end
  
  ###############################
  #  without_any_include_hooks  #
  ###############################
  
  it 'can suspend and resume all include or prepending include hooks at once or any include or prepending include hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock02
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      suspend_any_include_hooks
      all_include_hooks_suspended?.should == true
      cluster_stack.all_include_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      resume_any_include_hooks
      all_include_hooks_suspended?.should == false
      
      # suspend hooks by description
      suspend_any_include_hooks( :name => :one )
      all_include_hooks_suspended?.should == false
      prepend_include_set_one.suspended.should == true
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == true
      extend_set_one.suspended.should == false
      cluster_stack.all_include_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      resume_any_include_hooks( :name => :one )
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      all_include_hooks_suspended?.should == false
      
    end
  end

  ##############################
  #  without_any_extend_hooks  #
  ##############################
  
  it 'can suspend and resume all extend or prepending extend hooks at once or any extend or prepending extend hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock03
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_any_extend_hooks do
        all_extend_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      all_extend_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_any_extend_hooks( :name => :one ) do
        all_extend_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == false
        prepend_extend_set_one.suspended.should == true
        include_set_one.suspended.should == false
        extend_set_one.suspended.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      all_extend_hooks_suspended?.should == false
      
    end
  end

  ###########################
  #  without_include_hooks  #
  ###########################
  
  it 'can suspend and resume all include hooks at once or any include hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock04
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_include_hooks do
        include_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      include_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_include_hooks( :name => :one ) do
        include_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == false
        prepend_extend_set_one.suspended.should == false
        include_set_one.suspended.should == true
        extend_set_one.suspended.should == false
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      include_hooks_suspended?.should == false
      
    end
  end

  ##########################
  #  without_extend_hooks  #
  ##########################
  
  it 'can suspend and resume all extend hooks at once or any extend hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock05
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_extend_hooks do
        extend_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      extend_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_extend_hooks( :name => :one ) do
        extend_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == false
        prepend_extend_set_one.suspended.should == false
        include_set_one.suspended.should == false
        extend_set_one.suspended.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      extend_hooks_suspended?.should == false
      
    end
  end

  ###################################
  #  without_prepend_include_hooks  #
  ###################################
  
  it 'can suspend and resume all prepending include hooks at once or any prepending include hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock06
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_prepend_include_hooks do
        prepend_include_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_prepend_include_hooks( :name => :one ) do
        prepend_include_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == true
        prepend_extend_set_one.suspended.should == false
        include_set_one.suspended.should == false
        extend_set_one.suspended.should == false
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      prepend_include_hooks_suspended?.should == false
      
    end
  end

  ##################################
  #  without_prepend_extend_hooks  #
  ##################################

  it 'can suspend and resume all prepending extend hooks at once or any prepending extend hooks matching a description' do
    module ModuleCluster::Suspend::WithoutHooks::Mock07
      extend ::ModuleCluster::Suspend::WithoutHooks
      # required to provide #cluster_stack
      extend ::ModuleCluster::CascadeFeatures::ClusterStack
      module Module1
      end
      module Module2
      end
      module Module3
      end
      module Module4
      end
      # prepend include
      prepend_include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one )
      prepend_include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two )
      prepend_include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three )
      prepend_include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_one )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_two )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_three )
      cluster_stack.prepend_include_hooks.push( prepend_include_set_four )
      # prepend extend
      prepend_extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      prepend_extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, true, :two  )
      prepend_extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      prepend_extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_one )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_two )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_three )
      cluster_stack.prepend_extend_hooks.push( prepend_extend_set_four )
      # include
      include_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      include_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      include_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, true, :three  )
      include_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, false, :four  )
      cluster_stack.include_hooks.push( include_set_one )
      cluster_stack.include_hooks.push( include_set_two )
      cluster_stack.include_hooks.push( include_set_three )
      cluster_stack.include_hooks.push( include_set_four )
      # extend
      extend_set_one = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module1 ], nil, false, :one  )
      extend_set_two = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include, [ Module2 ], nil, false, :two  )
      extend_set_three = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :extend, [ Module3 ], nil, false, :three  )
      extend_set_four = ModuleCluster::ClusterStack::Set.new( Kernel, :some_method, :all, :include_and_extend, [ Module4 ], nil, true, :four  )
      cluster_stack.extend_hooks.push( extend_set_one )
      cluster_stack.extend_hooks.push( extend_set_two )
      cluster_stack.extend_hooks.push( extend_set_three )
      cluster_stack.extend_hooks.push( extend_set_four )
      
      # suspend all hooks
      without_prepend_extend_hooks do
        prepend_extend_hooks_suspended?.should == true
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_extend_hooks_suspended?.should == false
      
      # suspend hooks by description
      without_prepend_extend_hooks( :name => :one ) do
        prepend_extend_hooks_suspended?.should == false
        prepend_include_set_one.suspended.should == false
        prepend_extend_set_one.suspended.should == true
        include_set_one.suspended.should == false
        extend_set_one.suspended.should == false
        cluster_stack.all_hooks.collect { |this_hook| ! this_hook.suspended }.empty?.should == false
      end
      prepend_include_set_one.suspended.should == false
      prepend_extend_set_one.suspended.should == false
      include_set_one.suspended.should == false
      extend_set_one.suspended.should == false
      prepend_extend_hooks_suspended?.should == false
      
    end
  end

end
