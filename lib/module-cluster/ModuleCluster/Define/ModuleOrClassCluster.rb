
module ModuleCluster::Define::ModuleOrClassCluster

  include ModuleCluster::CascadeFeatures::ClusterStack
  
  extend ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( class_or_module_or_instance )
    should_include_or_extend = false
    if class_or_module_or_instance.is_a?( Module )
      should_include_or_extend = true
    end
    return should_include_or_extend
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module_or_instance )
    return false
  end
  
	###########################################
	#  module_or_class_include_also_includes  #
	###########################################

	def module_or_class_include_also_includes( *includes, & runtime_includes_block )
	  cluster_stack.module_include_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
	  cluster_stack.class_include_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
		return self
	end
	
	##########################################
	#  module_or_class_include_also_extends  #
	##########################################
	
	def module_or_class_include_also_extends( *extends, & runtime_extends_block )
	  cluster_stack.module_include_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
	  cluster_stack.class_include_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	#######################################################
	#  module_or_class_include_also_includes_and_extends  #
	#######################################################

	def module_or_class_include_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.module_include_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
	  cluster_stack.class_include_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	##########################################
	#  module_or_class_extend_also_includes  #
	##########################################

	def module_or_class_extend_also_includes( *includes, & runtime_includes_block )
	  cluster_stack.module_extend_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
	  cluster_stack.class_extend_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
		return self
	end
	
	#########################################
	#  module_or_class_extend_also_extends  #
	#########################################
	
	def module_or_class_extend_also_extends( *extends, & runtime_extends_block )
	  cluster_stack.module_extend_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
	  cluster_stack.class_extend_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	######################################################
	#  module_or_class_extend_also_includes_and_extends  #
	######################################################

	def module_or_class_extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.module_extend_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
	  cluster_stack.class_extend_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	###############################################
	#  module_or_class_include_prepends_includes  #
	###############################################

	def module_or_class_include_prepends_includes( *includes, & runtime_includes_block )
	  cluster_stack.module_include_prepends_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
	  cluster_stack.class_include_prepends_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
		return self
	end

	##############################################
	#  module_or_class_include_prepends_extends  #
	##############################################
	
	def module_or_class_include_prepends_extends( *extends, & runtime_extends_block )
	  cluster_stack.module_include_prepends_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
	  cluster_stack.class_include_prepends_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	###########################################################
	#  module_or_class_include_prepends_includes_and_extends  #
	###########################################################

	def module_or_class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.module_include_prepends_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
	  cluster_stack.class_include_prepends_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end

	##############################################
	#  module_or_class_extend_prepends_includes  #
	##############################################

	def module_or_class_extend_prepends_includes( *includes, & runtime_includes_block )
	  cluster_stack.module_extend_prepends_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
	  cluster_stack.class_extend_prepends_includes( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes, runtime_includes_block )
		return self
	end

	#############################################
	#  module_or_class_extend_prepends_extends  #
	#############################################
	
	def module_or_class_extend_prepends_extends( *extends, & runtime_extends_block )
	  cluster_stack.module_extend_prepends_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
	  cluster_stack.class_extend_prepends_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	##########################################################
	#  module_or_class_extend_prepends_includes_and_extends  #
	##########################################################

	def module_or_class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
	  cluster_stack.module_extend_prepends_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
	  cluster_stack.class_extend_prepends_includes_and_extends( ModuleCluster::Define::ModuleOrClassCluster, __method__, includes_and_extends, runtime_includes_and_extends_block )
		return self
	end
	
	#####################################################
	#  module_or_class_include_or_extend_also_includes  #
	#####################################################

  def module_or_class_include_or_extend_also_includes( *includes, & runtime_includes_block )
    module_or_class_include_also_includes( *includes, & runtime_includes_block )
    module_or_class_extend_also_includes( *includes, & runtime_includes_block )
		return self
  end

	####################################################
	#  module_or_class_include_or_extend_also_extends  #
	####################################################

  def module_or_class_include_or_extend_also_extends( *extends, & runtime_extends_block )
    module_or_class_include_also_extends( *extends, & runtime_extends_block )
    module_or_class_extend_also_extends( *extends, & runtime_extends_block )
		return self
  end

	#################################################################
	#  module_or_class_include_or_extend_also_includes_and_extends  #
	#################################################################

  def module_or_class_include_or_extend_also_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    module_or_class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    module_or_class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

	#########################################################
	#  module_or_class_include_or_extend_prepends_includes  #
	#########################################################

  def module_or_class_include_or_extend_prepends_includes( *includes, & runtime_includes_block )
    module_or_class_include_prepends_includes( *includes, & runtime_includes_block )
    module_or_class_extend_prepends_includes( *includes, & runtime_includes_block )
		return self
  end

	########################################################
	#  module_or_class_include_or_extend_prepends_extends  #
	########################################################

  def module_or_class_include_or_extend_prepends_extends( *extends, & runtime_extends_block )
    module_or_class_include_prepends_extends( *extends, & runtime_extends_block )
    module_or_class_extend_prepends_extends( *extends, & runtime_extends_block )
		return self
  end

	#####################################################################
	#  module_or_class_include_or_extend_prepends_includes_and_extends  #
	#####################################################################

  def module_or_class_include_or_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    module_or_class_include_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
    module_or_class_extend_prepends_includes_and_extends( *includes_and_extends, & runtime_includes_and_extends_block )
		return self
  end

end
