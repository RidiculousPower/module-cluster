
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::ClassOrSubclass do

  ###############################
  #  class_include_or_subclass  #
  ###############################

  it 'can run a block on class or module extend' do
    module ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      extend ::ModuleCluster::Define::Block::ClassOrSubclass
      block_ran = false
      class_include_or_subclass do |class_instance|
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == false
      block_ran = false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == false
      block_ran = false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == false
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == false
      class SubClassProof < ClassProof
        include ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == true
      block_ran = false
      class SubSubClassProof < SubClassProof
        include ::ModuleCluster::Define::Block::ClassOrSubclass::Mock01
      end
      block_ran.should == true
    end    
  end

end
