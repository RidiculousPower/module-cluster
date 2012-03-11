
module ModuleCluster::Suspend::WithoutHooks

  include ::ModuleCluster::Suspend::Hooks
  
  #######################
  #  without_any_hooks  #
  #######################
  
  def without_any_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_any_hooks
      yield
      cluster_stack.resume_any_hooks
    end
    return self
  end
  
  ###############################
  #  without_any_include_hooks  #
  ###############################
  
  def without_any_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_include_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_any_include_hooks
      yield
      cluster_stack.resume_any_include_hooks
    end
    return self
  end

  ##############################
  #  without_any_extend_hooks  #
  ##############################
  
  def without_any_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_extend_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_any_extend_hooks
      yield
      cluster_stack.resume_any_extend_hooks
    end
    return self
  end

  ###########################
  #  without_include_hooks  #
  ###########################
  
  def without_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.include_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_include_hooks
      yield
      cluster_stack.resume_include_hooks
    end
    return self
  end

  ##########################
  #  without_extend_hooks  #
  ##########################
  
  def without_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.extend_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_extend_hooks
      yield
      cluster_stack.resume_extend_hooks
    end
    return self
  end

  ###################################
  #  without_prepend_include_hooks  #
  ###################################
  
  def without_prepend_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.prepend_include_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_prepend_include_hooks
      yield
      cluster_stack.resume_prepend_include_hooks
    end
    return self
  end

  ##################################
  #  without_prepend_extend_hooks  #
  ##################################
  
  def without_prepend_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.prepend_extend_hooks.hooks_with( description )
      sets.suspend
      yield
      sets.resume
    else
      cluster_stack.suspend_prepend_extend_hooks
      yield
      cluster_stack.resume_prepend_extend_hooks
    end
    return self
  end
  
end
