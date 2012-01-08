
module ModuleCluster::ClusterStack::Suspend

  #######################
  #  suspend_any_hooks  #
  #######################
  
  def suspend_any_hooks
    @all_hooks_suspended = true
  end

  ###############################
  #  suspend_any_include_hooks  #
  ###############################
  
  def suspend_any_include_hooks
    @all_include_hooks_suspended = true
  end

  ##############################
  #  suspend_any_extend_hooks  #
  ##############################
  
  def suspend_any_extend_hooks
    @all_extend_hooks_suspended = true
  end

  ###########################
  #  suspend_include_hooks  #
  ###########################
  
  def suspend_include_hooks
    @include_hooks_suspended = true
  end

  ##########################
  #  suspend_extend_hooks  #
  ##########################
  
  def suspend_extend_hooks
    @extend_hooks_suspended = true
  end

  ###################################
  #  suspend_prepend_include_hooks  #
  ###################################
  
  def suspend_prepend_include_hooks
    @prepend_include_hooks_suspended = true
  end

  ##################################
  #  suspend_prepend_extend_hooks  #
  ##################################
  
  def suspend_prepend_extend_hooks
    @prepend_extend_hooks_suspended = true
  end

  ######################
  #  hooks_suspended?  #
  ######################

  def hooks_suspended?( action )
    
    return true if all_hooks_suspended?

    case action
      when :include
        return true if all_include_hooks_suspended?
        return true if include_hooks_suspended?
      when :extend
        return true if all_extend_hooks_suspended?
        return true if extend_hooks_suspended?
      when :prepend_include
        return true if all_include_hooks_suspended?
        return true if prepend_include_hooks_suspended?
      when :prepend_extend
        return true if all_extend_hooks_suspended?
        return true if prepend_extend_hooks_suspended?
    end
    
    return false
    
  end
  
  ##########################
  #  all_hooks_suspended?  #
  ##########################

  def all_hooks_suspended?
    return @all_hooks_suspended ||= false
  end

  ##################################
  #  all_include_hooks_suspended?  #
  ##################################

  def all_include_hooks_suspended?
    return ( @all_include_hooks_suspended ||= false ) || all_hooks_suspended?
  end

  #################################
  #  all_extend_hooks_suspended?  #
  #################################

  def all_extend_hooks_suspended?
    return ( @all_extend_hooks_suspended ||= false ) || all_hooks_suspended?
  end

  ##############################
  #  include_hooks_suspended?  #
  ##############################

  def include_hooks_suspended?
    return ( @include_hooks_suspended ||= false ) || all_include_hooks_suspended?
  end

  #############################
  #  extend_hooks_suspended?  #
  #############################

  def extend_hooks_suspended?
    return ( @extend_hooks_suspended ||= false ) || all_extend_hooks_suspended?
  end

  ######################################
  #  prepend_include_hooks_suspended?  #
  ######################################

  def prepend_include_hooks_suspended?
    return ( @prepend_include_hooks_suspended ||= false ) || all_include_hooks_suspended?
  end

  #####################################
  #  prepend_extend_hooks_suspended?  #
  #####################################

  def prepend_extend_hooks_suspended?
    return ( @prepend_extend_hooks_suspended ||= false ) || all_extend_hooks_suspended?
  end

  ######################
  #  resume_any_hooks  #
  ######################
  
  def resume_any_hooks
    @all_hooks_suspended = false
  end

  ##############################
  #  resume_any_include_hooks  #
  ##############################
  
  def resume_any_include_hooks
    @all_include_hooks_suspended = false
  end

  #############################
  #  resume_any_extend_hooks  #
  #############################
  
  def resume_any_extend_hooks
    @all_extend_hooks_suspended = false
  end

  ##########################
  #  resume_include_hooks  #
  ##########################
  
  def resume_include_hooks
    @include_hooks_suspended = false
  end

  #########################
  #  resume_extend_hooks  #
  #########################
  
  def resume_extend_hooks
    @extend_hooks_suspended = false
  end

  ##################################
  #  resume_prepend_include_hooks  #
  ##################################
  
  def resume_prepend_include_hooks
    @prepend_include_hooks_suspended = false
  end

  #################################
  #  resume_prepend_extend_hooks  #
  #################################
  
  def resume_prepend_extend_hooks
    @prepend_extend_hooks_suspended = false
  end

end
