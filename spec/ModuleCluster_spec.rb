require_relative '../lib/module-cluster.rb'

describe ModuleCluster do

  it 'clusters other modules' do
    module ModuleCluster
      is_a?( ModuleCluster::Define::Cluster )
      is_a?( ModuleCluster::Define::ClusterCascades )
      is_a?( ModuleCluster::Define::ClusterCascadesToClass )
      is_a?( ModuleCluster::Define::ClusterCascadesToModule )
      is_a?( ModuleCluster::Define::Deprecated )
    end
  end
  
end
