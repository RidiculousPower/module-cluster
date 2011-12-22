
module ModuleCluster::ClusterStack::Includes

  ###################
  #  include_hooks  #
  ###################

  def include_hooks
    return @include_hooks ||= Array.new
  end

  ######################
  #  include_includes  #
  ######################

  def include_includes( module_instance, method, includes, runtime_includes_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include, includes, runtime_includes_block ) )
  end

  #####################
  #  include_extends  #
  #####################
  
  def include_extends( module_instance, method, extends, runtime_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :extend, extends, runtime_extends_block ) )
  end

  ##################################
  #  include_includes_and_extends  #
  ##################################
  
  def include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  #############################
  #  module_include_includes  #
  #############################

  def module_include_includes( module_instance, method, includes, runtime_includes_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include, includes, runtime_includes_block ) )
  end

  ############################
  #  module_include_extends  #
  ############################
  
  def module_include_extends( module_instance, method, extends, runtime_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :extend, extends, runtime_extends_block ) )
  end

  #########################################
  #  module_include_includes_and_extends  #
  #########################################
  
  def module_include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ############################
  #  class_include_includes  #
  ############################

  def class_include_includes( module_instance, method, includes, runtime_includes_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include, includes, runtime_includes_block ) )
  end

  ###########################
  #  class_include_extends  #
  ###########################
  
  def class_include_extends( module_instance, method, extends, runtime_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :extend, extends, runtime_extends_block ) )
  end

  ########################################
  #  class_include_includes_and_extends  #
  ########################################
  
  def class_include_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

end
