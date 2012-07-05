
###
# Provides #append_features, #included, #extend_object, #extended support for {::Module::Cluster Module::Cluster}.
#
module ::Module::Cluster::ModuleSupport

  #####################
  #  append_features  #
  #####################

  ###
  # Ensures {::Module::Cluster Module::Cluster} before_include hooks occur at time of include.
  #
  def append_features( hooked_instance )
    
    super if defined?( super )
    
    ::Module::Cluster.hook_cluster_events( self, hooked_instance, :before_include )
    
  end

  ##############
  #  included  #
  ##############

  ###
  # Ensures {::Module::Cluster Module::Cluster} after_include hooks occur at time of include.
  #
  def included( hooked_instance )

    super if defined?( super )
    
    ::Module::Cluster.hook_cluster_events( self, hooked_instance, :after_include )
    
  end

  ###################
  #  extend_object  #
  ###################
  
  ###
  # Ensures {::Module::Cluster Module::Cluster} before_extend hooks occur at time of extend.
  #
  def extend_object( hooked_instance )

    super if defined?( super )
    
    ::Module::Cluster.hook_cluster_events( self, hooked_instance, :before_extend )
    
  end

  ##############
  #  extended  #
  ##############
  
  ###
  # Ensures {::Module::Cluster Module::Cluster} after_extend hooks occur at time of extend.
  #
  def extended( hooked_instance )

    super if defined?( super )
    
    ::Module::Cluster.hook_cluster_events( self, hooked_instance, :after_extend )
    
  end

end
