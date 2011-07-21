
module ModuleCluster::IncludeExtendSupport

	######################################
	#  set_includes_for_class_or_module  #
	######################################

	def set_includes_for_class_or_module( class_or_module, includes )
		@includes_for_class_or_module ||= Hash.new
		@includes_for_class_or_module[ class_or_module ] ||= Array.new
		@includes_for_class_or_module[ class_or_module ].concat( includes )
	end

	#####################################
	#  set_extends_for_class_or_module  #
	#####################################
	
	def set_extends_for_class_or_module( class_or_module, extends )
		@extends_for_class_or_module ||= Hash.new
		@extends_for_class_or_module[ class_or_module ] ||= Array.new
		@extends_for_class_or_module[ class_or_module ].concat( extends )
	end

	############################################
	#  includes_for_class_or_module_inclusion  #
	############################################

	def includes_for_class_or_module( class_or_module )
		return @includes_for_class_or_module[ class_or_module ]	||= Array.new
	end

	###########################################
	#  extends_for_class_or_module_extension  #
	###########################################

	def extends_for_class_or_module( class_or_module )
		return @extends_for_class_or_module[ class_or_module ] ||= Array.new
	end

end
