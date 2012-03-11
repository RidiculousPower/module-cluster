
module ::ModuleCluster::Define::Deprecated

  def define_module_included
    raise NoMethodError, 'This method has been replaced by :include_also_includes and :include_also_extends.'
  end

  def define_module_extended
    raise NoMethodError, 'This method has been replaced by :extend_also_includes and :extend_also_extends.'
  end

  def define_module_cluster
    raise NoMethodError, 'This method has been replaced by :include_also_includes_and_extends and :extend_also_includes_and_extends.'
  end

  def define_module_included_cascades
    raise NoMethodError, 'This method has been replaced by :include_cascades_includes and :include_cascades_extends.'
  end

  def define_module_extended_cascades
    raise NoMethodError, 'This method has been replaced by :extend_cascades_includes and :extend_cascades_extends.'
  end

  def define_module_cluster_cascades
    raise NoMethodError, 'This method has been replaced by :include_cascades_includes_and_extends and :extend_cascades_includes_and_extends.'
  end

  def define_module_included_cascades_to_class
    raise NoMethodError, 'This method has been replaced by :include_cascades_includes_to_class and :include_cascades_extends_to_class.'
  end

  def define_module_extended_cascades_to_class
    raise NoMethodError, 'This method has been replaced by :extend_cascades_includes_to_class and :extend_cascades_extends_to_class.'
  end

  def define_module_cluster_cascades_to_class
    raise NoMethodError, 'This method has been replaced by :include_cascades_includes_and_extends_to_class and :extend_cascades_includes_and_extends_to_class.'
  end

end
