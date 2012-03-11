
module ::ModuleCluster::Define::Block::CascadingClass
    
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
    return hooked_instance.is_a?( Class )
  end

  #############################
  #  cascading_class_include  #
  #############################

  def cascading_class_include( & runtime_block )
    subclass( & runtime_block )
    return cluster_stack.class_include( ::ModuleCluster::Define::Block::CascadingClass, __method__, runtime_block )
  end

  ############################
  #  cascading_class_extend  #
  ############################

  def cascading_class_extend( & runtime_block )
    subclass( & runtime_block )
    return cluster_stack.class_extend( ::ModuleCluster::Define::Block::CascadingClass, __method__, runtime_block )
  end

  #######################################
  #  cascading_class_include_or_extend  #
  #######################################

  def cascading_class_include_or_extend( & runtime_block )
    include_set = cascading_class_include( & runtime_block )
    extend_set = cascading_class_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end

  #####################################
  #  cascading_prepend_class_include  #
  #####################################

  def cascading_prepend_class_include( & runtime_block )
    subclass( & runtime_block )
    return cluster_stack.prepend_class_include( ::ModuleCluster::Define::Block::CascadingClass, __method__, runtime_block )
  end

  ####################################
  #  cascading_prepend_class_extend  #
  ####################################

  def cascading_prepend_class_extend( & runtime_block )
    subclass( & runtime_block )
    return cluster_stack.prepend_class_extend( ::ModuleCluster::Define::Block::CascadingClass, __method__, runtime_block )
  end

  ###############################################
  #  cascading_prepend_class_include_or_extend  #
  ###############################################

  def cascading_prepend_class_include_or_extend( & runtime_block )
    include_set = cascading_prepend_class_include( & runtime_block )
    extend_set = cascading_prepend_class_extend( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( include_set, extend_set )
  end
	
end
