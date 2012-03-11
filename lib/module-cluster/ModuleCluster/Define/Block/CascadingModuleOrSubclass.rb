
module ::ModuleCluster::Define::Block::CascadingModuleOrSubclass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Define::Block::CascadingModule
  include ::ModuleCluster::Define::Block::Subclass
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade::Subclass
  extend ::ModuleCluster::ExtendForCascade

  ##########################################
  #  cascading_module_include_or_subclass  #
  ##########################################

  def cascading_module_include_or_subclass( & runtime_block )
    module_set = cascading_module_include( & runtime_block )
    subclass_set = subclass( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, subclass_set )    
  end

end
