
module ModuleCluster::Define::Cluster

  include ModuleCluster::Define::ClusterStack
  
  extend ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( class_or_module )
    return true
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return true
  end
  
  ###########################
  #  self.perform_cascades  #
  ###########################
  
  def self.perform_cascades( class_or_module, method, modules )
    # nothing required
  end
  
	###########################
	#  include_also_includes  #
	###########################

	def include_also_includes( *includes, & runtime_includes_block )
	  cluster_stack.include_includes( ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
		return self
	end
	
	##########################
	#  include_also_extends  #
	##########################
	
	def include_also_extends( *extends, & runtime_extends_block )
	  cluster_stack.include_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	#######################################
	#  include_also_includes_and_extends  #
	#######################################

	def include_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_also_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		include_also_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	##########################
	#  extend_also_includes  #
	##########################

	def extend_also_includes( *includes, & runtime_includes_block )
	  cluster_stack.extend_includes( ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
		return self
	end
	
	#########################
	#  extend_also_extends  #
	#########################
	
	def extend_also_extends( *extends, & runtime_extends_block )
	  cluster_stack.extend_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	######################################
	#  extend_also_includes_and_extends  #
	######################################

	def extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_also_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_also_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	###############################
	#  include_prepends_includes  #
	###############################

	def include_prepends_includes( *includes, & runtime_includes_block )
	  cluster_stack.include_prepends_includes( ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
		return self
	end

	##############################
	#  include_prepends_extends  #
	##############################
	
	def include_prepends_extends( *extends, & runtime_extends_block )
	  cluster_stack.include_prepends_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	###########################################
	#  include_prepends_includes_and_extends  #
	###########################################

	def include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_prepends_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		include_prepends_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	##############################
	#  extend_prepends_includes  #
	##############################

	def extend_prepends_includes( *includes, & runtime_includes_block )
	  cluster_stack.extend_prepends_includes( ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
		return self
	end

	#############################
	#  extend_prepends_extends  #
	#############################
	
	def extend_prepends_extends( *extends, & runtime_extends_block )
	  cluster_stack.extend_prepends_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	##########################################
	#  extend_prepends_includes_and_extends  #
	##########################################

	def extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_prepends_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_prepends_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end
	
	#####################################
	#  include_or_extend_also_includes  #
	#####################################

  def include_or_extend_also_includes( *includes, & runtime_includes_block )
    include_also_includes( *includes, & runtime_includes_block )
    extend_also_includes( *includes, & runtime_includes_block )
		return self
  end

	####################################
	#  include_or_extend_also_extends  #
	####################################

  def include_or_extend_also_extends( *extends, & runtime_extends_block )
    include_also_extends( *extends, & runtime_extends_block )
    extend_also_extends( *extends, & runtime_extends_block )
		return self
  end

	#################################################
	#  include_or_extend_also_includes_and_extends  #
	#################################################

  def include_or_extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

	#########################################
	#  include_or_extend_prepends_includes  #
	#########################################

  def include_or_extend_prepends_includes( *includes, & runtime_includes_block )
    include_prepends_includes( *includes, & runtime_includes_block )
    extend_prepends_includes( *includes, & runtime_includes_block )
		return self
  end

	########################################
	#  include_or_extend_prepends_extends  #
	########################################

  def include_or_extend_prepends_extends( *extends, & runtime_extends_block )
    include_prepends_extends( *extends, & runtime_extends_block )
    extend_prepends_extends( *extends, & runtime_extends_block )
		return self
  end

	#####################################################
	#  include_or_extend_prepends_includes_and_extends  #
	#####################################################

  def include_or_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

end
