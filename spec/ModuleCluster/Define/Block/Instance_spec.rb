
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::Instance do

  #####################
  #  instance_extend  #
  #####################

  it 'can run a block on instance extend' do
    module ModuleCluster::Define::Block::Instance::Mock01
      extend ::ModuleCluster::Define::Block::Instance
      block_ran = false
      instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Instance::Mock01
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Instance::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Instance::Mock01
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Instance::Mock01
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Instance::Mock01
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Instance::Mock01
      end
      block_ran.should == true
    end
  end

  #############################
  #  prepend_instance_extend  #
  #############################

  it 'can run a block before instance extend' do
    module ModuleCluster::Define::Block::Instance::Mock02
      extend ::ModuleCluster::Define::Block::Instance
      block_ran = false
      prepend_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Instance::Mock02
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Instance::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Instance::Mock02
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Instance::Mock02
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Instance::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Instance::Mock02
      end
      block_ran.should == true
    end
  end

end
