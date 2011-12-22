
module ModuleCluster::ClusterStack::PrependsExtends
  
  #############################
  #  prepending_extend_hooks  #
  #############################

  def prepending_extend_hooks
    return @prepending_extend_hooks ||= Array.new
  end
  
  ##############################
  #  extend_prepends_includes  #
  ##############################
  
  def extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include, includes, runtime_includes_block ) )
  end

  #############################
  #  extend_prepends_extends  #
  #############################
  
  def extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :extend, extends, runtime_extends_block ) )
  end

  ##########################################
  #  extend_prepends_includes_and_extends  #
  ##########################################
  
  def extend_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  #####################################
  #  module_extend_prepends_includes  #
  #####################################
  
  def module_extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include, includes, runtime_includes_block ) )
  end

  ####################################
  #  module_extend_prepends_extends  #
  ####################################
  
  def module_extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :extend, extends, runtime_extends_block ) )
  end

  #################################################
  #  module_extend_prepends_includes_and_extends  #
  #################################################
  
  def module_extend_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ####################################
  #  class_extend_prepends_includes  #
  ####################################
  
  def class_extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include, includes, runtime_includes_block ) )
  end

  ###################################
  #  class_extend_prepends_extends  #
  ###################################
  
  def class_extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :extend, extends, runtime_extends_block ) )
  end

  ################################################
  #  class_extend_prepends_includes_and_extends  #
  ################################################
  
  def class_extend_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  #######################################
  #  instance_extend_prepends_includes  #
  #######################################
  
  def instance_extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :include, includes, runtime_includes_block ) )
  end

  ######################################
  #  instance_extend_prepends_extends  #
  ######################################
  
  def instance_extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :extend, extends, runtime_extends_block ) )
  end

  ###################################################
  #  instance_extend_prepends_includes_and_extends  #
  ###################################################
  
  def instance_extend_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_extend_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :instance, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end
  
end
