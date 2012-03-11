
module ModuleCluster::Define::Block::ClassOrSubclass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Define::Block::Class
  include ::ModuleCluster::Define::Block::Subclass
  include ::ModuleCluster::Suspend::WithoutHooks
  
  extend ::ModuleCluster::ExtendForCascade::Subclass
  extend ::ModuleCluster::ExtendForCascade

  ###############################
  #  class_include_or_subclass  #
  ###############################

  def class_include_or_subclass( & runtime_block )
    class_set = class_include( & runtime_block )
    subclass_set = subclass( & runtime_block )
    return ModuleCluster::ClusterStack::Set::MultiSetProxy.new( class_set, subclass_set )    
  end

end
