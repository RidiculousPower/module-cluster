
module ::Module::Cluster::ModuleSupport

  #####################
  #  append_features  #
  #####################

  def append_features( hooked_instance )
    
    super if defined?( super )
    
    hook_cluster_events( self, hooked_instance, :before_include )
    
  end

  ##############
  #  included  #
  ##############

  def included( hooked_instance )

    super if defined?( super )
    
    hook_cluster_events( self, hooked_instance, :after_include )
    
  end

  ###################
  #  extend_object  #
  ###################
  
  def extend_object( hooked_instance )

    super if defined?( super )
    
    hook_cluster_events( self, hooked_instance, :before_extend )
    
  end

  ##############
  #  extended  #
  ##############
  
  def extended( instance )

    super if defined?( super )
    
    hook_cluster_events( self, hooked_instance, :after_extend )
    
  end

end
