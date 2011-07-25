
module ModuleCluster::IncludeExtendSupport

	######################################
	#  add_includes_for_class_or_module  #
	######################################

	def add_includes_for_class_or_module( class_or_module, includes )
		included_sets( class_or_module ).push( includes ) unless includes.empty?
	end

	#####################################
	#  add_extends_for_class_or_module  #
	#####################################
	
	def add_extends_for_class_or_module( class_or_module, extends )
		extended_sets( class_or_module ).push( extends ) unless extends.empty?
	end

	############################
	#  add_includes_for_class  #
	############################

	def add_includes_for_class( klass, includes )
		included_sets( klass ).push( includes ) unless includes.empty?
	end

	###########################
	#  add_extends_for_class  #
	###########################
	
	def add_extends_for_class( klass, extends )
		extended_sets( klass ).push( extends ) unless extends.empty?
	end

	###################
	#  included_sets  #
	###################

	def included_sets( class_or_module )
		return included_sets_hash[ class_or_module ] ||= Array.new
	end

	###################
	#  extended_sets  #
	###################

	def extended_sets( class_or_module )
		return extended_sets_hash[ class_or_module ] ||= Array.new
	end

	####################
	#  set_as_cluster  #
	####################

	def set_as_cluster( class_or_module )
		return cluster_hash[ class_or_module ] = true
	end

	##############
	#  cluster?  #
	##############

	def cluster?( class_or_module )
		return cluster_hash[ class_or_module ]
	end

end
