
module ModuleCluster::Define::ModuleCluster
  
  include ModuleCluster::Define::AnonymousModule
  
	###########################
	#  include_also_includes  #
	###########################

	def include_also_includes( *includes )
	  includes_module = anonymous_module_for_included do
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##########################
	#  include_also_extends  #
	##########################
	
	def include_also_extends( *extends )
	  extends_module = anonymous_module_for_included do
	    extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	#######################################
	#  include_also_includes_and_extends  #
	#######################################

	def include_also_includes_and_extends( *includes_and_extends )
		include_also_includes( *includes_and_extends )
		include_also_extends( *includes_and_extends )
		return self
	end

	##########################
	#  extend_also_includes  #
	##########################

	def extend_also_includes( *includes )
	  includes_module = anonymous_module_for_extended do
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#########################
	#  extend_also_extends  #
	#########################
	
	def extend_also_extends( *extends )
	  extends_module = anonymous_module_for_extended do
	    extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	######################################
	#  extend_also_includes_and_extends  #
	######################################

	def extend_also_includes_and_extends( *includes_and_extends )
		extend_also_includes( *includes_and_extends )
		extend_also_extends( *includes_and_extends )
		return self
	end

	###############################
	#  include_prepends_includes  #
	###############################

	def include_prepends_includes( *includes )
	  includes_module = anonymous_module_for_append_features do
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end

	##############################
	#  include_prepends_extends  #
	##############################
	
	def include_prepends_extends( *extends )
	  extends_module = anonymous_module_for_append_features do
	    extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	###########################################
	#  include_prepends_includes_and_extends  #
	###########################################

	def include_prepends_includes_and_extends( *includes_and_extends )
		include_prepends_includes( *includes_and_extends )
		include_prepends_extends( *includes_and_extends )
		return self
	end

	##############################
	#  extend_prepends_includes  #
	##############################

	def extend_prepends_includes( *includes )
	  includes_module = anonymous_module_for_extend_object do
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end

	#############################
	#  extend_prepends_extends  #
	#############################
	
	def extend_prepends_extends( *extends )
	  extends_module = anonymous_module_for_extend_object do
	    extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	##########################################
	#  extend_prepends_includes_and_extends  #
	##########################################

	def extend_prepends_includes_and_extends( *includes_and_extends )
		extend_prepends_includes( *includes_and_extends )
		extend_prepends_extends( *includes_and_extends )
		return self
	end

end
