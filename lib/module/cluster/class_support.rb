
###
# Provides #inherited support for {::Module::Cluster Module::Cluster}.
#
module ::Module::Cluster::ClassSupport
  
  ###############
  #  inherited  #
  ###############
  
  ###
  # Ensures {::Module::Cluster Module::Cluster} subclass hooks occur at time of subclassing.
  #
  def inherited( subclass_instance )

    super if defined?( super )
    
    ::Module::Cluster.evaluate_cluster_stack( self, subclass_instance, :subclass )
    
  end
  
end
