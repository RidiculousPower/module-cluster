
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ClusterStack do

  #########################
  #  clusterstack_module  #
  #########################

  it 'constructs an anonymous module to stack the included/extended/append_features/extend_object chain' do
    
    class ModuleCluster::Define::ClusterStack::Mock
      extend ModuleCluster::Define::ClusterStack
      # get instance of module
      clusterstack_module_instance = clusterstack_module
      # make sure it's a module
      clusterstack_module_instance.is_a?( Module ).should == true
      # make sure we get the same one after the first time
      clusterstack_module.should == clusterstack_module_instance
    end
    
  end
  
end
