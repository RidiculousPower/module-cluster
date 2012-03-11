
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ModuleOrInstanceCluster do

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  it 'should return true if module or instance (not class), false otherwise' do
    ModuleCluster::Define::ModuleOrInstanceCluster.should_include_or_extend?( Kernel ).should == true
    ModuleCluster::Define::ModuleOrInstanceCluster.should_include_or_extend?( Class ).should == false
    ModuleCluster::Define::ModuleOrInstanceCluster.should_include_or_extend?( Object.new ).should == true    
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should report false' do
    ModuleCluster::Define::ModuleOrInstanceCluster.should_cascade?( Kernel ).should == false
    ModuleCluster::Define::ModuleOrInstanceCluster.should_cascade?( Class ).should == false
    ModuleCluster::Define::ModuleOrInstanceCluster.should_cascade?( Object.new ).should == false
  end
  
	##########################################################################
	#  module_include_or_extend_or_instance_extend_also_includes_or_extends  #
	##########################################################################

  it 'can include a module when this one is included in a module or extend an instance when this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_extend_or_instance_extend_also_includes_or_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock01
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock01::Module2 ).should == true
      end
    end
  end
	
	##############################################################
	#  module_include_or_extend_or_instance_extend_also_extends  #
	##############################################################

  it 'can include a module when this one is included in a module or extend with another module when this one is used to extend a module or extend an instance when this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_extend_or_instance_extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock02
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock02::Module2 ).should == true
      end
    end
  end

	################################################################
	#  module_include_or_instance_extend_also_includes_or_extends  #
	################################################################

  it 'can include a module when this one is included in a module or extend with another module when this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_instance_extend_also_includes_or_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock03
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock03::Module2 ).should == true
      end
    end
  end
	
	####################################################
	#  module_include_or_instance_extend_also_extends  #
	####################################################
	
  it 'can extend with another module when this one is included in a module or used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_instance_extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock04
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock04::Module2 ).should == true
      end
    end
  end
	
	############################################
	#  module_or_instance_extend_also_extends  #
	############################################

  it 'can extend with another module when this one is used to extend a module or instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_or_instance_extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock05::Module2 ).should == true
      end
    end
  end

	##############################################################################
	#  module_include_or_extend_or_instance_extend_prepends_includes_or_extends  #
	##############################################################################
	
  it 'can include a module before this one is included in a module or extend an instance before this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_extend_or_instance_extend_prepends_includes_or_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock06
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock06::Module2 ).should == true
      end
    end
  end
	
	####################################################################
	#  module_include_or_instance_extend_prepends_includes_or_extends  #
	####################################################################

  it 'can include a module before this one is included in a module or extend with another module before this one is used to extend a module or extend an instance before this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_instance_extend_prepends_includes_or_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock07
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock07::Module2 ).should == true
      end
    end
  end

	##################################################################
	#  module_include_or_extend_or_instance_extend_prepends_extends  #
	##################################################################
	
  it 'can include a module before this one is included in a module or extend with another module before this one is used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_extend_or_instance_extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock08
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock08::Module2 ).should == true
      end
    end
  end
	
	########################################################
	#  module_include_or_instance_extend_prepends_extends  #
	########################################################
	
  it 'can extend with another module before this one is included in a module or used to extend an instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_include_or_instance_extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock09
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock09::Module2 ).should == true
      end
    end
  end

	################################################
	#  module_or_instance_extend_prepends_extends  #
	################################################

  it 'can extend with another module before this one is used to extend a module or instance' do
    module ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
      extend ::ModuleCluster::Define::ModuleOrInstanceCluster
      module Module1
      end
      module Module2
      end
      module_or_instance_extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      respond_to?( :extended ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ModuleOrInstanceCluster::Mock10
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrInstanceCluster::Mock10::Module2 ).should == true
      end
    end
  end

end
