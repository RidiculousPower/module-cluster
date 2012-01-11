
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::Subclass do

  ##############
  #  subclass  #
  ##############

  it 'can run a block when a class is subclassed' do
    
    # Modules shouldn't work
    Proc.new do
      module ModuleCluster::Define::Block::Subclass::ModuleMock01
        extend ModuleCluster::Define::Block::Subclass
      end
    end.should raise_error
    
    class ModuleCluster::Define::Block::Subclass::Mock01
      extend ModuleCluster::Define::Block::Subclass
      block_ran = false
      subclass do |subclass_instance|
        self.ancestors.include?( ModuleCluster::Define::Block::Subclass::Mock01 ).should == true
        subclass_instance.ancestors.include?( ModuleCluster::Define::Block::Subclass::Mock01 ).should == true
        block_ran = true
      end
      respond_to?( :inherited ).should == true
      respond_to?( :included ).should == false
      respond_to?( :extended ).should == false
      respond_to?( :append_features ).should == false
      respond_to?( :extend_object ).should == false
      class ModuleProof < ModuleCluster::Define::Block::Subclass::Mock01
      end
      block_ran.should == true
      block_ran = false
      class ModuleProof2 < ModuleProof
      end
      block_ran.should == true
    end
  end

end
