
module ModuleCluster::CascadeFeatures::Subclass

	###############
	#  inherited  #
	###############
	
	def inherited( hooked_instance )

    # all future subclasses should receive cascading hook
    hooked_instance.extend( ModuleCluster::CascadeFeatures::Subclass )
    hooked_instance.cluster_stack.inherited_hooks.concat( cluster_stack.inherited_hooks )
    
    ModuleCluster::CascadeFeatures.perform_cascades( self, :inherited, hooked_instance, cluster_stack.inherited_hooks )
    
    super

  end
  
end
