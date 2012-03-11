
module ModuleCluster::Define::Status
  
  ###################
  #  include_hooks  #
  ###################
  
  def include_hooks
    return cluster_stack.include_hooks
  end

  ##################
  #  extend_hooks  #
  ##################
  
  def extend_hooks
    return cluster_stack.extend_hooks
  end

  ###########################
  #  prepend_include_hooks  #
  ###########################
  
  def prepend_include_hooks
    return cluster_stack.prepend_include_hooks
  end
  
  ##########################
  #  prepend_extend_hooks  #
  ##########################

  def prepend_extend_hooks
    return cluster_stack.prepend_extend_hooks
  end

  #######################
  #  all_include_hooks  #
  #######################
  
  def all_include_hooks
    return cluster_stack.prepend_include_hooks.dup.concat( cluster_stack.include_hooks )
  end

  ######################
  #  all_extend_hooks  #
  ######################
  
  def all_extend_hooks
    return cluster_stack.prepend_extend_hooks.dup.concat( cluster_stack.extend_hooks )
  end

  #######################
  #  has_include_hook?  #
  #######################
  
  def has_include_hook?( *modules )
    return cluster_stack.has_hook?( cluster_stack.include_hooks, *modules )
  end
  alias_method :has_include_hooks?, :has_include_hook?

  ######################
  #  has_extend_hook?  #
  ######################

  def has_extend_hook?( *modules )
    return cluster_stack.has_hook?( cluster_stack.extend_hooks, *modules )
  end
  alias_method :has_extend_hooks?, :has_extend_hook?

  ###############################
  #  has_prepend_include_hook?  #
  ###############################

  def has_prepend_include_hook?( *modules )
    return cluster_stack.has_hook?( cluster_stack.prepend_include_hooks, *modules )
  end
  alias_method :has_prepend_include_hooks?, :has_prepend_include_hook?

  ##############################
  #  has_prepend_extend_hook?  #
  ##############################

  def has_prepend_extend_hook?( *modules )
    return cluster_stack.has_hook?( cluster_stack.prepend_extend_hooks, *modules )
  end
  alias_method :has_prepend_extend_hooks?, :has_prepend_extend_hook?

  ###########################
  #  has_any_include_hook?  #
  ###########################
  
  def has_any_include_hook?( *modules )
    return has_prepend_include_hook?( *modules ) || has_include_hook?( *modules )
  end
  alias_method :has_any_include_hooks?, :has_any_include_hook?

  ##########################
  #  has_any_extend_hook?  #
  ##########################
  
  def has_any_extend_hook?( *modules )
    return has_prepend_extend_hook?( *modules ) || has_extend_hook?( *modules )
  end
  alias_method :has_any_extend_hooks?, :has_any_extend_hook?
  
end
