
module ::ModuleCluster::ClusterStack::Block::Inherited
  
  #####################
  #  inherited_hooks  #
  #####################

  def inherited_hooks
    return @inherited_hooks ||= ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new
  end
  
  ##############
  #  subclass  #
  ##############
  
  def subclass( dependency_module, dependency_method, runtime_block )
    inherited_hooks.push( ::ModuleCluster::ClusterStack::Block::Set.new( dependency_module, dependency_method, runtime_block ) )
  end

end
