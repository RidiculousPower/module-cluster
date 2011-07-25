
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

	################################################
	#  add_cascading_includes_for_class_or_module  #
	################################################

	def add_cascading_includes_for_class_or_module( class_or_module, includes )
		included_sets( class_or_module ).push( includes ) unless includes.empty?
	end

	###############################################
	#  add_cascading_extends_for_class_or_module  #
	###############################################
	
	def add_cascading_extends_for_class_or_module( class_or_module, extends )
		extended_sets( class_or_module ).push( extends ) unless extends.empty?
	end

	######################################
	#  add_cascading_includes_for_class  #
	######################################

	def add_cascading_includes_for_class( klass, includes )
		included_sets( klass ).push( includes ) unless includes.empty?
	end

	#####################################
	#  add_cascading_extends_for_class  #
	#####################################
	
	def add_cascading_extends_for_class( klass, extends )
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

	def set_as_cluster( class_or_module, includes, extends )
		includes_cluster_hash_for_class_or_module( class_or_module ).concat( includes )
		extends_cluster_hash_for_class_or_module( class_or_module ).concat( extends )
		return self
	end

	######################
	#  include_cluster?  #
	######################

	def include_cluster?( class_or_module, *modules )
		include_set_as_cluster = true
		modules.each do |this_module|
			include_set_as_cluster = false unless includes_cluster_hash_for_class_or_module( class_or_module ).include?( this_module )
			break unless include_set_as_cluster
		end
		return include_set_as_cluster
	end

	#####################
	#  extend_cluster?  #
	#####################

	def extend_cluster?( class_or_module, *modules )
		extend_set_as_cluster = true
		modules.each do |this_module|
			extend_set_as_cluster = false unless extends_cluster_hash_for_class_or_module( class_or_module ).include?( this_module )
			break unless extend_set_as_cluster
		end
		return extend_set_as_cluster
	end

end
