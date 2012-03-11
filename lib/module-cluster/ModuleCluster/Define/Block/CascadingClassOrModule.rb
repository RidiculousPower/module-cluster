
module ::ModuleCluster::Define::Block::CascadingClassOrModule
  
  include ::ModuleCluster::Define::Block::CascadingClass
  include ::ModuleCluster::Define::Block::CascadingModule
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade
  
  #######################################
  #  cascading_class_or_module_include  #
  #######################################

  def cascading_class_or_module_include( & runtime_block )
    class_set = cascading_class_include( & runtime_block )
    module_set = cascading_module_include( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  ######################################
  #  cascading_class_or_module_extend  #
  ######################################

  def cascading_class_or_module_extend( & runtime_block )
    class_set = cascading_class_extend( & runtime_block )
    module_set = cascading_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  #################################################
  #  cascading_class_or_module_include_or_extend  #
  #################################################

  def cascading_class_or_module_include_or_extend( & runtime_block )
    include_set = cascading_class_or_module_include( & runtime_block )
    extend_set = cascading_class_or_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  ###############################################
  #  cascading_prepend_class_or_module_include  #
  ###############################################

  def cascading_prepend_class_or_module_include( & runtime_block )
    class_set = cascading_prepend_class_include( & runtime_block )
    module_set = cascading_prepend_module_include( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  ##############################################
  #  cascading_prepend_class_or_module_extend  #
  ##############################################

  def cascading_prepend_class_or_module_extend( & runtime_block )
    class_set = cascading_prepend_class_extend( & runtime_block )
    module_set = cascading_prepend_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, module_set )
  end

  #########################################################
  #  cascading_prepend_class_or_module_include_or_extend  #
  #########################################################

  def cascading_prepend_class_or_module_include_or_extend( & runtime_block )
    include_set = cascading_prepend_class_or_module_include( & runtime_block )
    extend_set = cascading_prepend_class_or_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
  
end
