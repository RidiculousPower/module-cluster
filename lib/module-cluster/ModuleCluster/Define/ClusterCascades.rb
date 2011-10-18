
module ModuleCluster::Define::ClusterCascades

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
    class_or_module.instance_eval do
      unless is_a?( Class )
        extend ModuleCluster::Define::ClusterCascades
        __send__( method, *modules )
      end
    end
  end

	###############################
	#  include_cascades_includes  #
	###############################

	def include_cascades_includes( *includes, & runtime_includes_block )
	  cluster_stack.include_includes( ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
		return self
	end
	
	##############################
	#  include_cascades_extends  #
	##############################

	def include_cascades_extends( *extends, & runtime_extends_block )
	  cluster_stack.include_extends( ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
		return self
	end
	
	###########################################
	#  include_cascades_includes_and_extends  #
	###########################################

	def include_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_cascades_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		include_cascades_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	##############################
	#  extend_cascades_includes  #
	##############################

	def extend_cascades_includes( *includes, & runtime_includes_block )
	  cluster_stack.extend_includes( ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
		return self
	end
	
	#############################
	#  extend_cascades_extends  #
	#############################

	def extend_cascades_extends( *extends, & runtime_extends_block )
	  cluster_stack.extend_extends( ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
		return self
	end
	
	##########################################
	#  extend_cascades_includes_and_extends  #
	##########################################

	def extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_cascades_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_cascades_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	##########################################
	#  include_cascades_prepending_includes  #
	##########################################

	def include_cascades_prepending_includes( *includes, & runtime_includes_block )
	  cluster_stack.include_prepends_includes( ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
		return self
	end
	
	#########################################
	#  include_cascades_prepending_extends  #
	#########################################

	def include_cascades_prepending_extends( *extends, & runtime_extends_block )
	  cluster_stack.include_prepends_extends( ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
		return self
	end
	
	######################################################
	#  include_cascades_prepending_includes_and_extends  #
	######################################################

	def include_cascades_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_cascades_prepending_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		include_cascades_prepending_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	#########################################
	#  extend_cascades_prepending_includes  #
	#########################################

	def extend_cascades_prepending_includes( *includes, & runtime_includes_block )
	  cluster_stack.extend_prepends_includes( ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
		return self
	end
	
	########################################
	#  extend_cascades_prepending_extends  #
	########################################

	def extend_cascades_prepending_extends( *extends, & runtime_extends_block )
	  cluster_stack.extend_prepends_extends( ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
		return self
	end
	
	#####################################################
	#  extend_cascades_prepending_includes_and_extends  #
	#####################################################

	def extend_cascades_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_cascades_prepending_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_cascades_prepending_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
	end

	#########################################
	#  include_or_extend_cascades_includes  #
	#########################################

  def include_or_extend_cascades_includes( *includes, & runtime_includes_block )
    include_cascades_includes( *includes, & runtime_includes_block )
    extend_cascades_includes( *includes, & runtime_includes_block )
		return self
  end

	########################################
	#  include_or_extend_cascades_extends  #
	########################################

  def include_or_extend_cascades_extends( *extends, & runtime_extends_block )
    include_cascades_extends( *extends, & runtime_extends_block )
    extend_cascades_extends( *extends, & runtime_extends_block )
		return self
  end

	#####################################################
	#  include_or_extend_cascades_includes_and_extends  #
	#####################################################

  def include_or_extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

	####################################################
	#  include_or_extend_cascades_prepending_includes  #
	####################################################

  def include_or_extend_cascades_prepending_includes( *includes, & runtime_includes_block )
    include_cascades_includes( *includes, & runtime_includes_block )
    extend_cascades_includes( *includes, & runtime_includes_block )
		return self
  end

	###################################################
	#  include_or_extend_cascades_prepending_extends  #
	###################################################

  def include_or_extend_cascades_prepending_extends( *extends, & runtime_extends_block )
    include_cascades_prepending_extends( *extends, & runtime_extends_block )
    extend_cascades_prepending_extends( *extends, & runtime_extends_block )
		return self
  end

	################################################################
	#  include_or_extend_cascades_prepending_includes_and_extends  #
	################################################################

  def include_or_extend_cascades_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_cascades_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_cascades_prepending_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

end
