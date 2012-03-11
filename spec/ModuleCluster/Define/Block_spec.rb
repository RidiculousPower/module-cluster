
require_relative '../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block do

  it 'is a cluster of support functions that run blocks at hooks' do
    module ::ModuleCluster::Define::Block
      ancestors.include?( ::ModuleCluster::Define::Block::Class ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::ClassOrInstance ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::ClassOrModule ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::ClassOrModuleOrInstance ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::Instance ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::Module ).should == true
      ancestors.include?( ::ModuleCluster::Define::Block::ModuleOrInstance ).should == true
    end
  end

end
