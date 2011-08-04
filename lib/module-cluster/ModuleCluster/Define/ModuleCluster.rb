
module ModuleCluster::Define::ModuleCluster
  
  include ModuleCluster::Define::AnonymousModule
  
  ########################
  #  self.include_block  #
  ########################
  
  def self.include_block( *includes )
    return Proc.new do
      unless ( includes -= ancestors ).empty?
        include( *includes.reverse )
      end
    end
  end

  #######################
  #  self.extend_block  #
  #######################
  
  def self.extend_block( *extends )
    return Proc.new do
      eigenclass = class << self ; self ; end
      unless ( extends -= eigenclass.ancestors ).empty?
        extend( *extends.reverse )
      end
    end
  end
  
	###########################
	#  include_also_includes  #
	###########################

	def include_also_includes( *includes )
	  includes_module = anonymous_module_for_included( & ModuleCluster::Define::ModuleCluster.include_block( *includes ) )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##########################
	#  include_also_extends  #
	##########################
	
	def include_also_extends( *extends )
	  extends_module = anonymous_module_for_included( & ModuleCluster::Define::ModuleCluster.extend_block( *extends ) )
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_extended( & ModuleCluster::Define::ModuleCluster.include_block( *includes ) )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#########################
	#  extend_also_extends  #
	#########################
	
	def extend_also_extends( *extends )
	  extends_module = anonymous_module_for_extended( & ModuleCluster::Define::ModuleCluster.extend_block( *extends ) )
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_append_features( & ModuleCluster::Define::ModuleCluster.include_block( *includes ) )
    clusterstack_module { include( includes_module ) }
		return self
	end

	##############################
	#  include_prepends_extends  #
	##############################
	
	def include_prepends_extends( *extends )
	  extends_module = anonymous_module_for_append_features( & ModuleCluster::Define::ModuleCluster.extend_block( *extends ) )
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_extend_object( & ModuleCluster::Define::ModuleCluster.include_block( *includes ) )
    clusterstack_module { include( includes_module ) }
		return self
	end

	#############################
	#  extend_prepends_extends  #
	#############################
	
	def extend_prepends_extends( *extends )
	  extends_module = anonymous_module_for_extend_object( & ModuleCluster::Define::ModuleCluster.extend_block( *extends ) )
    clusterstack_module { include( extends_module ) }
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
