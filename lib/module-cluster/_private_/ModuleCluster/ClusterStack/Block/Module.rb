
module ModuleCluster::ClusterStack::Block::Module

  ####################
  #  module_include  #
  ####################

  def module_include( dependency_module, runtime_block )
    include_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ###################
  #  module_extend  #
  ###################

  def module_extend( dependency_module, runtime_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ############################
  #  prepend_module_include  #
  ############################

  def prepend_module_include( dependency_module, runtime_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

  ###########################
  #  prepend_module_extend  #
  ###########################

  def prepend_module_extend( dependency_module, runtime_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Block::Set.new( dependency_module, runtime_block ) )
  end

end