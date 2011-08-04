
module ModuleCluster::Define::ModuleClusterCascadesToModule

  include ModuleCluster::Define::AnonymousModule

  ########################
  #  self.include_block  #
  ########################
  
  def self.include_block( cascade_method, *includes )
    return Proc.new do
      unless is_a?( Class )
        extend ModuleCluster::Define::ModuleClusterCascadesToModule
        __send__( cascade_method, *includes )
        unless ( includes -= ancestors ).empty?
          include( *includes.reverse )
        end
      end
    end
  end

  #######################
  #  self.extend_block  #
  #######################
  
  def self.extend_block( cascade_method, *extends )
    return Proc.new do
      unless is_a?( Class )
        eigenclass = class << self ; self ; end
        extend ModuleCluster::Define::ModuleClusterCascadesToModule
        __send__( cascade_method, *extends )
        unless ( extends -= eigenclass.ancestors ).empty?
          extend( *extends.reverse )
        end
      end
    end
  end
  
	#########################################
	#  include_cascades_includes_to_module  #
	#########################################

	def include_cascades_includes_to_module( *includes )
    include_block = ModuleCluster::Define::ModuleClusterCascadesToModule.include_block( :include_cascades_includes_to_module, *includes )
	  includes_module = anonymous_module_for_included( 'CascadesToModule', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	########################################
	#  include_cascades_extends_to_module  #
	########################################

	def include_cascades_extends_to_module( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToModule.extend_block( :include_cascades_extends_to_module, *extends )
	  extends_module = anonymous_module_for_included( 'CascadesToModule', & extend_block )
    clusterstack_module { include( extends_module ) }
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToModule.include_block( :extend_cascades_includes_to_module, *includes )
	  includes_module = anonymous_module_for_extended( 'CascadesToModule', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	#######################################
	#  extend_cascades_extends_to_module  #
	#######################################

	def extend_cascades_extends_to_module( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToModule.extend_block( :extend_cascades_extends_to_module, *extends )
	  extends_module = anonymous_module_for_extended( 'CascadesToModule', & extend_block )
    clusterstack_module { include( extends_module ) }
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToModule.include_block( :include_cascades_to_module_prepending_includes, *includes )
	  includes_module = anonymous_module_for_append_features( 'CascadesToModule', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	###################################################
	#  include_cascades_to_module_prepending_extends  #
	###################################################

	def include_cascades_to_module_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToModule.extend_block( :include_cascades_to_module_prepending_extends, *extends )
	  extends_module = anonymous_module_for_append_features( 'CascadesToModule', & extend_block )
    clusterstack_module { include( extends_module ) }
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
    include_block = ModuleCluster::Define::ModuleClusterCascadesToModule.include_block( :extend_cascades_to_module_prepending_includes, *includes )
	  includes_module = anonymous_module_for_extend_object( 'CascadesToModule', & include_block )
    clusterstack_module { include( includes_module ) }
		return self
	end
	
	##################################################
	#  extend_cascades_to_module_prepending_extends  #
	##################################################

	def extend_cascades_to_module_prepending_extends( *extends )
    extend_block = ModuleCluster::Define::ModuleClusterCascadesToModule.extend_block( :extend_cascades_to_module_prepending_extends, *extends )
	  extends_module = anonymous_module_for_extend_object( 'CascadesToModule', & extend_block )
    clusterstack_module { include( extends_module ) }
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
