
module ::ModuleCluster::ExtendForCascade

	##############
	#  extended  #
	##############
	
	def extended( module_cluster_configuration_instance )

	  super

    if module_cluster_configuration_instance.is_a?( Class )

  	  module_cluster_configuration_instance.module_eval do
  	    # when a module-cluster definition module is used to extend a module,
  	    # define self#extended, self#included, self#append_features, self#extend_object in
  	    # module_cluster_module ( module extended with module-cluster definition module )
  	    extend ::ModuleCluster::CascadeFeatures::Subclass
      end
      
    else
      
  	  module_cluster_configuration_instance.instance_eval do
  	    # when a module-cluster definition module is used to extend a module,
  	    # define self#extended, self#included, self#append_features, self#extend_object in
  	    # module_cluster_module ( module extended with module-cluster definition module )
  	    extend ::ModuleCluster::CascadeFeatures
      end
    
    end
    
  end
  
end
