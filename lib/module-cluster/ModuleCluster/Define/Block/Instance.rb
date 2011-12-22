
module ModuleCluster::Define::Block::Instance
  
  include ModuleCluster::CascadeFeatures::ClusterStack
  
  extend ModuleCluster::ExtendForCascade

  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return ! hooked_instance.is_a?( Module )
  end

  #####################
  #  instance_extend  #
  #####################

  def instance_extend( & runtime_block )
    cluster_stack.instance_extend( ModuleCluster::Define::Block::Instance, runtime_block )
  end

  #############################
  #  prepend_instance_extend  #
  #############################

  def prepend_instance_extend( & runtime_block )
    cluster_stack.prepend_instance_extend( ModuleCluster::Define::Block::Instance, runtime_block )
  end

end
