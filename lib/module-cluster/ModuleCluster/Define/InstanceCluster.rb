
module ModuleCluster::Define::InstanceCluster

  include ModuleCluster::CascadeFeatures::ClusterStack
  
  extend ModuleCluster::ExtendForCascade

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  def self.should_include_or_extend?( hooked_instance )
    should_include_or_extend = false
    unless hooked_instance.is_a?( Module )
      should_include_or_extend = true
    end
    return should_include_or_extend
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( hooked_instance )
    return false
  end
	
	##################################
	#  instance_extend_also_extends  #
	##################################
	
	def instance_extend_also_extends( *extends, & runtime_extends_block )
	  cluster_stack.instance_extend_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
	######################################
	#  instance_extend_prepends_extends  #
	######################################
	
	def instance_extend_prepends_extends( *extends, & runtime_extends_block )
	  cluster_stack.instance_extend_prepends_extends( ModuleCluster::Define::Cluster, __method__, extends, runtime_extends_block )
		return self
	end
	
end
