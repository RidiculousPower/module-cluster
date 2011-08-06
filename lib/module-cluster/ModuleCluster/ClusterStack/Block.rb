
module ModuleCluster::ClusterStack::Block
  
  Set = Struct.new( :runtime_block )
  
  include ModuleCluster::ClusterStack::Block::Class
  include ModuleCluster::ClusterStack::Block::Module

end
