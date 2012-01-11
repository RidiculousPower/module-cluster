
module ModuleCluster::Define::Block::Subclass

  include ModuleCluster::CascadeFeatures::ClusterStack
  include ModuleCluster::Suspend::WithoutHooks
  
  extend ModuleCluster::ExtendForCascade::Subclass

  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return hooked_instance.is_a?( Class )
  end

  ##############
  #  subclass  #
  ##############

  def subclass( & runtime_block )
    return cluster_stack.subclass( ModuleCluster::Define::Block::Subclass, runtime_block )
  end

end
