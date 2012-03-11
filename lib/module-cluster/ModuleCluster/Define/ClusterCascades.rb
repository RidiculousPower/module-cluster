
module ::ModuleCluster::Define::ClusterCascades

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks

  extend ::ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    return true
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( hooked_instance )
    return true
  end

	###############################
	#  include_cascades_includes  #
	###############################

	def include_cascades_includes( *includes, & runtime_includes_block )
	  return cluster_stack.include_includes( ::ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
	end
	
	##############################
	#  include_cascades_extends  #
	##############################

	def include_cascades_extends( *extends, & runtime_extends_block )
	  return cluster_stack.include_extends( ::ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
	end
	
	###########################################
	#  include_cascades_includes_and_extends  #
	###########################################

	def include_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.include_includes_and_extends( ::ModuleCluster::Define::ClusterCascades, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	##############################
	#  extend_cascades_includes  #
	##############################

	def extend_cascades_includes( *includes, & runtime_includes_block )
	  return cluster_stack.extend_includes( ::ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
	end
	
	#############################
	#  extend_cascades_extends  #
	#############################

	def extend_cascades_extends( *extends, & runtime_extends_block )
	  return cluster_stack.extend_extends( ::ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
	end
	
	##########################################
	#  extend_cascades_includes_and_extends  #
	##########################################

	def extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.extend_includes_and_extends( ::ModuleCluster::Define::ClusterCascades, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	##########################################
	#  include_cascades_prepend_includes  #
	##########################################

	def include_cascades_prepend_includes( *includes, & runtime_includes_block )
	  return cluster_stack.include_prepends_includes( ::ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
	end
	
	#########################################
	#  include_cascades_prepend_extends  #
	#########################################

	def include_cascades_prepend_extends( *extends, & runtime_extends_block )
	  return cluster_stack.include_prepends_extends( ::ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
	end
	
	######################################################
	#  include_cascades_prepend_includes_and_extends  #
	######################################################

	def include_cascades_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = include_cascades_prepend_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = include_cascades_prepend_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	#########################################
	#  extend_cascades_prepend_includes  #
	#########################################

	def extend_cascades_prepend_includes( *includes, & runtime_includes_block )
	  return cluster_stack.extend_prepends_includes( ::ModuleCluster::Define::ClusterCascades, __method__, includes, runtime_includes_block )
	end
	
	########################################
	#  extend_cascades_prepend_extends  #
	########################################

	def extend_cascades_prepend_extends( *extends, & runtime_extends_block )
	  return cluster_stack.extend_prepends_extends( ::ModuleCluster::Define::ClusterCascades, __method__, extends, runtime_extends_block )
	end
	
	#####################################################
	#  extend_cascades_prepend_includes_and_extends  #
	#####################################################

	def extend_cascades_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = extend_cascades_prepend_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = extend_cascades_prepend_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	#########################################
	#  include_or_extend_cascades_includes  #
	#########################################

  def include_or_extend_cascades_includes( *includes, & runtime_includes_block )
    include_set = include_cascades_includes( *includes, & runtime_includes_block )
    extend_set = extend_cascades_includes( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	########################################
	#  include_or_extend_cascades_extends  #
	########################################

  def include_or_extend_cascades_extends( *extends, & runtime_extends_block )
    include_set = include_cascades_extends( *extends, & runtime_extends_block )
    extend_set = extend_cascades_extends( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	#####################################################
	#  include_or_extend_cascades_includes_and_extends  #
	#####################################################

  def include_or_extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = include_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = extend_cascades_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	####################################################
	#  include_or_extend_cascades_prepend_includes  #
	####################################################

  def include_or_extend_cascades_prepend_includes( *includes, & runtime_includes_block )
    include_set = include_cascades_includes( *includes, & runtime_includes_block )
    extend_set = extend_cascades_includes( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	###################################################
	#  include_or_extend_cascades_prepend_extends  #
	###################################################

  def include_or_extend_cascades_prepend_extends( *extends, & runtime_extends_block )
    include_set = include_cascades_prepend_extends( *extends, & runtime_extends_block )
    extend_set = extend_cascades_prepend_extends( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	################################################################
	#  include_or_extend_cascades_prepend_includes_and_extends  #
	################################################################

  def include_or_extend_cascades_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = include_cascades_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = extend_cascades_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

end
