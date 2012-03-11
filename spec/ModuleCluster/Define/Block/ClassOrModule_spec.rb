
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::ClassOrModule do

  #############################
  #  class_or_module_include  #
  #############################

  it 'can run a block on class or module include' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      class_or_module_include do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      respond_to?( :included ).should == true
      class ClassProof
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      block_ran.should == false
      class ClassProof2
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      block_ran.should == false
      module ModuleProof
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock01
      end
      block_ran.should == true
    end
  end

  ############################
  #  class_or_module_extend  #
  ############################

  it 'can run a block on class or module extend' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      class_or_module_extend do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock02
      end
      block_ran.should == true
    end  end

  #######################################
  #  class_or_module_include_or_extend  #
  #######################################

  it 'can run a block on class or module include or extend' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      class_or_module_include_or_extend do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock03
      end
      block_ran.should == true
    end
  end

  #####################################
  #  prepend_class_or_module_include  #
  #####################################

  it 'can run a block before class or module include' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      prepend_class_or_module_include do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      respond_to?( :included ).should == true
      class ClassProof
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      block_ran.should == false
      class ClassProof2
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      block_ran.should == false
      module ModuleProof
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      block_ran.should == false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock04
      end
      block_ran.should == true
    end
  end

  ####################################
  #  prepend_class_or_module_extend  #
  ####################################

  it 'can run a block before class or module extend' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      prepend_class_or_module_extend do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock05
      end
      block_ran.should == true
    end
  end

  ###############################################
  #  prepend_class_or_module_include_or_extend  #
  ###############################################

  it 'can run a block before class or module include or extend' do
    module ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      extend ::ModuleCluster::Define::Block::ClassOrModule
      block_ran = false
      prepend_class_or_module_include_or_extend do
        block_ran = true
        self.should == ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::ClassOrModule::Mock06
      end
      block_ran.should == true
    end
  end

end
