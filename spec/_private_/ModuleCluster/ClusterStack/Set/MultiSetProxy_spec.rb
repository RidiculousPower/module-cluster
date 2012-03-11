
require_relative '../../../../../lib/module-cluster.rb'

describe ::ModuleCluster::ClusterStack::Set::MultiSetProxy do

  ###########
  #  name=  #
  #  name   #
  ###########

  it 'can set the name of each member set and retrieve the names of each member set' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    set_one.name = :some_name
    set_two.name = :some_other_name
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.name.should == [ :some_name, :some_other_name ]
    multi_set.name = :yet_another_other_name
    multi_set.name.should == [ :yet_another_other_name, :yet_another_other_name ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.name.should == [ :yet_another_other_name, :yet_another_other_name, :some_name, :some_other_name ]
  end

  ########################
  #  dependency_module=  #
  #  dependency_module   #
  ########################

  it 'can set the dependecy module of each member set and retrieve the dependency module of each member set' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.dependency_module.should == [ ::ModuleCluster::Define::Cluster, ::ModuleCluster::Define::Cluster ]
    multi_set.dependency_module = ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01
    multi_set.dependency_module.should == [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01, ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01 ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.dependency_module.should == [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01, ::ModuleCluster::ClusterStack::Set::MultiSetProxy::DependencyModuleMock01, ::ModuleCluster::Define::Cluster, ::ModuleCluster::Define::Cluster ]
  end

  #############
  #  method=  #
  #  method   #
  #############
  
  it 'can set the method of each member set and retrieve the methods of each member set' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.method.should == [ :include_also_includes, :include_also_includes ]
    multi_set.method = :some_other_method
    multi_set.method.should == [ :some_other_method, :some_other_method ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.method.should == [ :some_other_method, :some_other_method, :include_also_includes, :include_also_includes ]
  end

  ###################################
  #  module_class_instance_or_all=  #
  #  module_class_instance_or_all   #
  ###################################
  
  it 'can set the object to which set applies for each member set and retrieve the objects to which sets apply for all member sets' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.module_class_instance_or_all.should == [ :all, :all ]
    multi_set.module_class_instance_or_all = :module
    multi_set.module_class_instance_or_all.should == [ :module, :module ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.module_class_instance_or_all.should == [ :module, :module, :all, :all ]
  end

  ########################
  #  include_or_extend=  #
  #  include_or_extend   #
  ########################
  
  it 'can set whether set should be used to include, extend, or both and retrieve whether member sets are to be included, extended, or both' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.include_or_extend.should == [ :include_also_includes, :include_also_includes ]
    multi_set.include_or_extend = :module
    multi_set.include_or_extend.should == [ :module, :module ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.include_or_extend.should == [ :module, :module, :include_also_includes, :include_also_includes ]
  end
  
  ##############
  #  modules=  #
  #  modules   #
  ##############

  it 'can set the modules of each member set and retrieve the modules of each member set' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.modules.should == [ [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ] ]
    multi_set.modules = [ Module ]
    multi_set.modules.should == [ [ Module ], [ Module ] ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.modules.should == [ [ Module ], [ Module ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ] ]
    set_five = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    multi_multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_multi_set, set_five )
    multi_multi_set_two.modules.should == [ [ Module ], [ Module ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ] ]
  end

  ########################################
  #  runtime_includes_or_extends_block=  #
  #  runtime_includes_or_extends_block   #
  ########################################
  
  it 'can set the block for runtime determination of modules for each member set and retrieve the block from each member set' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    runtime_block = Proc.new { Module }
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], runtime_block )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], runtime_block )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.runtime_includes_or_extends_block.should == [ runtime_block, runtime_block ]
    other_block = Proc.new { Kernel }
    multi_set.runtime_includes_or_extends_block = other_block
    multi_set.runtime_includes_or_extends_block.should == [ other_block, other_block ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], runtime_block )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], runtime_block )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.runtime_includes_or_extends_block.should == [ other_block, other_block, runtime_block, runtime_block ]
  end

  ################
  #  suspended=  #
  #  suspended   #
  #  suspend     #
  #  suspended?  #
  #  resume      #
  ################

  it 'can suspend and resume each member set and retrieve whether member sets are suspended' do
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.suspended.should == [ false, false ]
    multi_set.suspended?.should == [ false, false ]
    multi_set.suspended = true
    multi_set.suspended.should == [ true, true ]
    multi_set.resume
    multi_set.suspended.should == [ false, false ]
    multi_set.suspend
    multi_set.suspended.should == [ true, true ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_set_two.suspended.should == [ false, false ]
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.suspended?.should == [ true, true, false, false ]
  end

  ################
  #  hooks_with  #
  ################

  it 'can return hooks in the set matching the description' do
    
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    block_one = Proc.new do
      puts 'nothing'
    end
    block_two = Proc.new do
      puts 'more nothing'
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], block_one )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :instance, :extend, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], block_two )
    set_one.name = :name_one
    set_two.name = :name_two_and_three
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.suspended.should == [ false, false ]
    multi_set.suspended?.should == [ false, false ]
    multi_set.suspended = true
    multi_set.suspended.should == [ true, true ]
    multi_set.resume
    multi_set.suspended.should == [ false, false ]
    multi_set.suspend
    multi_set.suspended.should == [ true, true ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    block_four = Proc.new do
      puts 'another nothing'
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :class, :include_and_extend, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :module, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], block_four )
    set_three.name = :name_two_and_three
    set_four.name = :name_four
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_set_two.suspended.should == [ false, false ]
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    
    # dependency_module
    multi_set.hooks_with( :dependency_module => ::ModuleCluster::Define::Cluster ).should == [ set_one, set_two ]
    multi_set_two.hooks_with( :dependency_module => ::ModuleCluster::Define::Cluster ).should == [ set_three, set_four ]
    multi_multi_set.hooks_with( :dependency_module => ::ModuleCluster::Define::Cluster ).should == [ set_one, set_two, set_three, set_four ]
    
    # method
    multi_set.hooks_with( :method => :include_also_includes ).should == [ set_one, set_two ]
    multi_set_two.hooks_with( :method => :include_also_includes ).should == [ set_three, set_four ]
    multi_multi_set.hooks_with( :method => :include_also_includes ).should == [ set_one, set_two, set_three, set_four ]
    
    # module_class_instance_or_all
    multi_set.hooks_with( :module_class_instance_or_all => :all ).should == [ set_one ]
    multi_set.hooks_with( :module_class_instance_or_all => :instance ).should == [ set_one, set_two ]
    multi_set_two.hooks_with( :module_class_instance_or_all => :class ).should == [ set_three ]
    multi_multi_set.hooks_with( :module_class_instance_or_all => :module ).should == [ set_one, set_four ]
    
    # include_or_extend
    multi_set.hooks_with( :include_or_extend => :include ).should == [ set_one ]
    multi_set.hooks_with( :include_or_extend => :extend ).should == [ set_two ]
    multi_set_two.hooks_with( :include_or_extend => :include ).should == [ set_three, set_four ]
    multi_multi_set.hooks_with( :include_or_extend => :extend ).should == [ set_two, set_three ]
    multi_multi_set.hooks_with( :include_or_extend => :include ).should == [ set_one, set_three, set_four ]
    
    # modules
    multi_set.hooks_with( :modules => ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ).should == [ set_one ]
    multi_set.hooks_with( :modules => [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ] ).should == [ set_two ]
    multi_set_two.hooks_with( :modules => [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ] ).should == [ set_three ]
    multi_multi_set.hooks_with( :modules => ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ).should == [ set_one ]
    multi_multi_set.hooks_with( :modules => [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ] ).should == [ set_four ]
    
    # runtime_includes_or_extends_block
    multi_set.hooks_with( :runtime_includes_or_extends_block => block_one ).should == [ set_one ]
    multi_set.hooks_with( :runtime_includes_or_extends_block => block_two ).should == [ set_two ]
    multi_set_two.hooks_with( :runtime_includes_or_extends_block => block_four ).should == [ set_four ]
    multi_set_two.hooks_with( :runtime_includes_or_extends_block => nil ).should == [ set_three ]
    multi_multi_set.hooks_with( :runtime_includes_or_extends_block => block_four ).should == [ set_four ]
    multi_multi_set.hooks_with( :runtime_includes_or_extends_block => block_one ).should == [ set_one ]
    multi_multi_set.hooks_with( :runtime_includes_or_extends_block => nil ).should == [ set_three ]
    
    # suspended
    multi_set.hooks_with( :suspended => false ).should == [ ]
    multi_set.hooks_with( :suspended => true ).should == [ set_one, set_two ]
    multi_set_two.hooks_with( :suspended => false ).should == [ set_three, set_four ]
    multi_multi_set.hooks_with( :suspended => true ).should == [ set_one, set_two ]
    multi_multi_set.hooks_with( :suspended => false ).should == [ set_three, set_four ]
    
    # name
    multi_set.hooks_with( :name => :name_one ).should == [ set_one ]
    multi_set.hooks_with( :name => :name_two_and_three ).should == [ set_two ]
    multi_set_two.hooks_with( :name => :name_two_and_three ).should == [ set_three ]
    multi_multi_set.hooks_with( :name => :name_two_and_three ).should == [ set_two, set_three ]
    multi_multi_set.hooks_with( :name => :name_four ).should == [ set_four ]
    
    # we've ensured individual descriptions work, now we just need to make sure the logic loops
    # since each works individually, if the loop works then any loop should work
    #
    # name x include_or_extend
    multi_set.hooks_with( :name => :name_one, 
                          :include_or_extend => :extend ).should == [ ]
    multi_set.hooks_with( :name => :name_two_and_three, 
                          :include_or_extend => :extend ).should == [ set_two ]
    multi_set_two.hooks_with( :name => :name_two_and_three, 
                              :include_or_extend => :include ).should == [ set_three ]
    multi_multi_set.hooks_with( :name => :name_two_and_three, 
                                :include_or_extend => :include ).should == [ set_three ]
    multi_multi_set.hooks_with( :name => :name_four, 
                                :include_or_extend => :include ).should == [ set_four ]
    
  end

  ###########
  #  hooks  #
  ###########

  it 'can return a hook or set of hooks in set matching name' do

    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02
    end
    set_one = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock01 ], nil )
    set_two = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock02 ], nil )
    set_one.name = :some_name
    set_two.name = :some_other_name
    multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_one, set_two )
    multi_set.name.should == [ :some_name, :some_other_name ]
    multi_set.name = :yet_another_other_name
    multi_set.name.should == [ :yet_another_other_name, :yet_another_other_name ]
    # also make sure it works nested in another MultiSetProxy
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03
    end
    module ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04
    end
    set_three = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock03 ], nil )
    set_four = ::ModuleCluster::ClusterStack::Set.new( ::ModuleCluster::Define::Cluster, :include_also_includes, :all, :include, [ ::ModuleCluster::ClusterStack::Set::MultiSetProxy::Mock04 ], nil )
    set_three.name = :some_name
    set_four.name = :some_other_name
    multi_set_two = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( set_three, set_four )
    multi_multi_set = ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( multi_set, multi_set_two )
    multi_multi_set.name.should == [ :yet_another_other_name, :yet_another_other_name, :some_name, :some_other_name ]

    multi_set.hooks( :yet_another_other_name ).should == [ set_one, set_two ]
    multi_set_two.hooks( :some_name ).should == [ set_three ]
    multi_set_two.hooks( :some_other_name ).should == [ set_four ]
    multi_multi_set.hooks( :yet_another_other_name ).should == [ set_one, set_two ]
    multi_multi_set.hooks( :some_name ).should == [ set_three ]
    multi_multi_set.hooks( :some_other_name ).should == [ set_four ]
    
  end
  
end
