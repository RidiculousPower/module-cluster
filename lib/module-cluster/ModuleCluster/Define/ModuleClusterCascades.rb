
module ModuleCluster::Define::ModuleClusterCascades

	###############################
	#  include_cascades_includes  #
	###############################

	def include_cascades_includes( *includes )
	  includes_module = anonymous_module_cascade_included( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##############################
	#  include_cascades_extends  #
	##############################

	def include_cascades_extends( *extends )
	  extends_module = anonymous_module_cascade_included( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	###########################################
	#  include_cascades_includes_and_extends  #
	###########################################

	def include_cascades_includes_and_extends( *includes_and_extends )
		include_cascades_includes( *includes_and_extends )
		include_cascades_extends( *includes_and_extends )
		return self
	end

	##############################
	#  extend_cascades_includes  #
	##############################

	def extend_cascades_includes( *includes )
	  includes_module = anonymous_module_cascade_extended( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#############################
	#  extend_cascades_extends  #
	#############################

	def extend_cascades_extends( *extends )
	  extends_module = anonymous_module_cascade_extended( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	##########################################
	#  extend_cascades_includes_and_extends  #
	##########################################

	def extend_cascades_includes_and_extends( *includes_and_extends )
		extend_cascades_includes( *includes_and_extends )
		extend_cascades_extends( *includes_and_extends )
		return self
	end

	##########################################
	#  include_cascades_prepending_includes  #
	##########################################

	def include_cascades_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_append_features( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#########################################
	#  include_cascades_prepending_extends  #
	#########################################

	def include_cascades_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_append_features( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	######################################################
	#  include_cascades_prepending_includes_and_extends  #
	######################################################

	def include_cascades_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_prepending_includes( *includes_and_extends )
		include_cascades_prepending_extends( *includes_and_extends )
		return self
	end

	#########################################
	#  extend_cascades_prepending_includes  #
	#########################################

	def extend_cascades_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_extend_object( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	########################################
	#  extend_cascades_prepending_extends  #
	########################################

	def extend_cascades_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_extend_object( :extend, *extends )
    clusterstack_module { extend( extends_module ) }
		return self
	end
	
	#####################################################
	#  extend_cascades_prepending_includes_and_extends  #
	#####################################################

	def extend_cascades_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_prepending_includes( *includes_and_extends )
		extend_cascades_prepending_extends( *includes_and_extends )
		return self
	end

end
