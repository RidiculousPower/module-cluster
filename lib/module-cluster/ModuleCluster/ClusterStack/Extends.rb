
module ModuleCluster::ClusterStack::Extends
  
  #######################
  #  cascading_extends  #
  #######################

  def cascading_extends
    return @cascading_extends ||= Array.new
  end

  #####################
  #  extend_includes  #
  #####################
  
  def extend_includes( module_instance, method, includes, runtime_includes_block )
    cascading_extends.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end
  
  ####################
  #  extend_extends  #
  ####################

  def extend_extends( module_instance, method, extends, runtime_extends_block )
    cascading_extends.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end

  
end
