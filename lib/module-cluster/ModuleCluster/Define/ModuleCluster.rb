
module ModuleCluster::Define::ModuleCluster

	###########################
	#  include_also_includes  #
	###########################

	def include_also_includes( *includes )
	  includes_module = anonymous_module_included( :include, *includes )
    clusterstack_module do
      include( includes_module )
    end
		return self
	end
	
	##########################
	#  include_also_extends  #
	##########################
	
	def include_also_extends( *extends )
	  extends_module = anonymous_module_included( :extend, *extends )
    clusterstack_module do
      include( extends_module )
    end
		return self
	end
	
	#######################################
	#  include_also_includes_and_extends  #
	#######################################

	def include_also_includes_and_extends( *includes_and_extends )
		include_also_includes( *includes_and_extends )
		include_also_extends( *includes_and_extends )
		return self
	end

	##########################
	#  extend_also_includes  #
	##########################

	def extend_also_includes( *includes )
	  includes_module = anonymous_module_extended( :include, *includes )
    clusterstack_module do
      include( includes_module )
    end
		return self
	end
	
	#########################
	#  extend_also_extends  #
	#########################
	
	def extend_also_extends( *extends )
	  extends_module = anonymous_module_extended( :extend, *extends )
    clusterstack_module do
      include( extends_module )
    end
		return self
	end
	
	######################################
	#  extend_also_includes_and_extends  #
	######################################

	def extend_also_includes_and_extends( *includes_and_extends )
		extend_also_includes( *includes_and_extends )
		extend_also_extends( *includes_and_extends )
		return self
	end

	###############################
	#  include_prepends_includes  #
	###############################

	def include_prepends_includes( *includes )
	  includes_module = anonymous_module_append_features( :include, *includes )
    clusterstack_module do
      include( includes_module )
    end
		return self
	end

	##############################
	#  include_prepends_extends  #
	##############################
	
	def include_prepends_extends( *extends )
	  extends_module = anonymous_module_append_features( :extend, *extends )
    clusterstack_module do
      include( extends_module )
    end
		return self
	end
	
	###########################################
	#  include_prepends_includes_and_extends  #
	###########################################

	def include_prepends_includes_and_extends( *includes_and_extends )
		include_prepends_includes( *includes_and_extends )
		include_prepends_extends( *includes_and_extends )
		return self
	end

	##############################
	#  extend_prepends_includes  #
	##############################

	def extend_prepends_includes( *includes )
	  includes_module = anonymous_module_extend_object( :include, *includes )
    clusterstack_module do
      include( includes_module )
    end
		return self
	end

	#############################
	#  extend_prepends_extends  #
	#############################
	
	def extend_prepends_extends( *extends )
	  extends_module = anonymous_module_extend_object( :extend, *extends )
    clusterstack_module do
      include( extends_module )
    end
		return self
	end
	
	##########################################
	#  extend_prepends_includes_and_extends  #
	##########################################

	def extend_prepends_includes_and_extends( *includes_and_extends )
		extend_prepends_includes( *includes_and_extends )
		extend_prepends_extends( *includes_and_extends )
		return self
	end

end
