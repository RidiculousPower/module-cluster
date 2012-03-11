
module ModuleCluster::Define::ModuleOrInstanceCluster

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( class_or_module_or_instance )
    return ! class_or_module_or_instance.is_a?( Class )
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module_or_instance )
    return false
  end
  
	##########################################################################
	#  module_include_or_extend_or_instance_extend_also_includes_or_extends  #
	##########################################################################

	def module_include_or_extend_or_instance_extend_also_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_includes( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.module_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	##############################################################
	#  module_include_or_extend_or_instance_extend_also_extends  #
	##############################################################

	def module_include_or_extend_or_instance_extend_also_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.module_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	################################################################
	#  module_include_or_instance_extend_also_includes_or_extends  #
	################################################################

	def module_include_or_instance_extend_also_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_includes( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	####################################################
	#  module_include_or_instance_extend_also_extends  #
	####################################################
	
	def module_include_or_instance_extend_also_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.module_include_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	############################################
	#  module_or_instance_extend_also_extends  #
	############################################

	def module_or_instance_extend_also_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.module_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	##############################################################################
	#  module_include_or_extend_or_instance_extend_prepends_includes_or_extends  #
	##############################################################################
	
	def module_include_or_extend_or_instance_extend_prepends_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_prepends_includes( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.module_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	####################################################################
	#  module_include_or_instance_extend_prepends_includes_or_extends  #
	####################################################################

	def module_include_or_instance_extend_prepends_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_prepends_includes( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	##################################################################
	#  module_include_or_extend_or_instance_extend_prepends_extends  #
	##################################################################
	
	def module_include_or_extend_or_instance_extend_prepends_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.module_include_prepends_includes( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	########################################################
	#  module_include_or_instance_extend_prepends_extends  #
	########################################################
	
	def module_include_or_instance_extend_prepends_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.module_include_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	################################################
	#  module_or_instance_extend_prepends_extends  #
	################################################

	def module_or_instance_extend_prepends_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.module_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ModuleOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

end
