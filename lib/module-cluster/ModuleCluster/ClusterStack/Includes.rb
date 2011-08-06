
module ModuleCluster::ClusterStack::Includes

  ########################
  #  cascading_includes  #
  ########################

  def cascading_includes
    return @cascading_includes ||= Array.new
  end

  ######################
  #  include_includes  #
  ######################

  def include_includes( module_instance, method, includes, runtime_includes_block )
    cascading_includes.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  #####################
  #  include_extends  #
  #####################
  
  def include_extends( module_instance, method, extends, runtime_extends_block )
    cascading_includes.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end
  
end
