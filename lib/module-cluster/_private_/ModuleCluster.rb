
module ModuleCluster

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

	def yield_for_includes_extends( block )
		inclusion_array = Array.new
		extension_array = Array.new
		returned_includes, returned_extends = block.call( inclusion_array, extension_array )
		inclusion_array = returned_includes if returned_includes.is_a?( Array )
		extension_array = returned_extends if returned_extends.is_a?( Array )
		unless inclusion_array.is_a?( Array ) and extension_array.is_a?( Array )
			raise 'Expected module inclusion/extension variables to remain Array. Received ' +
			      inclusion_array.inspect + ' for inclusion array, and ' + extension_array.inspect +
			      ' for extension array.'
		end
		return inclusion_array, extension_array
	end
	
end
