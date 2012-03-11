
module ModuleCluster::Define::Block::Class

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return hooked_instance.is_a?( Class )
  end

  ###################
  #  class_include  #
  ###################

  def class_include( & runtime_block )
    return cluster_stack.class_include( ModuleCluster::Define::Block::Class, runtime_block )
  end

  ##################
  #  class_extend  #
  ##################

  def class_extend( & runtime_block )
    return cluster_stack.class_extend( ModuleCluster::Define::Block::Class, runtime_block )
  end

  #############################
  #  class_include_or_extend  #
  #############################

  def class_include_or_extend( & runtime_block )
    include_set = class_include( & runtime_block )
    extend_set = class_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  ###########################
  #  prepend_class_include  #
  ###########################

  def prepend_class_include( & runtime_block )
    return cluster_stack.prepend_class_include( ModuleCluster::Define::Block::Class, runtime_block )
  end

  ##########################
  #  prepend_class_extend  #
  ##########################

  def prepend_class_extend( & runtime_block )
    return cluster_stack.prepend_class_extend( ModuleCluster::Define::Block::Class, runtime_block )
  end

  #####################################
  #  prepend_class_include_or_extend  #
  #####################################

  def prepend_class_include_or_extend( & runtime_block )
    include_set = prepend_class_include( & runtime_block )
    extend_set = prepend_class_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
	
end
