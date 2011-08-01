
module ModuleCluster
	
	include ModuleCluster::Define::ClusterStack

  include ModuleCluster::Define::ModuleCluster
  include ModuleCluster::Define::ModuleClusterCascades
  include ModuleCluster::Define::ModuleClusterCascadesToClass
  include ModuleCluster::Define::ModuleClusterCascadesToModule

  include ModuleCluster::Define::Deprecated
	
end
