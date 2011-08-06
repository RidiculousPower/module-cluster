
module ModuleCluster::ClusterStack::Block::Module

  ####################
  #  module_include  #
  ####################

  def module_include( runtime_block )
    cascading_includes.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ###################
  #  module_extend  #
  ###################

  def module_extend( runtime_block )
    cascading_extends.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ############################
  #  prepend_module_include  #
  ############################

  def prepend_module_include( runtime_block )
    cascading_prepending_includes.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ###########################
  #  prepend_module_extend  #
  ###########################

  def prepend_module_extend( runtime_block )
    cascading_prepending_extends.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

end
