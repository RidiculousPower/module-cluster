
module ModuleCluster::Define::ModuleClusterCascadesToClass

  include ModuleCluster::Define::AnonymousModule

  ########################
  #  self.include_block  #
  ########################
  
  def self.include_block( cascade_method, *includes )
    return Proc.new do
      unless ( includes -= ancestors ).empty?
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        __send__( cascade_method, *includes )
        include( *includes.reverse ) if is_a?( Class )
      end
    end
  end

  #######################
  #  self.extend_block  #
  #######################
  
  def self.extend_block( cascade_method, *extends )
    return Proc.new do
      eigenclass = class << self ; self ; end
      unless ( extends -= eigenclass.ancestors ).empty?
        extend ModuleCluster::Define::ModuleClusterCascadesToClass
        __send__( cascade_method, *extends )
        extend( *extends.reverse ) if is_a?( Class )
      end
    end
  end
  
	########################################
	#  include_cascades_includes_to_class  #
	########################################

	def include_cascades_includes_to_class( *includes )
    include_block = ModuleCluster::Define::ModuleClusterCascadesToClass.include_block( :include_cascades_includes_to_class, *includes )
	  includes_module = anonymous_module_for_included( 'CascadesToClass', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

	def include_cascades_extends_to_class( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToClass.extend_block( :include_cascades_extends_to_class, *extends )
	  extends_module = anonymous_module_for_included( 'CascadesToClass', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToClass.include_block( :extend_cascades_includes_to_class, *includes )
	  includes_module = anonymous_module_for_extended( 'CascadesToClass', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

	def extend_cascades_extends_to_class( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToClass.extend_block( :extend_cascades_extends_to_class, *extends )
	  extends_module = anonymous_module_for_extended( 'CascadesToClass', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToClass.include_block( :include_cascades_to_class_prepending_includes, *includes )
	  includes_module = anonymous_module_for_append_features( 'CascadesToClass', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##################################################
	#  include_cascades_to_class_prepending_extends  #
	##################################################

	def include_cascades_to_class_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToClass.extend_block( :include_cascades_to_class_prepending_extends, *extends )
	  extends_module = anonymous_module_for_append_features( 'CascadesToClass', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToClass.include_block( :extend_cascades_to_class_prepending_includes, *includes )
	  includes_module = anonymous_module_for_extend_object( 'CascadesToClass', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#################################################
	#  extend_cascades_to_class_prepending_extends  #
	#################################################

	def extend_cascades_to_class_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToClass.extend_block( :extend_cascades_to_class_prepending_extends, *extends )
	  extends_module = anonymous_module_for_extend_object( 'CascadesToClass', & extend_block )
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
