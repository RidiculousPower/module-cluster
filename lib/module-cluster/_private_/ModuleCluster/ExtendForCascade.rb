
module ModuleCluster::ExtendForCascade

	##############
	#  extended  #
	##############
	
	def extended( class_or_module )
	  super
	  class_or_module.module_eval do
	    extend ModuleCluster::CascadeFeatures
    end if class_or_module.is_a?( Module ) and ! class_or_module.is_a?( Class )
  end
  
end
