
module ModuleCluster

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

	def yield_for_includes_extends( inclusion_array, extension_array, block )
		returned_includes, returned_extends = block.call( inclusion_array, extension_array )
		if returned_includes and returned_extends and 
			 returned_includes.is_a?( Array ) and returned_extends.is_a?( Array )
			inclusion_array = returned_includes
			extension_array = returned_extends
		end
		unless inclusion_array.is_a?( Array ) and extension_array.is_a?( Array )
			raise 'Expected module inclusion/extension variables to remain Array. Received ' +
			      inclusion_array.inspect + ' for inclusion array, and ' + extension_array.inspect +
			      ' for extension array.'
		end
		return inclusion_array, extension_array
	end
	
end
