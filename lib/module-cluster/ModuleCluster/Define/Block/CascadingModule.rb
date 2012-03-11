
module ::ModuleCluster::Define::Block::CascadingModule
  
  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks
  
  include ::ModuleCluster::Define::Block::Subclass
  
  extend ::ModuleCluster::ExtendForCascade
  
  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return true
  end
  
  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return hooked_instance.is_a?( Module ) && ! hooked_instance.is_a?( Class )
  end

  ##############################
  #  cascading_module_include  #
  ##############################

  def cascading_module_include( & runtime_block )
    return cluster_stack.module_include( ::ModuleCluster::Define::Block::CascadingModule, __method__, runtime_block )
  end

  #############################
  #  cascading_module_extend  #
  #############################

  def cascading_module_extend( & runtime_block )
    return cluster_stack.module_extend( ::ModuleCluster::Define::Block::CascadingModule, __method__, runtime_block )
  end

  ########################################
  #  cascading_module_include_or_extend  #
  ########################################

  def cascading_module_include_or_extend( & runtime_block )
    include_set = cascading_module_include( & runtime_block )
    extend_set = cascading_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  ######################################
  #  cascading_prepend_module_include  #
  ######################################

  def cascading_prepend_module_include( & runtime_block )
    return cluster_stack.prepend_module_include( ::ModuleCluster::Define::Block::CascadingModule, __method__, runtime_block )
  end

  #####################################
  #  cascading_prepend_module_extend  #
  #####################################

  def cascading_prepend_module_extend( & runtime_block )
    return cluster_stack.prepend_module_extend( ::ModuleCluster::Define::Block::CascadingModule, __method__, runtime_block )
  end

  ################################################
  #  cascading_prepend_module_include_or_extend  #
  ################################################

  def cascading_prepend_module_include_or_extend( & runtime_block )
    include_set = cascading_prepend_module_include( & runtime_block )
    extend_set = cascading_prepend_module_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
  
end
