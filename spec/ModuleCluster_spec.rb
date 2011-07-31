require_relative '../lib/module-cluster.rb'

describe ModuleCluster do

  it 'clusters other modules' do
    module ModuleCluster
      is_a?( ModuleCluster::Define::ModuleCluster )
      is_a?( ModuleCluster::Define::ModuleClusterCascades )
      is_a?( ModuleCluster::Define::ModuleClusterCascadesToClass )
      is_a?( ModuleCluster::Define::Deprecated )
    end
  end
  
end
