
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::CascadingModuleOrSubclass do

  ##########################################
  #  cascading_module_include_or_subclass  #
  ##########################################

  it 'can run a block on class or module extend' do
    module ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      extend ::ModuleCluster::Define::Block::CascadingModuleOrSubclass
      block_ran = false
      cascading_module_include_or_subclass do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01::ModuleProof
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      end
      block_ran.should == false
      block_ran = false
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      end
      block_ran.should == false
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModuleOrSubclass::Mock01
      end
      block_ran.should == false
      class SubClassProof < ClassProof
      end
      block_ran.should == true
      block_ran = false
      class SubSubClassProof < SubClassProof
      end
      block_ran.should == true
    end    
  end

end
