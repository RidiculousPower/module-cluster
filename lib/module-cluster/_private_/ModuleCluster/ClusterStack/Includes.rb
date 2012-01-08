
module ModuleCluster::ClusterStack::Includes

  ###################
  #  include_hooks  #
  ###################

  def include_hooks
    return @include_hooks ||= ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new
  end

  ######################
  #  include_includes  #
  ######################

  def include_includes( module_instance, method, includes, runtime_includes_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include, includes, runtime_includes_block )
    include_hooks.push( new_set )
    return new_set
  end

  #####################
  #  include_extends  #
  #####################
  
  def include_extends( module_instance, method, extends, runtime_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :extend, extends, runtime_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  ##################################
  #  include_includes_and_extends  #
  ##################################
  
  def include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  #############################
  #  module_include_includes  #
  #############################

  def module_include_includes( module_instance, method, includes, runtime_includes_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include, includes, runtime_includes_block )
    include_hooks.push( new_set )
    return new_set
  end

  ############################
  #  module_include_extends  #
  ############################
  
  def module_include_extends( module_instance, method, extends, runtime_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :extend, extends, runtime_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  #########################################
  #  module_include_includes_and_extends  #
  #########################################
  
  def module_include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  ############################
  #  class_include_includes  #
  ############################

  def class_include_includes( module_instance, method, includes, runtime_includes_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include, includes, runtime_includes_block )
    include_hooks.push( new_set )
    return new_set
  end

  ###########################
  #  class_include_extends  #
  ###########################
  
  def class_include_extends( module_instance, method, extends, runtime_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :extend, extends, runtime_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  ########################################
  #  class_include_includes_and_extends  #
  ########################################
  
  def class_include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    new_set = ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( new_set )
    return new_set
  end

  #######################
  #  has_include_hook?  #
  #######################
  
  def has_include_hook?( description )
    return include_hooks.hooks_with( description ) || false
  end

end
