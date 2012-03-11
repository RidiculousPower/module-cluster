
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::Subclass do

  ##############
  #  subclass  #
  ##############

  it 'can run a block when a class is subclassed' do

    class ModuleCluster::Define::Block::Subclass::Mock01
      extend ::ModuleCluster::Define::Block::Subclass
      block_ran = false
      subclass do |subclass_instance|
        subclass_instance.ancestors[ 1 ].should == self
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
  
  it 'can run a block when a class is subclassed after a module has defined subclassing' do
    
    module ModuleCluster::Define::Block::Subclass::Mock02
      extend ::ModuleCluster::Define::Block::Subclass
      block_ran = false
      subclass do |subclass_instance|
        subclass_instance.ancestors[ 1 ].should == self
        self.ancestors.include?( ModuleCluster::Define::Block::Subclass::Mock02 ).should == true
        subclass_instance.ancestors.include?( ModuleCluster::Define::Block::Subclass::Mock02 ).should == true
        block_ran = true
      end
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      respond_to?( :append_features ).should == false
      respond_to?( :extend_object ).should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Subclass::Mock02
        respond_to?( :inherited ).should == true
        respond_to?( :included ).should == false
        respond_to?( :extended ).should == false
        respond_to?( :append_features ).should == false
        respond_to?( :extend_object ).should == false
      end
      block_ran.should == false
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      class ClassProof3 < ClassProof2
      end
      block_ran.should == true
    end
    
  end

end
