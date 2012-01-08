
module ModuleCluster::Define::ClassOrInstanceCluster

  include ModuleCluster::CascadeFeatures::ClusterStack
  include ModuleCluster::Suspend::WithoutHooks
  
  extend ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    return hooked_instance.is_a?( Class ) || ! hooked_instance.is_a?( Module )
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_instance_or_module )
    return false
  end
  
	#########################################################################
	#  class_include_or_extend_or_instance_extend_also_includes_or_extends  #
	#########################################################################

	def class_include_or_extend_or_instance_extend_also_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_includes( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.class_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set, extend_set_two )
	end
	
	#############################################################
	#  class_include_or_extend_or_instance_extend_also_extends  #
	#############################################################

	def class_include_or_extend_or_instance_extend_also_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.class_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set, extend_set_two )
	end

	###############################################################
	#  class_include_or_instance_extend_also_includes_or_extends  #
	###############################################################

	def class_include_or_instance_extend_also_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_includes( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	###################################################
	#  class_include_or_instance_extend_also_extends  #
	###################################################
	
	def class_include_or_instance_extend_also_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.class_include_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	###########################################
	#  class_or_instance_extend_also_extends  #
	###########################################

	def class_or_instance_extend_also_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.class_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	#############################################################################
	#  class_include_or_extend_or_instance_extend_prepends_includes_or_extends  #
	#############################################################################
	
	def class_include_or_extend_or_instance_extend_prepends_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_prepends_includes( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.class_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set_two = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set, extend_set_two )
	end
	
	###################################################################
	#  class_include_or_instance_extend_prepends_includes_or_extends  #
	###################################################################

	def class_include_or_instance_extend_prepends_includes_or_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_prepends_includes( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	#################################################################
	#  class_include_or_extend_or_instance_extend_prepends_extends  #
	#################################################################
	
	def class_include_or_extend_or_instance_extend_prepends_extends( *includes_or_extends, & runtime_includes_or_extends_block )
	  include_set = cluster_stack.class_include_prepends_includes( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, includes_or_extends, runtime_includes_or_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end
	
	#######################################################
	#  class_include_or_instance_extend_prepends_extends  #
	#######################################################
	
	def class_include_or_instance_extend_prepends_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.class_include_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

	###############################################
	#  class_or_instance_extend_prepends_extends  #
	###############################################

	def class_or_instance_extend_prepends_extends( *extends, & runtime_extends_block )
	  include_set = cluster_stack.class_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
	  extend_set = cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::ClassOrInstanceCluster, __method__, extends, runtime_extends_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
	end

end
