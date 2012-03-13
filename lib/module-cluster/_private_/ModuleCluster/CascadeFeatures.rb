
module ::ModuleCluster::CascadeFeatures
  
  extend ::ModuleCluster::CascadeFeatures::PerformCascades
  
  #####################
  #  append_features  #
  #####################

  def append_features( hooked_instance )
    
    ::ModuleCluster::CascadeFeatures.perform_cascades( self, 
                                                       :prepend_include, 
                                                       hooked_instance, 
                                                       cluster_stack.prepend_include_hooks )
    
    super
    
  end
  
  ##############
  #  included  #
  ##############

  def included( hooked_instance )

    super

    ::ModuleCluster::CascadeFeatures.perform_cascades( self, 
                                                      :include, 
                                                      hooked_instance, 
                                                      cluster_stack.include_hooks )
    
    # if we are included in a class and we have cascading inherit hooks we need to move them over
    # append_features and included are both called for an inlucde, so we only need to do this in one
    if hooked_instance.is_a?( Class )

      unless cluster_stack.inherited_hooks.empty?
        hooked_instance.extend( ::ModuleCluster::Define::Block::Subclass )
        hooked_instance.cluster_stack.inherited_hooks.concat( cluster_stack.inherited_hooks )
      end

    end
    
  end
  
  ###################
  #  extend_object  #
  ###################

  def extend_object( hooked_instance )

    ::ModuleCluster::CascadeFeatures.perform_cascades( self, 
                                                       :prepend_extend, 
                                                       hooked_instance, 
                                                       cluster_stack.prepend_extend_hooks )
    
    super
    
  end
  
  ##############
  #  extended  #
  ##############

  def extended( hooked_instance )

    super

    ::ModuleCluster::CascadeFeatures.perform_cascades( self, 
                                                       :extend, 
                                                       hooked_instance, 
                                                       cluster_stack.extend_hooks )

  end
  
end
