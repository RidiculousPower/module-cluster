
module ::ModuleCluster::Define::Block::ModuleOrInstance
  
  include ::ModuleCluster::Define::Block::Module
  include ::ModuleCluster::Define::Block::Instance
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return false
  end

  ###############################
  #  module_or_instance_extend  #
  ###############################

  def module_or_instance_extend( & runtime_block )
    module_set = module_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

  #######################################
  #  module_include_or_instance_extend  #
  #######################################

  def module_include_or_instance_extend( & runtime_block )
    module_set = module_include( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

  #################################################
  #  module_include_or_extend_or_instance_extend  #
  #################################################

  def module_include_or_extend_or_instance_extend( & runtime_block )
    module_set = module_include_or_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

  #######################################
  #  prepend_module_or_instance_extend  #
  #######################################

  def prepend_module_or_instance_extend( & runtime_block )
    module_set = prepend_module_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

  ###############################################
  #  prepend_module_include_or_instance_extend  #
  ###############################################

  def prepend_module_include_or_instance_extend( & runtime_block )
    module_set = prepend_module_include( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

  #########################################################
  #  prepend_module_include_or_extend_or_instance_extend  #
  #########################################################

  def prepend_module_include_or_extend_or_instance_extend( & runtime_block )
    module_set = prepend_module_include_or_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, instance_set )
  end

end
