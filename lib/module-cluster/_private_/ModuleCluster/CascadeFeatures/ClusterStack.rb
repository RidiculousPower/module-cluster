
module ModuleCluster::CascadeFeatures::ClusterStack
  
  #########################
  #  self.cluster_stacks  #
  #########################

  def self.cluster_stacks
    
    return @cluster_stacks ||= Hash.new
    
  end

  ########################
  #  self.cluster_stack  #
  ########################

  def self.cluster_stack( class_or_module )
    
    cluster_stack_for_class_or_module = nil
    
    unless cluster_stack_for_class_or_module = cluster_stacks[ class_or_module ]
      
      cluster_stack_for_class_or_module = ModuleCluster::ClusterStack.new
      
      cluster_stacks[ class_or_module ] = cluster_stack_for_class_or_module
      
    end

    return cluster_stack_for_class_or_module
     
  end

  ###################
  #  cluster_stack  #
  ###################

  def cluster_stack
    
    return ModuleCluster::CascadeFeatures::ClusterStack.cluster_stack( self )
     
  end

end
