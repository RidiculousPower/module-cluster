
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::ClassOrInstance do

  ##############################
  #  class_or_instance_extend  #
  ##############################

  it 'can run a block on class or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock01
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock01
      end
      block_ran.should == true
    end
  end

  ######################################
  #  class_include_or_instance_extend  #
  ######################################

  it 'can run a block on class include or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock02
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_include_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock02
      end
      block_ran.should == true
    end
  end

  ################################################
  #  class_include_or_extend_or_instance_extend  #
  ################################################

  it 'can run a block on class include or extend or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock03
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_include_or_extend_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock03
      end
      block_ran.should == true
    end
  end

  ######################################
  #  prepend_class_or_instance_extend  #
  ######################################

  it 'can run a block before class or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock04
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock04
      end
      block_ran.should == true
    end
  end

  ##############################################
  #  prepend_class_include_or_instance_extend  #
  ##############################################

  it 'can run a block before class include or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock05
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_include_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock05
      end
      block_ran.should == true
    end
  end

  ########################################################
  #  prepend_class_include_or_extend_or_instance_extend  #
  ########################################################

  it 'can run a block before class include or extend or instance extend' do
    module ModuleCluster::Define::Block::ClassOrInstance::Mock06
      extend ::ModuleCluster::Define::Block::ClassOrInstance
      block_ran = false
      class_include_or_extend_or_instance_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrInstance::Mock06
      end
      block_ran.should == true
    end
  end
  
end
