
module ::Module::Cluster::ClassSupport
  
  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass_instance )

    super if defined?( super )
    
    hook_cluster_events( self, subclass_instance, :subclass )
    
  end

end
