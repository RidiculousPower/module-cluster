
module ModuleCluster

	############################
	#  define_module_included  #
	############################

	def define_module_included( & include_extend_block )
		inclusion_array, extension_array = yield_for_includes_extends( Array::ClassOrModule.new, Array::ClassOrModule.new, include_extend_block )
		ModuleCluster::IncludeSupport.add_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::IncludeSupport.add_extends_for_class_or_module( self, extension_array )
		extend ModuleCluster::IncludeSupport
		return self
	end

	############################
	#  define_module_extended  #
	############################
	
	def define_module_extended( & include_extend_block )
		inclusion_array, extension_array = yield_for_includes_extends( Array::ClassOrModule.new, Array::ClassOrModule.new, include_extend_block )
		ModuleCluster::ExtendSupport.add_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::ExtendSupport.add_extends_for_class_or_module( self, extension_array )
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

	#####################################
	#  define_module_included_cascades  #
	#####################################

	def define_module_included_cascades( & include_extend_block )
		# any time we are included or extended in a module we want to add cascading extends:
		# * to the module cascading includes
		# any time we are included in a class we want to add cascading extends
		# * to the class
		inclusion_array, extension_array = yield_for_includes_extends( Array::CascadeToClassOrModule.new, Array::CascadeToClassOrModule.new, include_extend_block )
		ModuleCluster::IncludeSupport.add_cascading_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::IncludeSupport.add_cascading_extends_for_class_or_module( self, extension_array )
		extend ModuleCluster::IncludeSupport
		return inclusion_array, extension_array
	end
	
	#####################################
	#  define_module_extended_cascades  #
	#####################################

	def define_module_extended_cascades( & include_extend_block )
		# any time we are included or extended in a module we want to add cascading extends:
		# * to the module cascading extends
		# any time we are extended in a class we want to add cascading extends
		# * to the class
		inclusion_array, extension_array = yield_for_includes_extends( Array::CascadeToClassOrModule.new, Array::CascadeToClassOrModule.new, include_extend_block )
		ModuleCluster::ExtendSupport.add_cascading_includes_for_class_or_module( self, inclusion_array )
		ModuleCluster::ExtendSupport.add_cascading_extends_for_class_or_module( self, extension_array )
		extend ModuleCluster::ExtendSupport
		return inclusion_array, extension_array
	end
	
	####################################
	#  define_module_cluster_cascades  #
	####################################

	def define_module_cluster_cascades( & include_extend_block )
		include_includes, include_extends = define_module_included_cascades( & include_extend_block )
		extend_includes, extend_extends = define_module_extended_cascades( & include_extend_block )
		ModuleCluster::IncludeSupport.set_as_cluster( self, include_includes, include_extends )
		ModuleCluster::ExtendSupport.set_as_cluster( self, extend_includes, extend_extends )
		return self
	end

	##############################################
	#  define_module_included_cascades_to_class  #
	##############################################

	def define_module_included_cascades_to_class( & include_extend_block )
		# any time we are included or extended in a module we want to add cascading extends:
		# * to the module cascading includes
		# any time we are included in a class we want to add cascading extends
		# * to the class
		inclusion_array, extension_array = yield_for_includes_extends( Array::CascadeToClass.new, Array::CascadeToClass.new, include_extend_block )
		ModuleCluster::IncludeSupport.add_cascading_includes_for_class( self, inclusion_array )
		ModuleCluster::IncludeSupport.add_cascading_extends_for_class( self, extension_array )
		extend ModuleCluster::IncludeSupport
		return inclusion_array, extension_array
	end
	
	##############################################
	#  define_module_extended_cascades_to_class  #
	##############################################

	def define_module_extended_cascades_to_class( & include_extend_block )
		# any time we are included or extended in a module we want to add cascading extends:
		# * to the module cascading extends
		# any time we are extended in a class we want to add cascading extends
		# * to the class
		inclusion_array, extension_array = yield_for_includes_extends( Array::CascadeToClass.new, Array::CascadeToClass.new, include_extend_block )
		ModuleCluster::ExtendSupport.add_cascading_includes_for_class( self, inclusion_array )
		ModuleCluster::ExtendSupport.add_cascading_extends_for_class( self, extension_array )
		extend ModuleCluster::ExtendSupport
		return inclusion_array, extension_array
	end
	
	#############################################
	#  define_module_cluster_cascades_to_class  #
	#############################################

	def define_module_cluster_cascades_to_class( & include_extend_block )
		include_includes, include_extends = define_module_included_cascades_to_class( & include_extend_block )
		extend_includes, extend_extends = define_module_extended_cascades_to_class( & include_extend_block )
		ModuleCluster::IncludeSupport.set_as_cluster( self, include_includes, include_extends )
		ModuleCluster::ExtendSupport.set_as_cluster( self, extend_includes, extend_extends )
		return self
	end
	
end
