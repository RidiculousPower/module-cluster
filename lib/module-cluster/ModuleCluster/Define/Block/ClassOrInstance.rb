
module ModuleCluster::Define::Block::ClassOrInstance
  
  include ::ModuleCluster::Define::Block::Class
  include ::ModuleCluster::Define::Block::Instance
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  ##############################
  #  class_or_instance_extend  #
  ##############################

  def class_or_instance_extend( & runtime_block )
    class_set = class_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

  ######################################
  #  class_include_or_instance_extend  #
  ######################################

  def class_include_or_instance_extend( & runtime_block )
    class_set = class_include( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

  ################################################
  #  class_include_or_extend_or_instance_extend  #
  ################################################

  def class_include_or_extend_or_instance_extend( & runtime_block )
    class_set = class_include_or_extend( & runtime_block )
    instance_set = instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

  ######################################
  #  prepend_class_or_instance_extend  #
  ######################################

  def prepend_class_or_instance_extend( & runtime_block )
    class_set = prepend_class_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

  ##############################################
  #  prepend_class_include_or_instance_extend  #
  ##############################################

  def prepend_class_include_or_instance_extend( & runtime_block )
    class_set = prepend_class_include( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

  ########################################################
  #  prepend_class_include_or_extend_or_instance_extend  #
  ########################################################

  def prepend_class_include_or_extend_or_instance_extend( & runtime_block )
    class_set = prepend_class_include_or_extend( & runtime_block )
    instance_set = prepend_instance_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, instance_set )
  end

end
