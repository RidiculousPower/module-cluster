
require_relative '../../lib/module-cluster.rb'

describe ModuleCluster::IncludeExtendSupport do
  
  ############################################
	#  set_includes_for_class_or_module        #
	#  includes_for_class_or_module_inclusion  #
	############################################

	it 'can set and return includes for a class or module' do
	  module ModuleCluster::IncludeExtendSupport::Mock01
	    extend ModuleCluster::IncludeExtendSupport
      module MockModule1
      end
      module MockModule2
      end
    end
	  class ModuleCluster::IncludeExtendSupport::MockClass
	    includes = [ ModuleCluster::IncludeExtendSupport::Mock01::MockModule1,
	                 ModuleCluster::IncludeExtendSupport::Mock01::MockModule2 ]
	    ModuleCluster::IncludeExtendSupport::Mock01.set_includes_for_class_or_module( self, includes )
    end
  end

	###########################################
	#  set_extends_for_class_or_module        #
	#  extends_for_class_or_module_extension  #
	###########################################
	
	it 'can set and return extends for a class or module' do
	  module ModuleCluster::IncludeExtendSupport::Mock02
	    extend ModuleCluster::IncludeExtendSupport
      module MockModule1
      end
      module MockModule2
      end
    end
	  class ModuleCluster::IncludeExtendSupport::MockClass
	    includes = [ ModuleCluster::IncludeExtendSupport::Mock02::MockModule1,
	                 ModuleCluster::IncludeExtendSupport::Mock02::MockModule2 ]
	    ModuleCluster::IncludeExtendSupport::Mock02.set_includes_for_class_or_module( self, includes )
    end	  
  end
  
end
