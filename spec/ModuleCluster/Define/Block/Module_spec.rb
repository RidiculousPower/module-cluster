
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::Module do

  ####################
  #  module_include  #
  ####################

  it 'can run a block on module include' do
    module ModuleCluster::Define::Block::Module::Mock01
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      module_include do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock01
      end
      respond_to?( :included ).should == true
      class ClassProof
        extend ModuleCluster::Define::Block::Module::Mock01
      end
      block_ran.should == false
      class ClassProof2
        include ModuleCluster::Define::Block::Module::Mock01
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock01
      end
      block_ran.should == false
      module ModuleProof
        extend ModuleCluster::Define::Block::Module::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        include ModuleCluster::Define::Block::Module::Mock01
      end
      block_ran.should == true
    end
  end

  ###################
  #  module_extend  #
  ###################

  it 'can run a block on module extend' do
    module ModuleCluster::Define::Block::Module::Mock02
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      module_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock02
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ModuleCluster::Define::Block::Module::Mock02
      end
      block_ran.should == false
      class ClassProof2
        extend ModuleCluster::Define::Block::Module::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock02
      end
      block_ran.should == false
      module ModuleProof
        include ModuleCluster::Define::Block::Module::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ModuleCluster::Define::Block::Module::Mock02
      end
      block_ran.should == true
    end
  end

  ##############################
  #  module_include_or_extend  #
  ##############################

  it 'can run a block on module include or extend' do
    module ModuleCluster::Define::Block::Module::Mock03
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      module_include_or_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock03
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ModuleCluster::Define::Block::Module::Mock03
      end
      block_ran.should == false
      class ClassProof2
        extend ModuleCluster::Define::Block::Module::Mock03
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock03
      end
      block_ran.should == false
      module ModuleProof
        include ModuleCluster::Define::Block::Module::Mock03
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        extend ModuleCluster::Define::Block::Module::Mock03
      end
      block_ran.should == true
    end
  end

  ############################
  #  prepend_module_include  #
  ############################

  it 'can run a block before module include' do
    module ModuleCluster::Define::Block::Module::Mock04
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      prepend_module_include do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock04
      end
      respond_to?( :included ).should == true
      class ClassProof
        extend ModuleCluster::Define::Block::Module::Mock04
      end
      block_ran.should == false
      class ClassProof2
        include ModuleCluster::Define::Block::Module::Mock04
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock04
      end
      block_ran.should == false
      module ModuleProof
        extend ModuleCluster::Define::Block::Module::Mock04
      end
      block_ran.should == false
      module ModuleProof2
        include ModuleCluster::Define::Block::Module::Mock04
      end
      block_ran.should == true
    end
  end

  ###########################
  #  prepend_module_extend  #
  ###########################

  it 'can run a block before module extend' do
    module ModuleCluster::Define::Block::Module::Mock05
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      prepend_module_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock05
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ModuleCluster::Define::Block::Module::Mock05
      end
      block_ran.should == false
      class ClassProof2
        extend ModuleCluster::Define::Block::Module::Mock05
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock05
      end
      block_ran.should == false
      module ModuleProof
        include ModuleCluster::Define::Block::Module::Mock05
      end
      block_ran.should == false
      module ModuleProof2
        extend ModuleCluster::Define::Block::Module::Mock05
      end
      block_ran.should == true
    end
  end

  ######################################
  #  prepend_module_include_or_extend  #
  ######################################

  it 'can run a block before module include or extend' do
    module ModuleCluster::Define::Block::Module::Mock06
      extend ModuleCluster::Define::Block::Module
      block_ran = false
      prepend_module_include_or_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Module::Mock06
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ModuleCluster::Define::Block::Module::Mock06
      end
      block_ran.should == false
      class ClassProof2
        extend ModuleCluster::Define::Block::Module::Mock06
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ModuleCluster::Define::Block::Module::Mock06
      end
      block_ran.should == false
      module ModuleProof
        include ModuleCluster::Define::Block::Module::Mock06
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        extend ModuleCluster::Define::Block::Module::Mock06
      end
      block_ran.should == true
    end
  end

end
