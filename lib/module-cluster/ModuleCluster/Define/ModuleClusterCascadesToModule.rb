
module ModuleCluster::Define::ModuleClusterCascadesToModule

	#########################################
	#  include_cascades_includes_to_module  #
	#########################################

	def include_cascades_includes_to_module( *includes )
	  includes_module = anonymous_module_cascade_to_module_included( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	########################################
	#  include_cascades_extends_to_module  #
	########################################

	def include_cascades_extends_to_module( *extends )
	  extends_module = anonymous_module_cascade_to_module_included( :extend, *extends )
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	#####################################################
	#  include_cascades_includes_and_extends_to_module  #
	#####################################################

	def include_cascades_includes_and_extends_to_module( *includes_and_extends )
		include_cascades_includes_to_module( *includes_and_extends )
		include_cascades_extends_to_module( *includes_and_extends )
		return self
	end

	########################################
	#  extend_cascades_includes_to_module  #
	########################################

	def extend_cascades_includes_to_module( *includes )
	  includes_module = anonymous_module_cascade_to_module_extended( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#######################################
	#  extend_cascades_extends_to_module  #
	#######################################

	def extend_cascades_extends_to_module( *extends )
	  extends_module = anonymous_module_cascade_to_module_extended( :extend, *extends )
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	####################################################
	#  extend_cascades_includes_and_extends_to_module  #
	####################################################

	def extend_cascades_includes_and_extends_to_module( *includes_and_extends )
		extend_cascades_includes_to_module( *includes_and_extends )
		extend_cascades_extends_to_module( *includes_and_extends )
		return self
	end

	####################################################
	#  include_cascades_to_module_prepending_includes  #
	####################################################

	def include_cascades_to_module_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_to_module_append_features( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	###################################################
	#  include_cascades_to_module_prepending_extends  #
	###################################################

	def include_cascades_to_module_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_to_module_append_features( :extend, *extends )
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	################################################################
	#  include_cascades_to_module_prepending_includes_and_extends  #
	################################################################

	def include_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_to_module_prepending_includes( *includes_and_extends )
		include_cascades_to_module_prepending_extends( *includes_and_extends )
		return self
	end

	###################################################
	#  extend_cascades_to_module_prepending_includes  #
	###################################################

	def extend_cascades_to_module_prepending_includes( *includes )
	  includes_module = anonymous_module_cascade_to_module_extend_object( :include, *includes )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##################################################
	#  extend_cascades_to_module_prepending_extends  #
	##################################################

	def extend_cascades_to_module_prepending_extends( *extends )
	  extends_module = anonymous_module_cascade_to_module_extend_object( :extend, *extends )
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	###############################################################
	#  extend_cascades_to_module_prepending_includes_and_extends  #
	###############################################################

	def extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_to_module_prepending_includes( *includes_and_extends )
		extend_cascades_to_module_prepending_extends( *includes_and_extends )
		return self
	end

end
