
module ModuleCluster::ClusterStack::Block::Instance

  #####################
  #  instance_extend  #
  #####################

  def instance_extend( dependency_module, runtime_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  #############################
  #  prepend_instance_extend  #
  #############################

  def prepend_instance_extend( dependency_module, runtime_block )
    prepend_extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

end
