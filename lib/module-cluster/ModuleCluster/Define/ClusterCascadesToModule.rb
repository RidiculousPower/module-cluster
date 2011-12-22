
module ModuleCluster::Define::ClusterCascadesToModule

  include ModuleCluster::CascadeFeatures::ClusterStack

  extend ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    return hooked_instance.is_a?( Module ) && ! hooked_instance.is_a?( Class )
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( hooked_instance )
    return hooked_instance.is_a?( Module ) && ! hooked_instance.is_a?( Class )
  end
  
	#########################################
	#  include_cascades_includes_to_module  #
	#########################################

	def include_cascades_includes_to_module( *includes, & runtime_includes_block )
	  cluster_stack.include_includes( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes, runtime_includes_block )
		return self
	end
	
	########################################
	#  include_cascades_extends_to_module  #
	########################################

	def include_cascades_extends_to_module( *extends, & runtime_extends_block )
	  cluster_stack.include_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, extends, runtime_extends_block )
		return self
	end
	
	#####################################################
	#  include_cascades_includes_and_extends_to_module  #
	#####################################################

	def include_cascades_includes_and_extends_to_module( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.include_prepends_includes_and_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	########################################
	#  extend_cascades_includes_to_module  #
	########################################

	def extend_cascades_includes_to_module( *includes, & runtime_includes_block )
	  cluster_stack.extend_includes( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes, runtime_includes_block )
		return self
	end
	
	#######################################
	#  extend_cascades_extends_to_module  #
	#######################################

	def extend_cascades_extends_to_module( *extends, & runtime_extends_block )
	  cluster_stack.extend_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, extends, runtime_extends_block )
		return self
	end
	
	####################################################
	#  extend_cascades_includes_and_extends_to_module  #
	####################################################

	def extend_cascades_includes_and_extends_to_module( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.extend_prepends_includes_and_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	####################################################
	#  include_cascades_to_module_prepending_includes  #
	####################################################

	def include_cascades_to_module_prepending_includes( *includes, & runtime_includes_block )
	  cluster_stack.include_prepends_includes( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes, runtime_includes_block )
		return self
	end
	
	###################################################
	#  include_cascades_to_module_prepending_extends  #
	###################################################

	def include_cascades_to_module_prepending_extends( *extends, & runtime_extends_block )
	  cluster_stack.include_prepends_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, extends, runtime_extends_block )
		return self
	end
	
	################################################################
	#  include_cascades_to_module_prepending_includes_and_extends  #
	################################################################

	def include_cascades_to_module_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.include_prepends_includes_and_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	###################################################
	#  extend_cascades_to_module_prepending_includes  #
	###################################################

	def extend_cascades_to_module_prepending_includes( *includes, & runtime_includes_block )
	  cluster_stack.extend_prepends_includes( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes, runtime_includes_block )
		return self
	end
	
	##################################################
	#  extend_cascades_to_module_prepending_extends  #
	##################################################

	def extend_cascades_to_module_prepending_extends( *extends, & runtime_extends_block )
	  cluster_stack.extend_prepends_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, extends, runtime_extends_block )
		return self
	end
	
	###############################################################
	#  extend_cascades_to_module_prepending_includes_and_extends  #
	###############################################################

	def extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.extend_prepends_includes_and_extends( ModuleCluster::Define::ClusterCascadesToModule, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	###################################################
	#  include_or_extend_cascades_includes_to_module  #
	###################################################

  def include_or_extend_cascades_includes_to_module( *includes, & runtime_includes_block )
    include_cascades_includes_to_module( *includes, & runtime_includes_block )
    extend_cascades_includes_to_module( *includes, & runtime_includes_block )
		return self
  end

	##################################################
	#  include_or_extend_cascades_extends_to_module  #
	##################################################

  def include_or_extend_cascades_extends_to_module( *extends, & runtime_extends_block )
    include_cascades_extends_to_module( *extends, & runtime_extends_block )
    extend_cascades_extends_to_module( *extends, & runtime_extends_block )
		return self
  end

	###############################################################
	#  include_or_extend_cascades_includes_and_extends_to_module  #
	###############################################################

  def include_or_extend_cascades_includes_and_extends_to_module( *includes_and_extends, & runtime_includes_and_extends_block )
    include_cascades_includes_and_extends_to_module( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_cascades_includes_and_extends_to_module( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

	##############################################################
	#  include_or_extend_cascades_to_module_prepending_includes  #
	##############################################################

  def include_or_extend_cascades_to_module_prepending_includes( *includes, & runtime_includes_block )
    include_cascades_to_module_prepending_includes( *includes, & runtime_includes_block )
    extend_cascades_to_module_prepending_includes( *includes, & runtime_includes_block )
		return self
  end

	#############################################################
	#  include_or_extend_cascades_to_module_prepending_extends  #
	#############################################################

  def include_or_extend_cascades_to_module_prepending_extends( *extends, & runtime_extends_block )
    include_cascades_to_module_prepending_extends( *extends, & runtime_extends_block )
    extend_cascades_to_module_prepending_extends( *extends, & runtime_extends_block )
		return self
  end

	##########################################################################
	#  include_or_extend_cascades_to_module_prepending_includes_and_extends  #
	##########################################################################
	
  def include_or_extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_cascades_to_module_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

end
