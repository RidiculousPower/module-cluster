
module ModuleCluster::ExtendForCascade

	##############
	#  extended  #
	##############
	
	def extended( module_cluster_module )
	  super
	  module_cluster_module.module_eval do
	    # when a module-cluster definition module is used to extend a module,
	    # define self#extended, self#included, self#append_features, self#extend_object in
	    # module_cluster_module ( module extended with module-cluster definition module )
	    extend ModuleCluster::CascadeFeatures
	      # classes and instances can't cascade through include/extend, so no reason to define
	      # unless we have a module
    end if module_cluster_module.is_a?( Module ) and ! module_cluster_module.is_a?( Class )
  end
  
end
