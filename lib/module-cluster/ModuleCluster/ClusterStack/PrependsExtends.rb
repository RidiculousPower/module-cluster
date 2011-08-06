
module ModuleCluster::ClusterStack::PrependsExtends
  
  ##################################
  #  cascading_prepending_extends  #
  ##################################

  def cascading_prepending_extends
    return @cascading_prepending_extends ||= Array.new
  end
  
  ##############################
  #  extend_prepends_includes  #
  ##############################
  
  def extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    cascading_prepending_extends.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  #############################
  #  extend_prepends_extends  #
  #############################
  
  def extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    cascading_prepending_extends.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end
  
end
