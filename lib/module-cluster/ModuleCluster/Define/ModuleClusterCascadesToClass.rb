
module ModuleCluster::Define::ModuleClusterCascadesToClass

  include ModuleCluster::Define::AnonymousModule

	########################################
	#  include_cascades_includes_to_class  #
	########################################

	def include_cascades_includes_to_class( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_included( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        include_cascades_includes_to_class( *includes )
        include( *includes.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

	def include_cascades_extends_to_class( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_included( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        include_cascades_extends_to_class( *extends )
        extend( *extends.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	####################################################
	#  include_cascades_includes_and_extends_to_class  #
	####################################################

	def include_cascades_includes_and_extends_to_class( *includes_and_extends )
		include_cascades_includes_to_class( *includes_and_extends )
		include_cascades_extends_to_class( *includes_and_extends )
		return self
	end

	#######################################
	#  extend_cascades_includes_to_class  #
	#######################################

	def extend_cascades_includes_to_class( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extended( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        extend_cascades_includes_to_class( *includes )
        include( *includes.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

	def extend_cascades_extends_to_class( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extended( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        extend_cascades_extends_to_class( *extends )
        extend( *extends.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	###################################################
	#  extend_cascades_includes_and_extends_to_class  #
	###################################################

	def extend_cascades_includes_and_extends_to_class( *includes_and_extends )
		extend_cascades_includes_to_class( *includes_and_extends )
		extend_cascades_extends_to_class( *includes_and_extends )
		return self
	end

	###################################################
	#  include_cascades_to_class_prepending_includes  #
	###################################################

	def include_cascades_to_class_prepending_includes( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_append_features( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        include_cascades_to_class_prepending_includes( *includes )
        include( *includes.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	##################################################
	#  include_cascades_to_class_prepending_extends  #
	##################################################

	def include_cascades_to_class_prepending_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_append_features( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        include_cascades_to_class_prepending_extends( *extends )
        extend( *extends.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	###############################################################
	#  include_cascades_to_class_prepending_includes_and_extends  #
	###############################################################

	def include_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_to_class_prepending_includes( *includes_and_extends )
		include_cascades_to_class_prepending_extends( *includes_and_extends )
		return self
	end

	##################################################
	#  extend_cascades_to_class_prepending_includes  #
	##################################################

	def extend_cascades_to_class_prepending_includes( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extend_object( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        extend_cascades_to_class_prepending_includes( *includes )
        include( *includes.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	#################################################
	#  extend_cascades_to_class_prepending_extends  #
	#################################################

	def extend_cascades_to_class_prepending_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extend_object( 'CascadesToClass' ) do
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        extend_cascades_to_class_prepending_extends( *extends )
        extend( *extends.reverse ) if is_a?( Class )
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	##############################################################
	#  extend_cascades_to_class_prepending_includes_and_extends  #
	##############################################################

	def extend_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_to_class_prepending_includes( *includes_and_extends )
		extend_cascades_to_class_prepending_extends( *includes_and_extends )
		return self
	end

	##################################################
	#  include_or_extend_cascades_includes_to_class  #
	##################################################

  def include_or_extend_cascades_includes_to_class( *includes )
    include_cascades_includes_to_class( *includes )
    extend_cascades_includes_to_class( *includes )
		return self
  end

	#################################################
	#  include_or_extend_cascades_extends_to_class  #
	#################################################

  def include_or_extend_cascades_extends_to_class( *extends )
    include_cascades_extends_to_class( *extends )
    extend_cascades_extends_to_class( *extends )
		return self
  end

	##############################################################
	#  include_or_extend_cascades_includes_and_extends_to_class  #
	##############################################################

  def include_or_extend_cascades_includes_and_extends_to_class( *includes_and_extends )
    include_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
    extend_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		return self
  end

	#############################################################
	#  include_or_extend_cascades_to_class_prepending_includes  #
	#############################################################

  def include_or_extend_cascades_to_class_prepending_includes( *includes )
    include_cascades_to_class_prepending_includes( *includes )
    extend_cascades_to_class_prepending_includes( *includes )
		return self
  end

	############################################################
	#  include_or_extend_cascades_to_class_prepending_extends  #
	############################################################

  def include_or_extend_cascades_to_class_prepending_extends( *extends )
    include_cascades_to_class_prepending_includes( *extends )
    extend_cascades_to_class_prepending_includes( *extends )
		return self
  end

	#########################################################################
	#  include_or_extend_cascades_to_class_prepending_includes_and_extends  #
	#########################################################################
	
	def include_or_extend_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
    include_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
    extend_cascades_to_class_prepending_includes_and_extends( *includes_and_extends )
		return self
  end
  
end
