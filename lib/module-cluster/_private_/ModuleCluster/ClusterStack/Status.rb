
module ModuleCluster::ClusterStack::Status

  ###############
  #  all_hooks  #
  ###############

  def all_hooks
    return @all_hooks ||= ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( all_include_hooks, all_extend_hooks )
  end

  #######################
  #  all_include_hooks  #
  #######################

  def all_include_hooks
    return @all_include_hooks ||= ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( prepend_include_hooks, include_hooks )
  end

  ######################
  #  all_extend_hooks  #
  #######################

  def all_extend_hooks
    return @all_extend_hooks ||= ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( prepend_extend_hooks, extend_hooks )
  end

  ###################
  #  has_any_hook?  #
  ###################

  def has_any_hook?( description )
    hooks = all_hooks.hooks_with( description )
    return hooks ||= false
  end

  ###########################
  #  has_any_include_hook?  #
  ###########################

  def has_any_include_hook?( description )
    hooks = all_include_hooks.hooks_with( description )
    return hooks ||= false
  end

  ##########################
  #  has_any_extend_hook?  #
  ##########################

  def has_any_extend_hook?( description )
    hooks = all_extend_hooks.hooks_with( description )
    return hooks ||= false
  end  
  
end
