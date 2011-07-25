
module ModuleCluster::IncludeSupport

	extend ModuleCluster::IncludeExtendSupport

  ##############
  #  included  #
  ##############

	def included( class_or_module )
		super if defined?( super )
		module_self = self
		class_or_module.instance_eval do
			# cascade ModuleCluster support
			extend ModuleCluster
			ModuleCluster::IncludeSupport.included_sets( module_self ).each do |this_set|
				# if we have a set intended to cascade only to classes
				if this_set.is_a?( Array::Class )
					# and we have a class
					if is_a?( Class )
						# include the set
						include( *this_set )
					# otherwise
					else
						# cascade our includes to the next module
						define_module_included_cascades_to_class do |included, extended|
							included.concat( this_set )
						end
						if ModuleCluster::IncludeSupport.cluster?( module_self )
							define_module_extended_cascades_to_class do |included, extended|
								included.concat( this_set )
							end
						end
					end
				# otherwise
				else
					# include the set
					include( *this_set )
				end
			end
			# take care of anything we're supposed to extend when we are included
			ModuleCluster::IncludeSupport.extended_sets( module_self ).each do |this_set|
				# if we have a set intended to cascade only to classes
				if this_set.is_a?( Array::Class )
					# and we have a class
					if is_a?( Class )
						# extend the set
						extend( *this_set )
					# otherwise
					else
						# cascade our extends to the next module
						define_module_included_cascades_to_class do |included, extended|
							extended.concat( this_set )
						end
						if ModuleCluster::IncludeSupport.cluster?( module_self )
							define_module_extended_cascades_to_class do |included, extended|
								extended.concat( this_set )
							end
						end
					end
				# otherwise
				else
					# extend the set
					extend( *this_set )
				end
			end
		end
	end

end
