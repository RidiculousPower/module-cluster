
module ModuleCluster::Define::Block::ClassOrModuleOrSubclass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Define::Block::ClassOrModule
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade::Subclass
  extend ::ModuleCluster::ExtendForCascade

  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )
    return hooked_instance.is_a?( Module )
  end

  #########################################
  #  class_or_module_include_or_subclass  #
  #########################################

  def class_or_module_include_or_subclass( & runtime_block )
    class_or_module_set = class_or_module_include( & runtime_block )
    subclass_set = cluster_stack.subclass( ModuleCluster::Define::Block::ClassOrModuleOrSubclass, runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_or_module_set, subclass_set )    
  end

end
