
module ModuleCluster::Define::ClusterStack

  ###################
  #  cluster_stack  #
  ###################

  def cluster_stack
    
    cluster_stack = nil
    
    class_or_module_self = self

    ModuleCluster::Define::ClusterStack.module_eval do
      @cluster_stacks ||= Hash.new
      unless cluster_stack = @cluster_stacks[ class_or_module_self ]
        cluster_stack ||= ModuleCluster::ClusterStack.new
        @cluster_stacks[ class_or_module_self ] = cluster_stack
      end
    end
    
    return cluster_stack
     
  end

end
