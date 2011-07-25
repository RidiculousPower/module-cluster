
module ModuleCluster::IncludeExtendSupport

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

	########################
	#  included_sets_hash  #
	########################

	def included_sets_hash
		return @included_sets_hash ||= Hash.new
	end

	########################
	#  extended_sets_hash  #
	########################

	def extended_sets_hash
		return @extended_sets_hash ||= Hash.new
	end
	
	##################
	#  cluster_hash  #
	##################
	
	def cluster_hash
		return @cluster_hash ||= Hash.new
	end
		
end
