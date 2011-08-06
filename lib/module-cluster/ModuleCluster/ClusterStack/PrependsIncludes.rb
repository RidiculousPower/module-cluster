
module ModuleCluster::ClusterStack::PrependsIncludes
  
  ###################################
  #  cascading_prepending_includes  #
  ###################################

  def cascading_prepending_includes
    return @cascading_prepending_includes ||= Array.new
  end
  
  ###############################
  #  include_prepends_includes  #
  ###############################
  
  def include_prepends_includes( module_instance, method, includes, runtime_includes_block )
    cascading_prepending_includes.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  ##############################
  #  include_prepends_extends  #
  ##############################
  
  def include_prepends_extends( module_instance, method, extends, runtime_extends_block )
    cascading_prepending_includes.push( ModuleCluster::ClusterStack::Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end
  
end
