
module ModuleCluster::Define::ModuleClusterCascadesToClass

	########################################
	#  include_cascades_includes_to_class  #
	########################################

	def include_cascades_includes_to_class( *includes )
	  includes_module = anonymous_module_cascade_to_class_included( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

	def include_cascades_extends_to_class( *extends )
	  extends_module = anonymous_module_cascade_to_class_included( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	####################################################
	#  include_cascades_includes_and_extends_to_class  #
	####################################################

	def include_cascades_includes_and_extends_to_class( *includes_and_extends )
		include_cascades_includes_to_class( *includes_and_extends )
		include_cascades_extends_to_class( *includes_and_extends )
		return self
	end

	#######################################
	#  extend_cascades_includes_to_class  #
	#######################################

	def extend_cascades_includes_to_class( *includes )
	  includes_module = anonymous_module_cascade_to_class_extended( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

	def extend_cascades_extends_to_class( *extends )
	  extends_module = anonymous_module_cascade_to_class_extended( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	###################################################
	#  extend_cascades_includes_and_extends_to_class  #
	###################################################

	def extend_cascades_includes_and_extends_to_class( *includes_and_extends )
		extend_cascades_includes_to_class( *includes_and_extends )
		extend_cascades_extends_to_class( *includes_and_extends )
		return self
	end

	###################################################
	#  include_cascades_to_class_prepending_includes  #
	###################################################

	def include_cascades_to_class_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_to_class_append_features( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##################################################
	#  include_cascades_to_class_prepending_extends  #
	##################################################

	def include_cascades_to_class_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_to_class_append_features( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	###############################################################
	#  include_cascades_to_class_prepending_includes_and_extends  #
	###############################################################

	def include_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_to_class_prepending_includes( *includes_and_extends )
		include_cascades_to_class_prepending_extends( *includes_and_extends )
		return self
	end

	##################################################
	#  extend_cascades_to_class_prepending_includes  #
	##################################################

	def extend_cascades_to_class_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_to_class_extend_object( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#################################################
	#  extend_cascades_to_class_prepending_extends  #
	#################################################

	def extend_cascades_to_class_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_to_class_extend_object( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	##############################################################
	#  extend_cascades_to_class_prepending_includes_and_extends  #
	##############################################################

	def extend_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_to_class_prepending_includes( *includes_and_extends )
		extend_cascades_to_class_prepending_extends( *includes_and_extends )
		return self
	end

end
