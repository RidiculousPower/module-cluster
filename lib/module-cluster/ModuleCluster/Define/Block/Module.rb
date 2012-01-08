
module ModuleCluster::Define::Block::Module
  
  include ModuleCluster::CascadeFeatures::ClusterStack
  include ModuleCluster::Suspend::WithoutHooks
  
  extend ModuleCluster::ExtendForCascade
  
  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return hooked_instance.is_a?( Module ) && ! hooked_instance.is_a?( Class )
  end

  ####################
  #  module_include  #
  ####################

  def module_include( & runtime_block )
    return cluster_stack.module_include( ModuleCluster::Define::Block::Module, runtime_block )
  end

  ###################
  #  module_extend  #
  ###################

  def module_extend( & runtime_block )
    return cluster_stack.module_extend( ModuleCluster::Define::Block::Module, runtime_block )
  end

  ##############################
  #  module_include_or_extend  #
  ##############################

  def module_include_or_extend( & runtime_block )
    include_set = module_include( & runtime_block )
    extend_set = module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  ############################
  #  prepend_module_include  #
  ############################

  def prepend_module_include( & runtime_block )
    return cluster_stack.prepend_module_include( ModuleCluster::Define::Block::Module, runtime_block )
  end

  ###########################
  #  prepend_module_extend  #
  ###########################

  def prepend_module_extend( & runtime_block )
    return cluster_stack.prepend_module_extend( ModuleCluster::Define::Block::Module, runtime_block )
  end

  ######################################
  #  prepend_module_include_or_extend  #
  ######################################

  def prepend_module_include_or_extend( & runtime_block )
    include_set = prepend_module_include( & runtime_block )
    extend_set = prepend_module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
  
end
