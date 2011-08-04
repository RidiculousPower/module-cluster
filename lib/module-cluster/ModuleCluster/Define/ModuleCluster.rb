
module ModuleCluster::Define::ModuleCluster
  
  include ModuleCluster::Define::AnonymousModule
  
	###########################
	#  include_also_includes  #
	###########################

	def include_also_includes( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_included do
        include( *includes.reverse )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	##########################
	#  include_also_extends  #
	##########################
	
	def include_also_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_included do
        extend( *extends.reverse )
      end
      clusterstack_module { include( extends_module ) }
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
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extended do
        include( *includes.reverse )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	#########################
	#  extend_also_extends  #
	#########################
	
	def extend_also_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extended do
        extend( *extends.reverse )
      end
      clusterstack_module { include( extends_module ) }
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
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_append_features do
        include( *includes.reverse )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end

	##############################
	#  include_prepends_extends  #
	##############################
	
	def include_prepends_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_append_features do
        extend( *extends.reverse )
      end
      clusterstack_module { include( extends_module ) }
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
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extend_object do
        include( *includes.reverse )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end

	#############################
	#  extend_prepends_extends  #
	#############################
	
	def extend_prepends_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extend_object do
        extend( *extends.reverse )
      end
      clusterstack_module { include( extends_module ) }
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
	
	#####################################
	#  include_or_extend_also_includes  #
	#####################################

  def include_or_extend_also_includes( *includes )
    include_also_includes( *includes )
    extend_also_includes( *includes )
		return self
  end

	####################################
	#  include_or_extend_also_extends  #
	####################################

  def include_or_extend_also_extends( *extends )
    include_also_extends( *extends )
    extend_also_extends( *extends )
		return self
  end

	#################################################
	#  include_or_extend_also_includes_and_extends  #
	#################################################

  def include_or_extend_also_includes_and_extends( *includes_and_extends )
    include_prepends_includes_and_extends( *includes_and_extends )
    extend_prepends_includes_and_extends( *includes_and_extends )
		return self
  end

	#########################################
	#  include_or_extend_prepends_includes  #
	#########################################

  def include_or_extend_prepends_includes( *includes )
    include_prepends_includes( *includes )
    extend_prepends_includes( *includes )
		return self
  end

	########################################
	#  include_or_extend_prepends_extends  #
	########################################

  def include_or_extend_prepends_extends( *extends )
    include_prepends_extends( *extends )
    extend_prepends_extends( *extends )
		return self
  end

	#####################################################
	#  include_or_extend_prepends_includes_and_extends  #
	#####################################################

  def include_or_extend_prepends_includes_and_extends( *includes_and_extends )
    include_prepends_includes_and_extends( *includes_and_extends )
    extend_prepends_includes_and_extends( *includes_and_extends )
		return self
  end

end
