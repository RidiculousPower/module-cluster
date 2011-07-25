require_relative '../lib/module-cluster.rb'

describe ModuleCluster do

	############################
	#  define_module_included  #
	############################

  it 'can define includes and extends for module inclusion' do
    module ModuleCluster::MockInclusion01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusion01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock3 ).should == false
      include ModuleCluster::MockInclusion01
      ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion01::Mock2 ).should == false
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
      define_module_included do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockInclusion02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock3 ).should == false
      include ModuleCluster::MockInclusion02
      ancestors.include?( ModuleCluster::MockInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion02::Mock2 ).should == false
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
      define_module_included do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusion03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock3 ).should == false
      include ModuleCluster::MockInclusion03
      ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusion03::Mock3 ).should == true
    end
  end

	############################
	#  define_module_extended  #
	############################
	
  it 'can define includes and extends for module extension' do
    module ModuleCluster::MockExtension01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockExtension01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock3 ).should == false
      extend ModuleCluster::MockExtension01
      ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension01::Mock2 ).should == false
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
      define_module_extended do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    module ModuleCluster::MockExtension02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock3 ).should == false
      extend ModuleCluster::MockExtension02
      ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension02::Mock2 ).should == false
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
      define_module_extended do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockExtension03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock3 ).should == false
      extend ModuleCluster::MockExtension03
      ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtension03::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterInclusion01
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion01::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterInclusion02
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion02::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterInclusion03
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterInclusion03::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterExtension01
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension01::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterExtension02
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension02::Mock2 ).should == false
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
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterExtension03
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterExtension03::Mock3 ).should == true
    end    
  end

	#####################################
	#  define_module_included_cascades  #
	#####################################

  it 'can define includes and extends for module inclusion' do
    module ModuleCluster::MockInclusionCascades01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusionCascades01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades01
      methods.include?( :included ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascades01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades01a
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascades01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascades01a
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades01::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascades02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockInclusionCascades02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades02
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascades02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascades02
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascades02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades02
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascades02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades02a
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascades02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascades02a
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades02::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascades03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockInclusionCascades03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades03
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascades03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascades03
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascades03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades03
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascades03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascades03a
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascades03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascades03a
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascades03::Mock3 ).should == false
    end
  end

	#####################################
	#  define_module_extended_cascades  #
	#####################################
	
  it 'can define includes and extends for module extension' do
    module ModuleCluster::MockExtensionCascades01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockExtensionCascades01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades01
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades01
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascades01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades01
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == true
    end
    class ModuleCluster::MockExtensionCascades01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades01a
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades01a
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades01::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascades02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockExtensionCascades02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades02
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades02
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
    end
    module ModuleCluster::MockExtensionCascades02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades02
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades02a
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades02a
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades02::Mock3 ).should == false
    end
    module ModuleCluster::MockExtensionCascades03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockExtensionCascades03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades03
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades03
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascades03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades03
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == true
    end
    class ModuleCluster::MockExtensionCascades03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascades03a
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascades03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascades03a
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascades03::Mock3 ).should == true
    end
  end
	
	####################################
	#  define_module_cluster_cascades  #
	####################################
	
  it 'can define includes and extends for module extension and inclusion' do
    module ModuleCluster::MockClusterCascadesInclusion01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterCascadesInclusion01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesInclusion01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion01a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion01a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesInclusion02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockClusterCascadesInclusion02Includes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesInclusion02Extends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterCascadesInclusion02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesInclusion02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion02a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesInclusion02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion02a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterCascadesInclusion03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterCascadesInclusion03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesInclusion03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion03aClassInclude
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesInclusion03a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesInclusion03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesInclusion03a
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesInclusion03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesExtension01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterCascadesExtension01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesExtension01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension01a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension01a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesExtension02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockClusterCascadesExtension02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesExtension02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterCascadesExtension02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesExtension02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension02a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterCascadesExtension02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension02a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock1 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock2 ).should == true
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterCascadesExtension03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterCascadesExtension03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterCascadesExtension03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      include ModuleCluster::MockClusterCascadesExtension03a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterCascadesExtension03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterCascadesExtension03a
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterCascadesExtension03::Mock3 ).should == true
    end
  end

	##############################################
	#  define_module_included_cascades_to_class  #
	##############################################

  it 'can define includes and extends for module inclusion' do
    module ModuleCluster::MockInclusionCascadesToClass01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    module ModuleCluster::MockInclusionCascadesToClass01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass01
      methods.include?( :included ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascadesToClass01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass01a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascadesToClass01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascadesToClass01a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass01::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascadesToClass02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockInclusionCascadesToClass02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass02
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascadesToClass02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascadesToClass02
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascadesToClass02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass02
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascadesToClass02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass02a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascadesToClass02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascadesToClass02a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass02::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascadesToClass03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_included_cascades_to_class do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockInclusionCascadesToClass03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass03
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascadesToClass03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascadesToClass03
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
    end
    module ModuleCluster::MockInclusionCascadesToClass03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass03
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
    end
    class ModuleCluster::MockInclusionCascadesToClass03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      include ModuleCluster::MockInclusionCascadesToClass03a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == true
    end
    class ModuleCluster::MockInclusionCascadesToClass03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      extend ModuleCluster::MockInclusionCascadesToClass03a
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockInclusionCascadesToClass03::Mock3 ).should == false
    end
  end

	##############################################
	#  define_module_extended_cascades_to_class  #
	##############################################
	
  it 'can define includes and extends for module extension' do
    module ModuleCluster::MockExtensionCascadesToClass01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockExtensionCascadesToClass01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass01
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass01
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascadesToClass01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass01
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass01a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass01a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass01::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascadesToClass02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockExtensionCascadesToClass02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass02
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass02
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
    end
    module ModuleCluster::MockExtensionCascadesToClass02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass02
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass02a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass02a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass02::Mock3 ).should == false
    end
    module ModuleCluster::MockExtensionCascadesToClass03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_extended_cascades_to_class do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockExtensionCascadesToClass03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass03
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass03
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == true
    end
    module ModuleCluster::MockExtensionCascadesToClass03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass03
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      include ModuleCluster::MockExtensionCascadesToClass03a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
    end
    class ModuleCluster::MockExtensionCascadesToClass03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      extend ModuleCluster::MockExtensionCascadesToClass03a
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockExtensionCascadesToClass03::Mock3 ).should == true
    end
  end
	
	#############################################
	#  define_module_cluster_cascades_to_class  #
	#############################################
	
  it 'can define includes and extends for module extension and inclusion' do
    module ModuleCluster::MockClusterClassCascadesInclusion01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesInclusion01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesInclusion01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesInclusion01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesInclusion01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion01a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesInclusion01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion01a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesInclusion02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesInclusion02Includes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesInclusion02Extends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterClassCascadesInclusion02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesInclusion02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion02a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesInclusion02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion02a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterClassCascadesInclusion03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesInclusion03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesInclusion03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesInclusion03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesInclusion03aClassInclude
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesInclusion03a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesInclusion03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesInclusion03a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesInclusion03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesExtension01
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesExtension01ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesExtension01ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesExtension01a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension01
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesExtension01aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension01a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesExtension01aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension01a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension01::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesExtension02
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        includes.concat [ Mock1, Mock2 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesExtension02ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesExtension02ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterClassCascadesExtension02a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension02
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesExtension02aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension02a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesExtension02aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension02a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == true
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension02::Mock3 ).should == false
    end
    module ModuleCluster::MockClusterClassCascadesExtension03
      extend ModuleCluster
      module Mock1
      end
      module Mock2
      end
      module Mock3
      end
      define_module_cluster_cascades_to_class do |includes, extends|
        extends.concat [ Mock3 ]
      end
    end
    class ModuleCluster::MockClusterClassCascadesExtension03ClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesExtension03ClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == true
    end
    module ModuleCluster::MockClusterClassCascadesExtension03a
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension03
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
    end
    class ModuleCluster::MockClusterClassCascadesExtension03aClassIncludes
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      include ModuleCluster::MockClusterClassCascadesExtension03a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == true
    end
    class ModuleCluster::MockClusterClassCascadesExtension03aClassExtends
      eigenclass = class << self ; self ; end
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      extend ModuleCluster::MockClusterClassCascadesExtension03a
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock1 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock2 ).should == false
      eigenclass.ancestors.include?( ModuleCluster::MockClusterClassCascadesExtension03::Mock3 ).should == true
    end
  end

end
