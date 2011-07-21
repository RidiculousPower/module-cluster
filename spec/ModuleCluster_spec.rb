require_relative '../lib/module-cluster.rb'

describe ModuleCluster do

	#############################
	#  define_module_inclusion  #
	#############################

  it 'can define includes and extends for module inclusion' do
    module ModuleCluster::MockInclusion01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_inclusion do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusion01a
      ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == false
      include ModuleCluster::MockInclusion01
      ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockInclusion02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_inclusion do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockInclusion02a
      ancestors.include?( ModuleCluster::MockInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == false
      include ModuleCluster::MockInclusion02
      ancestors.include?( ModuleCluster::MockInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusion03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_inclusion do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusion03a
      ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      include ModuleCluster::MockInclusion03
      ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock3 ).should == true
    end
  end

	#############################
	#  define_module_extension  #
	#############################
	
  it 'can define includes and extends for module extension' do
    module ModuleCluster::MockExtension01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extension do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockExtension01a
      ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == false
      extend ModuleCluster::MockExtension01
      ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockExtension02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extension do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockExtension02a
      ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == false
      extend ModuleCluster::MockExtension02
      ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockExtension03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extension do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockExtension03a
      ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
      extend ModuleCluster::MockExtension03
      ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock3 ).should == true
    end
  end
	
	###########################
	#  define_module_cluster  #
	###########################
	
  it 'can define includes and extends for module extension and inclusion' do
    module ModuleCluster::MockClusterInclusion01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockClusterInclusion01a
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == false
      include ModuleCluster::MockClusterInclusion01
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterInclusion02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockClusterInclusion02a
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock2 ).should == false
      include ModuleCluster::MockClusterInclusion02
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterInclusion03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockClusterInclusion03a
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock2 ).should == false
      include ModuleCluster::MockClusterInclusion03
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock2 ).should == false
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterExtension01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockClusterExtension01a
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == false
      extend ModuleCluster::MockClusterExtension01
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterExtension02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockClusterExtension02a
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == false
      extend ModuleCluster::MockClusterExtension02
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == true
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterExtension03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockClusterExtension03a
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterExtension03
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      eigenclass = class << self ; self ; end
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == true
    end    
  end

end
