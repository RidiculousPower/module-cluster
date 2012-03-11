
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::CascadingClass do

  #############################
  #  cascading_class_include  #
  #############################

  it 'can run a block on class include' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock01
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_class_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock01
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock01
      end
      block_ran.should == false
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock01
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock01
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end

  ############################
  #  cascading_class_extend  #
  ############################

  it 'can run a block on class extend' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock02
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_class_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock02
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock02
      end
      block_ran.should == false
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock02
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end

  #######################################
  #  cascading_class_include_or_extend  #
  #######################################

  it 'can run a block on class include or extend' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock03
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_class_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock03
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock03
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock03
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock03
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock03
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end

  #####################################
  #  cascading_prepend_class_include  #
  #####################################

  it 'can run a block before class include' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock04
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_prepend_class_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock04
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock04
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock04
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock04
      end
      block_ran.should == true
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock04
      end
      block_ran.should == true
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end

  ####################################
  #  cascading_prepend_class_extend  #
  ####################################

  it 'can run a block before class extend' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock05
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_prepend_class_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock05
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock05
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock05
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock05
      end
      block_ran.should == false
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock05
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end

  ###############################################
  #  cascading_prepend_class_include_or_extend  #
  ###############################################

  it 'can run a block before class include or extend' do
    module ::ModuleCluster::Define::Block::CascadingClass::Mock06
      extend ::ModuleCluster::Define::Block::CascadingClass
      block_ran = false
      cascading_prepend_class_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock06
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock06
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock06
      end
      block_ran.should == false
      class CascadingClassProof
        include ::ModuleCluster::Define::Block::CascadingClass::Mock06
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClass::Mock06
      end
      block_ran.should == true
      block_ran = false
      class CascadingClassProof2 < CascadingClassProof
      end
      block_ran.should == true
    end
  end
  
end
