
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Block::Class do

  ###################
  #  class_include  #
  ###################

  it 'can run a block on class include' do
    module ModuleCluster::Define::Block::Class::Mock01
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      class_include do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock01
      end
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock01
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock01
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock01
      end
      block_ran.should == false
      class ClassProof
        extend ::ModuleCluster::Define::Block::Class::Mock01
      end
      block_ran.should == false
      class ClassProof2
        include ::ModuleCluster::Define::Block::Class::Mock01
      end
      block_ran.should == true
    end
  end

  ##################
  #  class_extend  #
  ##################

  it 'can run a block on class extend' do
    module ModuleCluster::Define::Block::Class::Mock02
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      class_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock02
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock02
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock02
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock02
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Class::Mock02
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Class::Mock02
      end
      block_ran.should == true
    end
  end

  #############################
  #  class_include_or_extend  #
  #############################

  it 'can run a block on class include or extend' do
    module ModuleCluster::Define::Block::Class::Mock03
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      class_include_or_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock03
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock03
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock03
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock03
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Class::Mock03
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Class::Mock03
      end
      block_ran.should == true
    end
  end

  ###########################
  #  prepend_class_include  #
  ###########################

  it 'can run a block before class include' do
    module ModuleCluster::Define::Block::Class::Mock04
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      prepend_class_include do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock04
      end
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock04
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock04
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock04
      end
      block_ran.should == false
      class ClassProof
        extend ::ModuleCluster::Define::Block::Class::Mock04
      end
      block_ran.should == false
      class ClassProof2
        include ::ModuleCluster::Define::Block::Class::Mock04
      end
      block_ran.should == true
    end
  end

  ##########################
  #  prepend_class_extend  #
  ##########################

  it 'can run a block before class extend' do
    module ModuleCluster::Define::Block::Class::Mock05
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      prepend_class_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock05
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock05
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock05
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock05
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Class::Mock05
      end
      block_ran.should == false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Class::Mock05
      end
      block_ran.should == true
    end
  end

  #####################################
  #  prepend_class_include_or_extend  #
  #####################################

  it 'can run a block before class include or extend' do
    module ModuleCluster::Define::Block::Class::Mock06
      extend ::ModuleCluster::Define::Block::Class
      block_ran = false
      prepend_class_include_or_extend do
        block_ran = true
        self.should == ModuleCluster::Define::Block::Class::Mock06
      end
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Block::Class::Mock06
      end
      block_ran.should == false
      module ModuleProof2
        extend ::ModuleCluster::Define::Block::Class::Mock06
      end
      block_ran.should == false
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Block::Class::Mock06
      end
      block_ran.should == false
      class ClassProof
        include ::ModuleCluster::Define::Block::Class::Mock06
      end
      block_ran.should == true
      block_ran = false
      class ClassProof2
        extend ::ModuleCluster::Define::Block::Class::Mock06
      end
      block_ran.should == true
    end
  end
  
end
