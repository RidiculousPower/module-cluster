
module ModuleCluster::ClusterStack::Block::Class
  
  ###################
  #  class_include  #
  ###################

  def class_include( dependency_module, runtime_block )
    include_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ##################
  #  class_extend  #
  ##################

  def class_extend( dependency_module, runtime_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ###########################
  #  prepend_class_include  #
  ###########################

  def prepend_class_include( dependency_module, runtime_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ##########################
  #  prepend_class_extend  #
  ##########################

  def prepend_class_extend( dependency_module, runtime_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

end
