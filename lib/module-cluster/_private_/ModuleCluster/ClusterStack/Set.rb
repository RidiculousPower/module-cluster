
ModuleCluster::ClusterStack::Set = Struct.new( :dependency_module, 
                                               :method, 
                                               :module_class_instance_or_all, 
                                               :include_or_extend, 
                                               :modules, 
                                               :runtime_includes_or_extends_block,
                                               :suspended,
                                               :name ) do
  
  #############
  #  suspend  #
  #############

  def suspend
    suspended = true
  end

  ############
  #  resume  #
  ############

  def resume
    suspended = false
  end

  ################
  #  suspended?  #
  ################
  
  def suspended?
    return suspended
  end
  
end