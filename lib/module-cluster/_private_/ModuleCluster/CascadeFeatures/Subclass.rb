
module ::ModuleCluster::CascadeFeatures::Subclass

  extend ::ModuleCluster::CascadeFeatures::PerformCascades

	###############
	#  inherited  #
	###############
	
	def inherited( hooked_instance )

    ::ModuleCluster::CascadeFeatures.perform_cascades( self, 
                                                       :inherited, 
                                                       hooked_instance, 
                                                       cluster_stack.inherited_hooks )
    
    # we don't call super because we don't want to run our inherited action multiple times
    # that means if you are messing with #inherited on your own (whoever is reading this code)
    # then you need to consider the order your #inherited will be inserted in relation to
    # the one provided by module-cluster
    
  end
  
end
