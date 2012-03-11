
module ::ModuleCluster::Define::Block::ModuleOrSubclass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Define::Block::Module
  include ::ModuleCluster::Define::Block::Subclass
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade::Subclass
  extend ::ModuleCluster::ExtendForCascade

  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    return false
  end

  ################################
  #  module_include_or_subclass  #
  ################################

  def module_include_or_subclass( & runtime_block )
    module_set = module_include( & runtime_block )
    subclass_set = subclass( & runtime_block )
    return ::ModuleCluster::ClusterStack::Set::MultiSetProxy.new( module_set, subclass_set )    
  end

end
