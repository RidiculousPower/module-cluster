
module ModuleCluster::ClusterStack::PrependsIncludes
  
  ##############################
  #  prepending_include_hooks  #
  ##############################

  def prepending_include_hooks
    return @prepending_include_hooks ||= Array.new
  end
  
  ###############################
  #  include_prepends_includes  #
  ###############################
  
  def include_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include, includes, runtime_includes_block ) )
  end

  ##############################
  #  include_prepends_extends  #
  ##############################
  
  def include_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :extend, extends, runtime_extends_block ) )
  end

  ###########################################
  #  include_prepends_includes_and_extends  #
  ###########################################
  
  def include_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :all, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  ######################################
  #  module_include_prepends_includes  #
  ######################################
  
  def module_include_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include, includes, runtime_includes_block ) )
  end

  #####################################
  #  module_include_prepends_extends  #
  #####################################
  
  def module_include_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :extend, extends, runtime_extends_block ) )
  end

  ##################################################
  #  module_include_prepends_includes_and_extends  #
  ##################################################
  
  def module_include_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :module, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end

  #####################################
  #  class_include_prepends_includes  #
  #####################################
  
  def class_include_prepends_includes( module_instance, method, includes, runtime_includes_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include, includes, runtime_includes_block ) )
  end

  ####################################
  #  class_include_prepends_extends  #
  ####################################
  
  def class_include_prepends_extends( module_instance, method, extends, runtime_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :extend, extends, runtime_extends_block ) )
  end

  #################################################
  #  class_include_prepends_includes_and_extends  #
  #################################################
  
  def class_include_prepends_includes_and_extends( module_instance, method, includes_and_extends, runtime_includes_and_extends_block )
    prepending_include_hooks.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :class, :include_and_extend, includes_and_extends, runtime_includes_and_extends_block ) )
  end
  
end
