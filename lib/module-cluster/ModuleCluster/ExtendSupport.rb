
module ModuleCluster::ExtendSupport

	extend ModuleCluster::IncludeExtendSupport

  ##############
  #  extended  #
  ##############

	def extended( class_or_module )
		super if defined?( super )
		module_self = self
		class_or_module.instance_eval do
			ModuleCluster::ExtendSupport.includes_for_class_or_module( module_self ).each do |this_module|
				include this_module
			end
			ModuleCluster::ExtendSupport.extends_for_class_or_module( module_self ).each do |this_module|
				extend this_module
			end
		end
	end

end
