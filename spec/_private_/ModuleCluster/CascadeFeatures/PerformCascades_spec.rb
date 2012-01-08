
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::CascadeFeatures::PerformCascades do

  ##########################################
  #  collect_block_runtime_result_modules  #
  ##########################################

  it 'can run a block and return any modules that were returned by the block' do
    # condition is a ModuleCluster-extended module
    module ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule01
    end
    # a module to be included/extended at hook time
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule01
    end
    # another module includes the first module and invokes the runtime hook
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule01
    end
    # we need a mock instance to use our methods
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock01
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module_self = ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule01
    hooked_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule01
    block_ran = false
    runtime_includes_block = Proc.new { block_ran = true ; ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule01 }
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include, nil, runtime_includes_block )
    result_modules = ModuleCluster::CascadeFeatures::PerformCascades::Mock01.collect_block_runtime_result_modules( module_self,
                                                                                                                   hooked_instance,
                                                                                                                   set )
    block_ran.should == true
    result_modules.should == [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule01 ]
  end

  ########################################
  #  should_include_or_extend_instance?  #
  ########################################

  it 'can report whether an instance should be included or extended based on a descriptor symbol' do
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock02
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    end
    class ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    end
    
    module_class_instance_or_all = :all
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_class_or_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_class_and_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_class_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_or_class
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    module_class_instance_or_all = :module_and_class
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    module_class_instance_or_all = :module_class
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    module_class_instance_or_all = :module_or_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_and_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :class_or_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :class_and_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :class_instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    module_class_instance_or_all = :module
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    module_class_instance_or_all = :class
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    module_class_instance_or_all = :instance
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == false
    into_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockClassInstance02.new
    ModuleCluster::CascadeFeatures::PerformCascades::Mock02.should_include_or_extend_instance?( module_class_instance_or_all, into_instance ).should == true
  end

  #######################################
  #  include_or_extend_hooked_instance  #
  #######################################

  it 'can include or extend the hooked instance as appropriate' do
    # condition is a ModuleCluster-extended module
    module ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule03
    end
    # a module to be included/extended at hook time
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03
    end
    # another module includes the first module and invokes the runtime hook
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03A
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03B
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03C
    end
    # we need a mock instance to use our methods
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock03
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module_self = ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule03
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ] )

    # include
    ModuleCluster::CascadeFeatures::PerformCascades::Mock03.include_or_extend_hooked_instance( ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03A, 
                                                                                               set, 
                                                                                               true, 
                                                                                               false, 
                                                                                               set.modules )
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03A.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == true
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03A ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == false
    # extend
    ModuleCluster::CascadeFeatures::PerformCascades::Mock03.include_or_extend_hooked_instance( ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03B, 
                                                                                               set, 
                                                                                               false, 
                                                                                               true, 
                                                                                               set.modules )    
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03B.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == false
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03B ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == true
    # include and extend
    ModuleCluster::CascadeFeatures::PerformCascades::Mock03.include_or_extend_hooked_instance( ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03C, 
                                                                                               set, 
                                                                                               true, 
                                                                                               true, 
                                                                                               set.modules )
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03C.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == true
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule03C ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule03 ).should == true
    
  end

  ##########################################
  #  cascade_modules_into_hooked_instance  #
  ##########################################

  it 'can cascade modules into the hooked instance as appropriate' do
    # condition is a ModuleCluster-extended module
    module ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule04
      def declaration_method( modules )
        @declaration_method_called = true
      end
      def called_declaration_method
        return @declaration_method_called
      end
    end
    # a module to be included/extended at hook time
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule04A
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule04B
    end
    # another module includes the first module and invokes the runtime hook
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule04
    end
    # we need a mock instance to use our methods
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock04
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module_self = ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule04
    hooked_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule04
    block_ran = false
    runtime_includes_block = Proc.new { block_ran = true ; ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule04B }
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule04A ], runtime_includes_block )
    ModuleCluster::CascadeFeatures::PerformCascades::Mock04.cascade_modules_into_hooked_instance( module_self, hooked_instance, set, set.modules )
    # hooked instance should be extended with dependency module (module_self) and :declaration_method should be called on it
    hooked_instance_eigenclass = class << hooked_instance ; self ; end
    hooked_instance_eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule04 ).should == true
    hooked_instance.called_declaration_method.should == true
  end

  ############################
  #  include_extend_modules  #
  ############################

  it 'can perform include and/or extend of specified modules into instance' do
    # condition is a ModuleCluster-extended module
    module ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule05
    end
    # a module to be included/extended at hook time
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05
    end
    # another module includes the first module and invokes the runtime hook
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05A
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05B
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05C
    end
    # we need a mock instance to use our methods
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock05
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module_self = ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule05

    # include
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ] )
    ModuleCluster::CascadeFeatures::PerformCascades::Mock05.include_extend_modules( ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule05, 
                                                                                    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05A, 
                                                                                    set, 
                                                                                    set.modules )
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05A.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == true
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05A ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == false
    # extend
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :extend, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ] )
    ModuleCluster::CascadeFeatures::PerformCascades::Mock05.include_extend_modules( ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule05, 
                                                                                    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05B, 
                                                                                    set, 
                                                                                    set.modules )    
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05B.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == false
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05B ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == true
    # include and extend
    set = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include_and_extend, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ] )
    ModuleCluster::CascadeFeatures::PerformCascades::Mock05.include_extend_modules( ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule05, 
                                                                                    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05C, 
                                                                                    set, 
                                                                                    set.modules )
    ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05C.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == true
    eigenclass = class << ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule05C ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule05 ).should == true
    
  end

  ######################
  #  perform_cascades  #
  ######################

  it 'can perform cascade of specified modules into instance' do

    # condition is a ModuleCluster-extended module
    module ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule06
      def self.should_include_or_extend?( hooked_instance )
        return true
      end
      def self.should_cascade?( hooked_instance )
        return true
      end
      def self.hooks_suspended?( action )
        return @hooks_suspended ||= false
      end
      def self.suspend_hooks
        @hooks_suspended = true
      end
      def self.unsuspend_hooks
        @hooks_suspended = false
      end
      def declaration_method( modules )
        @declaration_method_called = true
      end
      def called_declaration_method
        return @declaration_method_called
      end
    end
    # a module to be included/extended at hook time
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06A
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06B
    end
    module ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C
    end
    # another module includes the first module and invokes the runtime hook
    module ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule06
    end
    # we need a mock instance to use our methods
    module ModuleCluster::CascadeFeatures::PerformCascades::Mock06
      extend ModuleCluster::CascadeFeatures::PerformCascades
    end
    module_self = ModuleCluster::CascadeFeatures::PerformCascades::MockCascadeModule06
    hooked_instance = ModuleCluster::CascadeFeatures::PerformCascades::MockModuleIncludingMockCascadeModule06
    set_one = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06A ] )
    set_two = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :extend, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06B ] )
    set_three = ModuleCluster::ClusterStack::Set.new( module_self, :declaration_method, :all, :include_and_extend, [ ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C ] )
    set_stack = [ set_one, set_two, set_three ]

    # test that suspending works - mocked for true/false
    module_self.suspend_hooks
    ModuleCluster::CascadeFeatures::PerformCascades::Mock06.perform_cascades( module_self, :include, hooked_instance, set_stack )
    hooked_instance.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06A ).should == false
    hooked_instance.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C ).should == false
    eigenclass = class << hooked_instance ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06B ).should == false
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C ).should == false
    # also our dependency module should be extended
    eigenclass.ancestors.include?( module_self ).should == false
    module_self.unsuspend_hooks


    ModuleCluster::CascadeFeatures::PerformCascades::Mock06.perform_cascades( module_self, :include, hooked_instance, set_stack )
    hooked_instance.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06A ).should == true
    hooked_instance.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C ).should == true
    eigenclass = class << hooked_instance ; self ; end
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06B ).should == true
    eigenclass.ancestors.include?( ModuleCluster::CascadeFeatures::PerformCascades::MockHookedIncludeModule06C ).should == true
    # also our dependency module should be extended
    eigenclass.ancestors.include?( module_self ).should == true
    hooked_instance.called_declaration_method.should == true
    
  end

end
