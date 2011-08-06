
module ModuleCluster::ExtendForCascade

	##############
	#  extended  #
	##############
	
	def extended( class_or_module )
	  super
	  class_or_module.module_eval do
	    extend ModuleCluster::CascadeFeatures
    end unless class_or_module.is_a?( Class )
  end
  
end
