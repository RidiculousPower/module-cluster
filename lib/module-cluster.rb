
module ModuleCluster
	module IncludeSupport
	end
	module ExtendSupport
	end
end

class Array::ClassOrModule < Array
end
class Array::CascadeToClass < Array
end
class Array::CascadeToClassOrModule < Array
end

require_relative 'module-cluster/ModuleCluster.rb'
require_relative 'module-cluster/_private_/ModuleCluster.rb'
require_relative 'module-cluster/ModuleCluster/IncludeExtendSupport.rb'
require_relative 'module-cluster/ModuleCluster/_private_/IncludeExtendSupport.rb'
require_relative 'module-cluster/ModuleCluster/IncludeSupport.rb'
require_relative 'module-cluster/ModuleCluster/ExtendSupport.rb'
