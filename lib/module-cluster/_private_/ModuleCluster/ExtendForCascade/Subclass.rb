
module ModuleCluster::ExtendForCascade::Subclass

	##############
	#  extended  #
	##############
	
	def extended( module_cluster_configuration_class_instance )
	  unless module_cluster_configuration_class_instance.is_a?( Class )
	    raise ArgumentError, 'Module-cluster blocks cannot be defined for subclassing on non-class objects.'
	  end
	  super
	  module_cluster_configuration_class_instance.module_eval do
	    # when a module-cluster definition module is used to extend a module,
	    # define self#inherited module_cluster_configuration_class_instance 
	    # (class extended with module-cluster definition module)
	    extend ModuleCluster::CascadeFeatures::Subclass
    end
  end

end
