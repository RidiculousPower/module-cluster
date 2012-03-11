
module ModuleCluster::CascadeFeatures
  
  extend ::ModuleCluster::CascadeFeatures::PerformCascades
  
  #####################
  #  append_features  #
  #####################

  def append_features( hooked_instance )

    ModuleCluster::CascadeFeatures.perform_cascades( self, :prepend_include, hooked_instance, cluster_stack.prepend_include_hooks )
    
    super
    
  end
  
  ##############
  #  included  #
  ##############

  def included( hooked_instance )

    super

    ModuleCluster::CascadeFeatures.perform_cascades( self, :include, hooked_instance, cluster_stack.include_hooks )
    
  end
  
  ###################
  #  extend_object  #
  ###################

  def extend_object( hooked_instance )

    ModuleCluster::CascadeFeatures.perform_cascades( self, :prepend_extend, hooked_instance, cluster_stack.prepend_extend_hooks )
    
    super
    
  end
  
  ##############
  #  extended  #
  ##############

  def extended( hooked_instance )

    super

    ModuleCluster::CascadeFeatures.perform_cascades( self, :extend, hooked_instance, cluster_stack.extend_hooks )

  end
  
end
