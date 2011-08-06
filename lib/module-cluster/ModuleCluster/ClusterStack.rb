
class ModuleCluster::ClusterStack

  Set = Struct.new( :dependency_module, :method, :include_or_extend, :modules, :runtime_includes_or_extends_block )

  include ModuleCluster::ClusterStack::Block
  include ModuleCluster::ClusterStack::Includes
  include ModuleCluster::ClusterStack::Extends
  include ModuleCluster::ClusterStack::PrependsIncludes
  include ModuleCluster::ClusterStack::PrependsExtends
  
end
