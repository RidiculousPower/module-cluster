
module ::ModuleCluster::Define::ClusterCascadesToClass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks

  extend ::ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    return hooked_instance.is_a?( Class )
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( hooked_instance )
    return hooked_instance.is_a?( Module ) && ! hooked_instance.is_a?( Class )
  end

	########################################
	#  include_cascades_includes_to_class  #
	########################################

	def include_cascades_includes_to_class( *includes, & runtime_includes_block )
	  return cluster_stack.include_includes( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes, runtime_includes_block )
	end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

	def include_cascades_extends_to_class( *extends, & runtime_extends_block )
	  return cluster_stack.include_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, extends, runtime_extends_block )
	end
	
	####################################################
	#  include_cascades_includes_and_extends_to_class  #
	####################################################

	def include_cascades_includes_and_extends_to_class( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.include_includes_and_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	#######################################
	#  extend_cascades_includes_to_class  #
	#######################################

	def extend_cascades_includes_to_class( *includes, & runtime_includes_block )
	  return cluster_stack.extend_includes( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes, runtime_includes_block )
	end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

	def extend_cascades_extends_to_class( *extends, & runtime_extends_block )
	  return cluster_stack.extend_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, extends, runtime_extends_block )
	end
	
	###################################################
	#  extend_cascades_includes_and_extends_to_class  #
	###################################################

	def extend_cascades_includes_and_extends_to_class( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.extend_includes_and_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	###################################################
	#  include_cascades_to_class_prepend_includes  #
	###################################################

	def include_cascades_to_class_prepend_includes( *includes, & runtime_includes_block )
	  return cluster_stack.include_prepends_includes( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes, runtime_includes_block )
	end
	
	##################################################
	#  include_cascades_to_class_prepend_extends  #
	##################################################

	def include_cascades_to_class_prepend_extends( *extends, & runtime_extends_block )
	  return cluster_stack.include_prepends_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, extends, runtime_extends_block )
	end
	
	###############################################################
	#  include_cascades_to_class_prepend_includes_and_extends  #
	###############################################################

	def include_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.include_prepends_includes_and_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	##################################################
	#  extend_cascades_to_class_prepend_includes  #
	##################################################

	def extend_cascades_to_class_prepend_includes( *includes, & runtime_includes_block )
	  return cluster_stack.extend_prepends_includes( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes, runtime_includes_block )
	end
	
	#################################################
	#  extend_cascades_to_class_prepend_extends  #
	#################################################

	def extend_cascades_to_class_prepend_extends( *extends, & runtime_extends_block )
	  return cluster_stack.extend_prepends_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, extends, runtime_extends_block )
	end
	
	##############################################################
	#  extend_cascades_to_class_prepend_includes_and_extends  #
	##############################################################

	def extend_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  return cluster_stack.extend_prepends_includes_and_extends( ::ModuleCluster::Define::ClusterCascadesToClass, __method__, includes_and_extends, runtime_includes_and_extends_block )
	end

	##################################################
	#  include_or_extend_cascades_includes_to_class  #
	##################################################

  def include_or_extend_cascades_includes_to_class( *includes, & runtime_includes_block )
    include_set = include_cascades_includes_to_class( *includes, & runtime_includes_block )
    extend_set = extend_cascades_includes_to_class( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	#################################################
	#  include_or_extend_cascades_extends_to_class  #
	#################################################

  def include_or_extend_cascades_extends_to_class( *extends, & runtime_extends_block )
    include_set = include_cascades_extends_to_class( *extends, & runtime_extends_block )
    extend_set = extend_cascades_extends_to_class( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	##############################################################
	#  include_or_extend_cascades_includes_and_extends_to_class  #
	##############################################################

  def include_or_extend_cascades_includes_and_extends_to_class( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = include_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = extend_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	#############################################################
	#  include_or_extend_cascades_to_class_prepend_includes  #
	#############################################################

  def include_or_extend_cascades_to_class_prepend_includes( *includes, & runtime_includes_block )
    include_set = include_cascades_to_class_prepend_includes( *includes, & runtime_includes_block )
    extend_set = extend_cascades_to_class_prepend_includes( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	############################################################
	#  include_or_extend_cascades_to_class_prepend_extends  #
	############################################################

  def include_or_extend_cascades_to_class_prepend_extends( *extends, & runtime_extends_block )
    include_set = include_cascades_to_class_prepend_includes( *extends, & runtime_extends_block )
    extend_set = extend_cascades_to_class_prepend_includes( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	#########################################################################
	#  include_or_extend_cascades_to_class_prepend_includes_and_extends  #
	#########################################################################
	
	def include_or_extend_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = include_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = extend_cascades_to_class_prepend_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
  
end
