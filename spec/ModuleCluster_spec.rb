require_relative '../lib/module-cluster.rb'

describe ::ModuleCluster do

  it 'clusters other modules' do
    module ::ModuleCluster
      is_a?( Define::Cluster )
      is_a?( Define::ClusterCascades )
      is_a?( Define::ClusterCascadesToClass )
      is_a?( Define::ClusterCascadesToModule )
      is_a?( Define::Deprecated )
    end
  end
  
end
