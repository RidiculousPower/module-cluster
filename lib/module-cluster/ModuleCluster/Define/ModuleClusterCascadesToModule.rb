
module ModuleCluster::Define::ModuleClusterCascadesToModule

  include ModuleCluster::Define::AnonymousModule

	#########################################
	#  include_cascades_includes_to_module  #
	#########################################

	def include_cascades_includes_to_module( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_included( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          include_cascades_includes_to_module( *includes )
          include( *includes.reverse )
        end
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	########################################
	#  include_cascades_extends_to_module  #
	########################################

	def include_cascades_extends_to_module( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_included( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          include_cascades_extends_to_module( *extends )
          extend( *extends.reverse )
        end
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	#####################################################
	#  include_cascades_includes_and_extends_to_module  #
	#####################################################

	def include_cascades_includes_and_extends_to_module( *includes_and_extends )
		include_cascades_includes_to_module( *includes_and_extends )
		include_cascades_extends_to_module( *includes_and_extends )
		return self
	end

	########################################
	#  extend_cascades_includes_to_module  #
	########################################

	def extend_cascades_includes_to_module( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extended( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          extend_cascades_includes_to_module( *includes )
          include( *includes.reverse )
        end
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	#######################################
	#  extend_cascades_extends_to_module  #
	#######################################

	def extend_cascades_extends_to_module( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extended( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          extend_cascades_extends_to_module( *extends )
          extend( *extends.reverse )
        end
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	####################################################
	#  extend_cascades_includes_and_extends_to_module  #
	####################################################

	def extend_cascades_includes_and_extends_to_module( *includes_and_extends )
		extend_cascades_includes_to_module( *includes_and_extends )
		extend_cascades_extends_to_module( *includes_and_extends )
		return self
	end

	####################################################
	#  include_cascades_to_module_prepending_includes  #
	####################################################

	def include_cascades_to_module_prepending_includes( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_append_features( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          include_cascades_to_module_prepending_includes( *includes )
          include( *includes.reverse )
        end
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	###################################################
	#  include_cascades_to_module_prepending_extends  #
	###################################################

	def include_cascades_to_module_prepending_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_append_features( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          include_cascades_to_module_prepending_extends( *extends )
          extend( *extends.reverse )
        end
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	################################################################
	#  include_cascades_to_module_prepending_includes_and_extends  #
	################################################################

	def include_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
		include_cascades_to_module_prepending_includes( *includes_and_extends )
		include_cascades_to_module_prepending_extends( *includes_and_extends )
		return self
	end

	###################################################
	#  extend_cascades_to_module_prepending_includes  #
	###################################################

	def extend_cascades_to_module_prepending_includes( *includes )
	  unless ( includes -= ancestors ).empty?
  	  includes_module = anonymous_module_for_extend_object( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          extend_cascades_to_module_prepending_includes( *includes )
          include( *includes.reverse )
        end
      end
      clusterstack_module { include( includes_module ) }
    end
		return self
	end
	
	##################################################
	#  extend_cascades_to_module_prepending_extends  #
	##################################################

	def extend_cascades_to_module_prepending_extends( *extends )
	  unless ( extends -= eigenclass.ancestors ).empty?
  	  extends_module = anonymous_module_for_extend_object( 'CascadesToModule' ) do
        unless is_a?( Class )
          extend ModuleCluster::Define::ModuleClusterCascadesToModule
          extend_cascades_to_module_prepending_extends( *extends )
          extend( *extends.reverse )
        end
      end
      clusterstack_module { include( extends_module ) }
    end
		return self
	end
	
	###############################################################
	#  extend_cascades_to_module_prepending_includes_and_extends  #
	###############################################################

	def extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
		extend_cascades_to_module_prepending_includes( *includes_and_extends )
		extend_cascades_to_module_prepending_extends( *includes_and_extends )
		return self
	end

	###################################################
	#  include_or_extend_cascades_includes_to_module  #
	###################################################

  def include_or_extend_cascades_includes_to_module( *includes )
    include_cascades_includes_to_module( *includes )
    extend_cascades_includes_to_module( *includes )
		return self
  end

	##################################################
	#  include_or_extend_cascades_extends_to_module  #
	##################################################

  def include_or_extend_cascades_extends_to_module( *extends )
    include_cascades_extends_to_module( *extends )
    extend_cascades_extends_to_module( *extends )
		return self
  end

	###############################################################
	#  include_or_extend_cascades_includes_and_extends_to_module  #
	###############################################################

  def include_or_extend_cascades_includes_and_extends_to_module( *includes_and_extends )
    include_cascades_includes_and_extends_to_module( *includes_and_extends )
    extend_cascades_includes_and_extends_to_module( *includes_and_extends )
		return self
  end

	##############################################################
	#  include_or_extend_cascades_to_module_prepending_includes  #
	##############################################################

  def include_or_extend_cascades_to_module_prepending_includes( *includes )
    include_cascades_to_module_prepending_includes( *includes )
    extend_cascades_to_module_prepending_includes( *includes )
		return self
  end

	#############################################################
	#  include_or_extend_cascades_to_module_prepending_extends  #
	#############################################################

  def include_or_extend_cascades_to_module_prepending_extends( *extends )
    include_cascades_to_module_prepending_extends( *extends )
    extend_cascades_to_module_prepending_extends( *extends )
		return self
  end

	##########################################################################
	#  include_or_extend_cascades_to_module_prepending_includes_and_extends  #
	##########################################################################
	
  def include_or_extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
    include_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
    extend_cascades_to_module_prepending_includes_and_extends( *includes_and_extends )
		return self
  end

end
