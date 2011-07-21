
module ModuleCluster

	#############################
	#  define_module_included  #
	#############################

	def define_module_included( & block )
		inclusion_array, extension_array = yield_for_includes_extends( block )
		ModuleCluster::IncludeSupport.set_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::IncludeSupport.set_extends_for_class_or_module( self, extension_array )
		extend ModuleCluster::IncludeSupport
		return self
	end

	#############################
	#  define_module_extended  #
	#############################
	
	def define_module_extended( & block )
		inclusion_array, extension_array = yield_for_includes_extends( block )
		ModuleCluster::ExtendSupport.set_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::ExtendSupport.set_extends_for_class_or_module( self, extension_array )
		extend ModuleCluster::ExtendSupport
		return self
	end
	
	###########################
	#  define_module_cluster  #
	###########################

	def define_module_cluster( & include_extend_block )
		define_module_included( & include_extend_block )
		define_module_extended( & include_extend_block )
		return self
	end

end
