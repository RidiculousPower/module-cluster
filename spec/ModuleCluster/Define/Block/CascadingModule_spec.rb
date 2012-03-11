
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::CascadingModule do

  ##############################
  #  cascading_module_include  #
  ##############################

  it 'can run a block on module include' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock01
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_module_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock01
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock01
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock01
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock01
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProof2
        include ::ModuleCluster::Define::Block::CascadingModule::Mock01::CascadingModuleProof
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock01
      end
      block_ran.should == false
    end
  end

  #############################
  #  cascading_module_extend  #
  #############################

  it 'can run a block on module extend' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock02
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_module_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock02
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock02
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock02
      end
      block_ran.should == false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock02
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock02::CascadingModuleProofExtended
      end
      block_ran.should == true
    end
  end

  ########################################
  #  cascading_module_include_or_extend  #
  ########################################

  it 'can run a block on module include or extend' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock03
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_module_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock03
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock03
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock03
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProof2
        include ::ModuleCluster::Define::Block::CascadingModule::Mock03::CascadingModuleProof
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock03::CascadingModuleProofExtended
      end
      block_ran.should == true
    end
  end

  ######################################
  #  cascading_prepend_module_include  #
  ######################################

  it 'can run a block before module include' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock04
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_prepend_module_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock04
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock04
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock04
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock04
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProof2
        include ::ModuleCluster::Define::Block::CascadingModule::Mock04::CascadingModuleProof
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock04
      end
      block_ran.should == false
    end
  end

  #####################################
  #  cascading_prepend_module_extend  #
  #####################################

  it 'can run a block before module extend' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock05
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_prepend_module_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock05
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock05
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock05
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock05
      end
      block_ran.should == false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock05
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock05::CascadingModuleProofExtended
      end
      block_ran.should == true
    end
  end

  ################################################
  #  cascading_prepend_module_include_or_extend  #
  ################################################

  it 'can run a block before module include or extend' do
    module ::ModuleCluster::Define::Block::CascadingModule::Mock06
      extend ::ModuleCluster::Define::Block::CascadingModule
      block_ran = false
      cascading_prepend_module_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock06
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock06
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock06
      end
      block_ran.should == false
      module CascadingModuleProof
        include ::ModuleCluster::Define::Block::CascadingModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProof2
        include ::ModuleCluster::Define::Block::CascadingModule::Mock06::CascadingModuleProof
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      module CascadingModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingModule::Mock06::CascadingModuleProofExtended
      end
      block_ran.should == true
    end
  end

end
