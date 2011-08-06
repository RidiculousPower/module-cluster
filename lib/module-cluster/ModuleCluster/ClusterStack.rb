
class ModuleCluster::ClusterStack

  Set = Struct.new( :dependency_module, :method, :include_or_extend, :modules, :runtime_includes_or_extends_block )

  ########################
  #  cascading_includes  #
  ########################

  def cascading_includes
    return @cascading_includes ||= Array.new
  end
  
  #######################
  #  cascading_extends  #
  #######################

  def cascading_extends
    return @cascading_extends ||= Array.new
  end

  ###################################
  #  cascading_prepending_includes  #
  ###################################

  def cascading_prepending_includes
    return @cascading_prepending_includes ||= Array.new
  end

  ##################################
  #  cascading_prepending_extends  #
  ##################################

  def cascading_prepending_extends
    return @cascading_prepending_extends ||= Array.new
  end

  ######################
  #  include_includes  #
  ######################

  def include_includes( module_instance, method, includes, runtime_includes_block )
    cascading_includes.push( Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  #####################
  #  include_extends  #
  #####################
  
  def include_extends( module_instance, method, extends, runtime_extends_block )
    cascading_includes.push( Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end

  #####################
  #  extend_includes  #
  #####################
  
  def extend_includes( module_instance, method, includes, runtime_includes_block )
    cascading_extends.push( Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end
  
  ####################
  #  extend_extends  #
  ####################

  def extend_extends( module_instance, method, extends, runtime_extends_block )
    cascading_extends.push( Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end

  ###############################
  #  include_prepends_includes  #
  ###############################
  
  def include_prepends_includes( module_instance, method, includes, runtime_includes_block )
    cascading_prepending_includes.push( Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  ##############################
  #  include_prepends_extends  #
  ##############################
  
  def include_prepends_extends( module_instance, method, extends, runtime_extends_block )
    cascading_prepending_includes.push( Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end

  ##############################
  #  extend_prepends_includes  #
  ##############################
  
  def extend_prepends_includes( module_instance, method, includes, runtime_includes_block )
    cascading_prepending_extends.push( Set.new( module_instance, method, :include, includes, runtime_includes_block ) )
  end

  #############################
  #  extend_prepends_extends  #
  #############################
  
  def extend_prepends_extends( module_instance, method, extends, runtime_extends_block )
    cascading_prepending_extends.push( Set.new( module_instance, method, :extend, extends, runtime_extends_block ) )
  end

end
