
module ModuleCluster
	
	extend ModuleCluster::ExtendForCascade
    
  include ModuleCluster::Define::Cluster
  include ModuleCluster::Define::ClusterCascades
  include ModuleCluster::Define::ClusterCascadesToClass
  include ModuleCluster::Define::ClusterCascadesToModule

  include ModuleCluster::Define::Deprecated
		
end
