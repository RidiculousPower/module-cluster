
module ModuleCluster::Define::ModuleClusterCascadesToClass

  include ModuleCluster::Define::AnonymousModule

	########################################
	#  include_cascades_includes_to_class  #
	########################################

	def include_cascades_includes_to_class( *includes )
	  includes_module = anonymous_module_for_included( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      include_cascades_includes_to_class( *includes )
      if is_a?( Class )
        includes.each do |this_module|
          include( this_module )
        end
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

	def include_cascades_extends_to_class( *extends )
	  extends_module = anonymous_module_for_included( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      include_cascades_extends_to_class( *extends )
      if is_a?( Class )
        extends.each do |this_module|
          extend( this_module )
        end
      end
    end
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_extended( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      extend_cascades_includes_to_class( *includes )
      if is_a?( Class )
        includes.each do |this_module|
          include( this_module )
        end
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

	def extend_cascades_extends_to_class( *extends )
	  extends_module = anonymous_module_for_extended( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      extend_cascades_extends_to_class( *extends )
      if is_a?( Class )
        extends.each do |this_module|
          extend( this_module )
        end
      end
    end
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_append_features( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      include_cascades_to_class_prepending_includes( *includes )
      if is_a?( Class )
        includes.each do |this_module|
          include( this_module )
        end
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##################################################
	#  include_cascades_to_class_prepending_extends  #
	##################################################

	def include_cascades_to_class_prepending_extends( *extends )
	  extends_module = anonymous_module_for_append_features( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      include_cascades_to_class_prepending_extends( *extends )
      if is_a?( Class )
        extends.each do |this_module|
          extend( this_module )
        end
      end
    end
    clusterstack_module { include( extends_module ) }
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
	  includes_module = anonymous_module_for_extend_object( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      extend_cascades_to_class_prepending_includes( *includes )
      if is_a?( Class )
        includes.each do |this_module|
          include( this_module )
        end
      end
    end
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#################################################
	#  extend_cascades_to_class_prepending_extends  #
	#################################################

	def extend_cascades_to_class_prepending_extends( *extends )
	  extends_module = anonymous_module_for_extend_object( 'CascadesToClass' ) do
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      extend_cascades_to_class_prepending_extends( *extends )
      if is_a?( Class )
        extends.each do |this_module|
          extend( this_module )
        end
      end
    end
    clusterstack_module { include( extends_module ) }
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
