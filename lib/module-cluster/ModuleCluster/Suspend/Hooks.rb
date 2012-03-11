
module ::ModuleCluster::Suspend::Hooks
    
  #######################
  #  suspend_any_hooks  #
  #######################
  
  def suspend_any_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_any_hooks
      return_sets = cluster_stack.all_hooks
    end
    return return_sets
  end

  ###############################
  #  suspend_any_include_hooks  #
  ###############################
  
  def suspend_any_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_include_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_any_include_hooks
      return_sets = cluster_stack.all_include_hooks
    end
    return return_sets
  end

  ##############################
  #  suspend_any_extend_hooks  #
  ##############################
  
  def suspend_any_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.all_extend_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_any_extend_hooks
      return_sets = cluster_stack.all_extend_hooks
    end
    return return_sets
  end

  ###########################
  #  suspend_include_hooks  #
  ###########################
  
  def suspend_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.include_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_include_hooks
      return_sets = cluster_stack.include_hooks
    end
    return return_sets
  end

  ##########################
  #  suspend_extend_hooks  #
  ##########################
  
  def suspend_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.extend_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_extend_hooks
      return_sets = cluster_stack.extend_hooks
    end
    return return_sets
  end

  ###################################
  #  suspend_prepend_include_hooks  #
  ###################################
  
  def suspend_prepend_include_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.prepend_include_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_prepend_include_hooks
      return_sets = cluster_stack.prepend_include_hooks
    end
    return return_sets
  end

  ##################################
  #  suspend_prepend_extend_hooks  #
  ##################################
  
  def suspend_prepend_extend_hooks( description = nil )
    if description
      # we don't want to end up unsuspending any sets that were already suspended
      # so we add to the description only sets that are not suspended
      description[ :suspended ] = false
      sets = cluster_stack.prepend_extend_hooks.hooks_with( description )
      sets.suspend
      return_sets = sets
    else
      cluster_stack.suspend_prepend_extend_hooks
      return_sets = cluster_stack.prepend_extend_hooks
    end
    return return_sets
  end

  ######################
  #  hooks_suspended?  #
  ######################

  def hooks_suspended?( action )
    return cluster_stack.hooks_suspended?( action )
  end
  
  ##########################
  #  all_hooks_suspended?  #
  ##########################

  def all_hooks_suspended?
    return cluster_stack.all_hooks_suspended?
  end

  ##################################
  #  all_include_hooks_suspended?  #
  ##################################

  def all_include_hooks_suspended?
    return cluster_stack.all_include_hooks_suspended?
  end

  #################################
  #  all_extend_hooks_suspended?  #
  #################################

  def all_extend_hooks_suspended?
    return cluster_stack.all_extend_hooks_suspended?
  end

  ##############################
  #  include_hooks_suspended?  #
  ##############################

  def include_hooks_suspended?
    return cluster_stack.include_hooks_suspended?
  end

  #############################
  #  extend_hooks_suspended?  #
  #############################

  def extend_hooks_suspended?
    return cluster_stack.extend_hooks_suspended?
  end

  ######################################
  #  prepend_include_hooks_suspended?  #
  ######################################

  def prepend_include_hooks_suspended?
    return cluster_stack.prepend_include_hooks_suspended?
  end

  #####################################
  #  prepend_extend_hooks_suspended?  #
  #####################################
  
  def prepend_extend_hooks_suspended?
    return cluster_stack.prepend_extend_hooks_suspended?
  end
  
  ######################
  #  resume_any_hooks  #
  ######################
  
  def resume_any_hooks( description = nil )
    if description
      sets = cluster_stack.all_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_any_hooks
      return_sets = cluster_stack.all_hooks
    end
    return return_sets
  end

  ##############################
  #  resume_any_include_hooks  #
  ##############################
  
  def resume_any_include_hooks( description = nil )
    if description
      sets = cluster_stack.all_include_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_any_include_hooks
      return_sets = cluster_stack.all_include_hooks
    end
    return return_sets
  end

  #############################
  #  resume_any_extend_hooks  #
  #############################
  
  def resume_any_extend_hooks( description = nil )
    if description
      sets = cluster_stack.all_extend_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_any_extend_hooks
      return_sets = cluster_stack.all_extend_hooks
    end
    return return_sets
  end

  ##########################
  #  resume_include_hooks  #
  ##########################
  
  def resume_include_hooks( description = nil )
    if description
      sets = cluster_stack.include_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_include_hooks
      return_sets = cluster_stack.include_hooks
    end
    return return_sets
  end

  #########################
  #  resume_extend_hooks  #
  #########################
  
  def resume_extend_hooks( description = nil )
    if description
      sets = cluster_stack.extend_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_extend_hooks
      return_sets = cluster_stack.extend_hooks
    end
    return return_sets
  end

  ##################################
  #  resume_prepend_include_hooks  #
  ##################################
  
  def resume_prepend_include_hooks( description = nil )
    if description
      sets = cluster_stack.prepend_include_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_prepend_include_hooks
      return_sets = cluster_stack.prepend_include_hooks
    end
    return return_sets
  end

  #################################
  #  resume_prepend_extend_hooks  #
  #################################
  
  def resume_prepend_extend_hooks( description = nil )
    if description
      sets = cluster_stack.prepend_extend_hooks.hooks_with( description )
      sets.resume
      return_sets = sets
    else
      cluster_stack.resume_prepend_extend_hooks
      return_sets = cluster_stack.prepend_extend_hooks
    end
    return return_sets
  end
  
  
  
end
