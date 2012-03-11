
module ::ModuleCluster::Define::Block::ClassOrModuleOrInstance
  
  include ::ModuleCluster::Define::Block::ClassOrModule
  include ::ModuleCluster::Define::Block::Instance
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return false
  end

  ########################################
  #  class_or_module_or_instance_extend  #
  ########################################

  def class_or_module_or_instance_extend( & runtime_block )
    class_or_module_set = class_or_module_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

  ################################################
  #  class_or_module_include_or_instance_extend  #
  ################################################

  def class_or_module_include_or_instance_extend( & runtime_block )
    class_or_module_set = class_or_module_include( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

  ##########################################################
  #  class_or_module_include_or_extend_or_instance_extend  #
  ##########################################################

  def class_or_module_include_or_extend_or_instance_extend( & runtime_block )
    class_or_module_set = class_or_module_include_or_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

  ################################################
  #  prepend_class_or_module_or_instance_extend  #
  ################################################

  def prepend_class_or_module_or_instance_extend( & runtime_block )
    class_or_module_set = prepend_class_or_module_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

  ########################################################
  #  prepend_class_or_module_include_or_instance_extend  #
  ########################################################

  def prepend_class_or_module_include_or_instance_extend( & runtime_block )
    class_or_module_set = prepend_class_or_module_include( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

  ##################################################################
  #  prepend_class_or_module_include_or_extend_or_instance_extend  #
  ##################################################################

  def prepend_class_or_module_include_or_extend_or_instance_extend( & runtime_block )
    class_or_module_set = prepend_class_or_module_include_or_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, instance_set )
  end

end
