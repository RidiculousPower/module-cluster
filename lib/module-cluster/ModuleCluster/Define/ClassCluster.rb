
module ::ModuleCluster::Define::ClassCluster

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    should_include_or_extend = false
    if hooked_instance.is_a?( Class )
      should_include_or_extend = true
    end
    return should_include_or_extend
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return false
  end
  
	#################################
	#  class_include_also_includes  #
	#################################

	def class_include_also_includes( *includes, & runtime_includes_block )
	  return cluster_stack.class_include_includes( ::ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
	end
	
	################################
	#  class_include_also_extends  #
	################################
	
	def class_include_also_extends( *extends, & runtime_extends_block )
	  return cluster_stack.class_include_extends( ::ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
	end
	
	#############################################
	#  class_include_also_includes_and_extends  #
	#############################################

	def class_include_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = class_include_also_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = class_include_also_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	################################
	#  class_extend_also_includes  #
	################################

	def class_extend_also_includes( *includes, & runtime_includes_block )
	  return cluster_stack.class_extend_includes( ::ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
	end
	
	###############################
	#  class_extend_also_extends  #
	###############################
	
	def class_extend_also_extends( *extends, & runtime_extends_block )
	  return cluster_stack.class_extend_extends( ::ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
	end
	
	############################################
	#  class_extend_also_includes_and_extends  #
	############################################

	def class_extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = class_extend_also_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = class_extend_also_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	#####################################
	#  class_include_prepends_includes  #
	#####################################

	def class_include_prepends_includes( *includes, & runtime_includes_block )
	  return cluster_stack.class_include_prepends_includes( ::ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
	end

	####################################
	#  class_include_prepends_extends  #
	####################################
	
	def class_include_prepends_extends( *extends, & runtime_extends_block )
	  return cluster_stack.class_include_prepends_extends( ::ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
	end
	
	#################################################
	#  class_include_prepends_includes_and_extends  #
	#################################################

	def class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = class_include_prepends_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = class_include_prepends_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	####################################
	#  class_extend_prepends_includes  #
	####################################

	def class_extend_prepends_includes( *includes, & runtime_includes_block )
	  return cluster_stack.class_extend_prepends_includes( ::ModuleCluster::Define::Cluster, __method__, includes, runtime_includes_block )
	end

	###################################
	#  class_extend_prepends_extends  #
	###################################
	
	def class_extend_prepends_extends( *extends, & runtime_extends_block )
	  return cluster_stack.class_extend_prepends_extends( ::ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
	end
	
	################################################
	#  class_extend_prepends_includes_and_extends  #
	################################################

	def class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		include_set = class_extend_prepends_includes( *includes_and_extends, & runtime_includes_and_extends_block )
		extend_set = class_extend_prepends_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	###########################################
	#  class_include_or_extend_also_includes  #
	###########################################

  def class_include_or_extend_also_includes( *includes, & runtime_includes_block )
    include_set = class_include_also_includes( *includes, & runtime_includes_block )
    extend_set = class_extend_also_includes( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	##########################################
	#  class_include_or_extend_also_extends  #
	##########################################

  def class_include_or_extend_also_extends( *extends, & runtime_extends_block )
    include_set = class_include_also_extends( *extends, & runtime_extends_block )
    extend_set = class_extend_also_extends( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	#######################################################
	#  class_include_or_extend_also_includes_and_extends  #
	#######################################################

  def class_include_or_extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	###############################################
	#  class_include_or_extend_prepends_includes  #
	###############################################

  def class_include_or_extend_prepends_includes( *includes, & runtime_includes_block )
    include_set = class_include_prepends_includes( *includes, & runtime_includes_block )
    extend_set = class_extend_prepends_includes( *includes, & runtime_includes_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	##############################################
	#  class_include_or_extend_prepends_extends  #
	##############################################

  def class_include_or_extend_prepends_extends( *extends, & runtime_extends_block )
    include_set = class_include_prepends_extends( *extends, & runtime_extends_block )
    extend_set = class_extend_prepends_extends( *extends, & runtime_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

	###########################################################
	#  class_include_or_extend_prepends_includes_and_extends  #
	###########################################################

  def class_include_or_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    include_set = class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    extend_set = class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

end
