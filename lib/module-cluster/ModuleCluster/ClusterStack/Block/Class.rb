
module ModuleCluster::ClusterStack::Block::Class
  
  ###################
  #  class_include  #
  ###################

  def class_include( runtime_block )
    cascading_includes.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ##################
  #  class_extend  #
  ##################

  def class_extend( runtime_block )
    cascading_extends.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ###########################
  #  prepend_class_include  #
  ###########################

  def prepend_class_include( runtime_block )
    cascading_prepending_includes.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

  ##########################
  #  prepend_class_extend  #
  ##########################

  def prepend_class_extend( runtime_block )
    cascading_prepending_extends.push( ModuleCluster::ClusterStack::Block::Set.new( runtime_block ) )
  end

end
