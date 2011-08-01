
module ModuleCluster::Define::ModuleClusterCascades

  include ModuleCluster::Define::AnonymousModule

	###############################
	#  include_cascades_includes  #
	###############################

	def include_cascades_includes( *includes )
	  includes_module = anonymous_module_for_included( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      include_cascades_includes( *includes )
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##############################
	#  include_cascades_extends  #
	##############################

	def include_cascades_extends( *extends )
	  extends_module = anonymous_module_for_included( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      include_cascades_extends( *extends )
      extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	###########################################
	#  include_cascades_includes_and_extends  #
	###########################################

	def include_cascades_includes_and_extends( *includes_and_extends )
		include_cascades_includes( *includes_and_extends )
		include_cascades_extends( *includes_and_extends )
		return self
	end

	##############################
	#  extend_cascades_includes  #
	##############################

	def extend_cascades_includes( *includes )
	  includes_module = anonymous_module_for_extended( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      extend_cascades_includes( *includes )
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#############################
	#  extend_cascades_extends  #
	#############################

	def extend_cascades_extends( *extends )
	  extends_module = anonymous_module_for_extended( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      extend_cascades_extends( *extends )
      extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	##########################################
	#  extend_cascades_includes_and_extends  #
	##########################################

	def extend_cascades_includes_and_extends( *includes_and_extends )
		extend_cascades_includes( *includes_and_extends )
		extend_cascades_extends( *includes_and_extends )
		return self
	end

	##########################################
	#  include_cascades_prepending_includes  #
	##########################################

	def include_cascades_prepending_includes( *includes )
	  includes_module = anonymous_module_for_append_features( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      include_cascades_prepending_includes( *includes )
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#########################################
	#  include_cascades_prepending_extends  #
	#########################################

	def include_cascades_prepending_extends( *extends )
	  extends_module = anonymous_module_for_append_features( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      include_cascades_prepending_extends( *extends )
      extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	######################################################
	#  include_cascades_prepending_includes_and_extends  #
	######################################################

	def include_cascades_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_prepending_includes( *includes_and_extends )
		include_cascades_prepending_extends( *includes_and_extends )
		return self
	end

	#########################################
	#  extend_cascades_prepending_includes  #
	#########################################

	def extend_cascades_prepending_includes( *includes )
	  includes_module = anonymous_module_for_extend_object( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      extend_cascades_prepending_includes( *includes )
      includes.each do |this_module|
        include( this_module )
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	########################################
	#  extend_cascades_prepending_extends  #
	########################################

	def extend_cascades_prepending_extends( *extends )
	  extends_module = anonymous_module_for_extend_object( 'Cascades' ) do
      extend ModuleCluster::Define::ModuleClusterCascades
      extend_cascades_prepending_extends( *extends )
      extends.each do |this_module|
        extend( this_module )
      end
    end
    clusterstack_module { include( extends_module ) }
		return self
	end
	
	#####################################################
	#  extend_cascades_prepending_includes_and_extends  #
	#####################################################

	def extend_cascades_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_prepending_includes( *includes_and_extends )
		extend_cascades_prepending_extends( *includes_and_extends )
		return self
	end

end
