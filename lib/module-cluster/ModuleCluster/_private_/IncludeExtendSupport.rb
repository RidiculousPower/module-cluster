
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

	######################################
	#  cluster_hash_for_class_or_module  #
	######################################
	
	def cluster_hash_for_class_or_module( class_or_module )
		return cluster_hash[ class_or_module ] ||= Hash.new
	end

	###############################################
	#  includes_cluster_hash_for_class_or_module  #
	###############################################
	
	def includes_cluster_hash_for_class_or_module( class_or_module )
		return cluster_hash_for_class_or_module( class_or_module )[ :includes ] ||= Array.new
	end
		
	##############################################
	#  extends_cluster_hash_for_class_or_module  #
	##############################################
	
	def extends_cluster_hash_for_class_or_module( class_or_module )
		return cluster_hash_for_class_or_module( class_or_module )[ :extends ] ||= Array.new
	end
	
end
