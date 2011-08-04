
module ModuleCluster::Define::ModuleClusterCascades

  include ModuleCluster::Define::AnonymousModule
  
  ########################
  #  self.include_block  #
  ########################
  
  def self.include_block( cascade_method, *includes )
    return Proc.new do
      unless ( includes -= ancestors ).empty?
        extend ModuleCluster::Define::ModuleClusterCascades
        __send__( cascade_method, *includes )
        include( *includes.reverse )
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
        extend ModuleCluster::Define::ModuleClusterCascades
        __send__( cascade_method, *extends )
        extend( *extends.reverse )
      end
    end
  end

	###############################
	#  include_cascades_includes  #
	###############################

	def include_cascades_includes( *includes )
    include_block = ModuleCluster::Define::ModuleClusterCascades.include_block( :include_cascades_includes, *includes )
	  includes_module = anonymous_module_for_included( 'Cascades', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##############################
	#  include_cascades_extends  #
	##############################

	def include_cascades_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascades.extend_block( :include_cascades_extends, *extends )
	  extends_module = anonymous_module_for_included( 'Cascades', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascades.include_block( :extend_cascades_includes, *includes )
	  includes_module = anonymous_module_for_extended( 'Cascades', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#############################
	#  extend_cascades_extends  #
	#############################

	def extend_cascades_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascades.extend_block( :extend_cascades_extends, *extends )
	  extends_module = anonymous_module_for_extended( 'Cascades', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascades.include_block( :include_cascades_prepending_includes, *includes )
	  includes_module = anonymous_module_for_append_features( 'Cascades', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#########################################
	#  include_cascades_prepending_extends  #
	#########################################

	def include_cascades_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascades.extend_block( :include_cascades_prepending_extends, *extends )
	  extends_module = anonymous_module_for_append_features( 'Cascades', & extend_block )
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
    include_block = ModuleCluster::Define::ModuleClusterCascades.include_block( :extend_cascades_prepending_includes, *includes )
	  includes_module = anonymous_module_for_extend_object( 'Cascades', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	########################################
	#  extend_cascades_prepending_extends  #
	########################################

	def extend_cascades_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascades.extend_block( :extend_cascades_prepending_extends, *extends )
	  extends_module = anonymous_module_for_extend_object( 'Cascades', & extend_block )
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

	#########################################
	#  include_or_extend_cascades_includes  #
	#########################################

  def include_or_extend_cascades_includes( *includes )
    include_cascades_includes( *includes )
    extend_cascades_includes( *includes )
		return self
  end

	########################################
	#  include_or_extend_cascades_extends  #
	########################################

  def include_or_extend_cascades_extends( *extends )
    include_cascades_extends( *extends )
    extend_cascades_extends( *extends )
		return self
  end

	#####################################################
	#  include_or_extend_cascades_includes_and_extends  #
	#####################################################

  def include_or_extend_cascades_includes_and_extends( *includes_and_extends )
    include_cascades_includes_and_extends( *includes_and_extends )
    extend_cascades_includes_and_extends( *includes_and_extends )
		return self
  end

	####################################################
	#  include_or_extend_cascades_prepending_includes  #
	####################################################

  def include_or_extend_cascades_prepending_includes( *includes )
    include_cascades_includes( *includes )
    extend_cascades_includes( *includes )
		return self
  end

	###################################################
	#  include_or_extend_cascades_prepending_extends  #
	###################################################

  def include_or_extend_cascades_prepending_extends( *extends )
    include_cascades_extends( *extends )
    extend_cascades_extends( *extends )
		return self
  end

	################################################################
	#  include_or_extend_cascades_prepending_includes_and_extends  #
	################################################################

  def include_or_extend_cascades_prepending_includes_and_extends( *includes_and_extends )
    include_cascades_prepending_includes_and_extends( *includes_and_extends )
    extend_cascades_prepending_includes_and_extends( *includes_and_extends )
		return self
  end

end
