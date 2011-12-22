
module ModuleCluster::ClusterStack::Extends
  
  ##################
  #  extend_hooks  #
  ##################

  def extend_hooks
    return @extend_hooks ||= Array.new
  end

  #####################
  #  extend_includes  #
  #####################
  
  def extend_includes( module_instance, method, includes, runtime_includes_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include, includes, runtime_includes_block ) )
  end
  
  ####################
  #  extend_extends  #
  ####################

  def extend_extends( module_instance, method, extends, runtime_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :extend, extends, runtime_extends_block ) )
  end

  #################################
  #  extend_includes_and_extends  #
  #################################
  
  def extend_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ############################
  #  module_extend_includes  #
  ############################
  
  def module_extend_includes( module_instance, method, includes, runtime_includes_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include, includes, runtime_includes_block ) )
  end
  
  ###########################
  #  module_extend_extends  #
  ###########################

  def module_extend_extends( module_instance, method, extends, runtime_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :extend, extends, runtime_extends_block ) )
  end

  ########################################
  #  module_extend_includes_and_extends  #
  ########################################
  
  def module_extend_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ###########################
  #  class_extend_includes  #
  ###########################
  
  def class_extend_includes( module_instance, method, includes, runtime_includes_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include, includes, runtime_includes_block ) )
  end
  
  ##########################
  #  class_extend_extends  #
  ##########################

  def class_extend_extends( module_instance, method, extends, runtime_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :extend, extends, runtime_extends_block ) )
  end

  #######################################
  #  class_extend_includes_and_extends  #
  #######################################
  
  def class_extend_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ##############################
  #  instance_extend_includes  #
  ##############################
  
  def instance_extend_includes( module_instance, method, includes, runtime_includes_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :include, includes, runtime_includes_block ) )
  end
  
  #############################
  #  instance_extend_extends  #
  #############################

  def instance_extend_extends( module_instance, method, extends, runtime_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :extend, extends, runtime_extends_block ) )
  end

  ##########################################
  #  instance_extend_includes_and_extends  #
  ##########################################
  
  def instance_extend_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end
  
end
