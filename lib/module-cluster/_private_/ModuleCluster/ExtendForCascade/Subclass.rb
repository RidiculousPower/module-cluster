
module ModuleCluster::ExtendForCascade::Subclass

	##############
	#  extended  #
	##############
	
	def extended( module_cluster_configuration_class_instance )

	  super

	  if module_cluster_configuration_class_instance.is_a?( Class )

  	  module_cluster_configuration_class_instance.module_eval do
  	    # when a module-cluster definition module is used to extend a module,
  	    # define self#inherited module_cluster_configuration_class_instance 
  	    # (class extended with module-cluster definition module)
  	    extend ::ModuleCluster::CascadeFeatures::Subclass
      end
    
    elsif module_cluster_configuration_class_instance.is_a?( Module )

      # we need to create an include hook in the module so that when the class includes it, 
      # it gets the subclass definition
  	  module_cluster_configuration_class_instance.module_eval do
  	    # when a module is enabled for subclass we need to cascade subclassing
  	    extend ::ModuleCluster::ExtendForCascade::Subclass
      end
      
    end
    
  end

	##############
	#  included  #
	##############
	
	def included( module_cluster_configuration_class_instance )

	  super

    existing_inherited_hooks = cluster_stack.inherited_hooks

    if module_cluster_configuration_class_instance.is_a?( Class )

  	  module_cluster_configuration_class_instance.module_eval do
  	    # when a module-cluster definition module is used to extend a module,
  	    # define self#inherited module_cluster_configuration_class_instance 
  	    # (class extended with module-cluster definition module)
  	    extend ::ModuleCluster::Define::Block::Subclass
        cluster_stack.inherited_hooks.concat( existing_inherited_hooks )
      end

    elsif module_cluster_configuration_class_instance.is_a?( Module )

      # we need to create an include hook in the module so that when the class includes it, 
      # it gets the subclass definition
  	  module_cluster_configuration_class_instance.module_eval do
  	    # when a module is enabled for subclass we need to cascade subclassing
  	    extend ::ModuleCluster::Define::Block::Subclass
        cluster_stack.inherited_hooks.concat( existing_inherited_hooks )
      end
      
	  end

  end
  
end
