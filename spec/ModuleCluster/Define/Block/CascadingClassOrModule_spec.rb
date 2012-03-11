
require_relative '../../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Block::CascadingClassOrModule do

  #######################################
  #  cascading_class_or_module_include  #
  #######################################

  it 'can run a block on class or module include' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_class_or_module_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      end
      block_ran.should == false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock01::ModuleProof
      end
      block_ran.should == true
    end
  end

  ######################################
  #  cascading_class_or_module_extend  #
  ######################################

  it 'can run a block on class or module extend' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_class_or_module_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      end
      block_ran.should == false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      end
      block_ran.should == false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock02::ModuleProofExtended
      end
      block_ran.should == true
    end  
  end

  #################################################
  #  cascading_class_or_module_include_or_extend  #
  #################################################

  it 'can run a block on class or module include or extend' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_class_or_module_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock03::ModuleProofExtended
      end
      block_ran.should == true
    end
  end

  ###############################################
  #  cascading_prepend_class_or_module_include  #
  ###############################################

  it 'can run a block before class or module include' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_prepend_class_or_module_include do
        block_ran = true
      end
      respond_to?( :included ).should == true
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      end
      block_ran.should == false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock04::ModuleProof
      end
      block_ran.should == true
    end
  end

  ##############################################
  #  cascading_prepend_class_or_module_extend  #
  ##############################################

  it 'can run a block before class or module extend' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_prepend_class_or_module_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      end
      block_ran.should == false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      end
      block_ran.should == false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock05::ModuleProofExtended
      end
      block_ran.should == true
    end
  end

  #########################################################
  #  cascading_prepend_class_or_module_include_or_extend  #
  #########################################################

  it 'can run a block before class or module include or extend' do
    module ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      extend ::ModuleCluster::Define::Block::CascadingClassOrModule
      block_ran = false
      cascading_prepend_class_or_module_include_or_extend do
        block_ran = true
      end
      respond_to?( :extended ).should == true
      class ClassProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      class ClassProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2 < ClassProof
      end
      block_ran.should == true
      block_ran = false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      end
      block_ran.should == false
      module ModuleProof
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      module ModuleProof2
        include ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06::ModuleProof
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06
      end
      block_ran.should == true
      block_ran = false
      module ModuleProofExtended2
        extend ::ModuleCluster::Define::Block::CascadingClassOrModule::Mock06::ModuleProofExtended
      end
      block_ran.should == true
    end
  end

end
