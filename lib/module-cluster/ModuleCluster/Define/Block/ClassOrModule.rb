
module ModuleCluster::Define::Block::ClassOrModule
  
  include ::ModuleCluster::Define::Block::Class
  include ::ModuleCluster::Define::Block::Module
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  #############################
  #  class_or_module_include  #
  #############################

  def class_or_module_include( & runtime_block )
    class_set = class_include( & runtime_block )
    module_set = module_include( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  ############################
  #  class_or_module_extend  #
  ############################

  def class_or_module_extend( & runtime_block )
    class_set = class_extend( & runtime_block )
    module_set = module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  #######################################
  #  class_or_module_include_or_extend  #
  #######################################

  def class_or_module_include_or_extend( & runtime_block )
    include_set = class_or_module_include( & runtime_block )
    extend_set = class_or_module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  #####################################
  #  prepend_class_or_module_include  #
  #####################################

  def prepend_class_or_module_include( & runtime_block )
    class_set = prepend_class_include( & runtime_block )
    module_set = prepend_module_include( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  ####################################
  #  prepend_class_or_module_extend  #
  ####################################

  def prepend_class_or_module_extend( & runtime_block )
    class_set = prepend_class_extend( & runtime_block )
    module_set = prepend_module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  ###############################################
  #  prepend_class_or_module_include_or_extend  #
  ###############################################

  def prepend_class_or_module_include_or_extend( & runtime_block )
    include_set = prepend_class_or_module_include( & runtime_block )
    extend_set = prepend_class_or_module_extend( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
  
end
