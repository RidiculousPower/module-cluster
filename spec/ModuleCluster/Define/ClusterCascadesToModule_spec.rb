
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ClusterCascadesToModule do

  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should cascade to modules' do
    ModuleCluster::Define::ClusterCascadesToModule.should_cascade?( Kernel ).should == true
    ModuleCluster::Define::ClusterCascadesToModule.should_cascade?( Class ).should == false
    ModuleCluster::Define::ClusterCascadesToModule.should_cascade?( Object.new ).should == false
  end
  
	#########################################
	#  include_cascades_includes_to_module  #
	#########################################

  it 'include modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock01
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_includes_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock01
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock01
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock01::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock01::ModuleProof1
        # true b/c of ancestor chain
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock01::Module2 ).should == false
      end
    end
  end
	
	########################################
	#  include_cascades_extends_to_module  #
	########################################

  it 'extends modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock02
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_extends_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock02
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock02
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock02::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == true
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock02::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock02::Module2 ).should == false
      end
    end
  end
	
	#####################################################
	#  include_cascades_includes_and_extends_to_module  #
	#####################################################

  it 'include and extends modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock03
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_includes_and_extends_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock03
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock03
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock03::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == true
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock03::ModuleProof1
        # true b/c of ancestor chain
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock03::Module2 ).should == false
      end
    end
  end

	########################################
	#  extend_cascades_includes_to_module  #
	########################################

  it 'include modules for any class this module is extended in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock04
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock04::ModuleProof1
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock04::Module2 ).should == true
      end
    end
  end
	
	#######################################
	#  extend_cascades_extends_to_module  #
	#######################################

  it 'extend modules for any class this module is extended in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock05
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_extends_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock05::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock05::Module2 ).should == false
      end
    end
  end
	
	####################################################
	#  extend_cascades_includes_and_extends_to_module  #
	####################################################

  it 'include and extend modules for any class this module is extended in' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock06
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_and_extends_to_module( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        # true because Proof2's ancestor chain includes
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock06::ModuleProof1
        eigenclass = class << self ; self ; end
        # true because Proof2's ancestor chain includes
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock06::Module2 ).should == true
      end
    end
  end

	####################################################
	#  include_cascades_to_module_prepend_includes  #
	####################################################

  it 'include other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock07
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_to_module_prepend_includes( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock07
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock07
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock07::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock07::ModuleProof1
        # true b/c of ancestor chain
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock07::Module2 ).should == false
      end
    end
  end
	
	###################################################
	#  include_cascades_to_module_prepend_extends  #
	###################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock08
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_to_module_prepend_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock08
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock08
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock08::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == true
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock08::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock08::Module2 ).should == false
      end
    end
  end
	
	################################################################
	#  include_cascades_to_module_prepend_includes_and_extends  #
	################################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock09
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      include_cascades_to_module_prepend_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock09
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock09
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock09::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == true
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToModule::Mock09::ModuleProof1
        # true b/c of ancestor chain
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock09::Module2 ).should == false
      end
    end
  end

	###################################################
	#  extend_cascades_to_module_prepend_includes  #
	###################################################

  it 'include other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock10
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_to_module_prepend_includes( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock10::ModuleProof1
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock10::Module2 ).should == true
      end
    end
  end
	
	##################################################
	#  extend_cascades_to_module_prepend_extends  #
	##################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock11
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_to_module_prepend_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock11::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock11::Module2 ).should == false
      end
    end
  end
	
	###############################################################
	#  extend_cascades_to_module_prepend_includes_and_extends  #
	###############################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascadesToModule::Mock12
      extend ::ModuleCluster::Define::ClusterCascadesToModule
      module Module1
      end
      module Module2
      end
      extend_cascades_to_module_prepend_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12::ModuleProof1
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == false
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToModule::Mock12::ModuleProof1
        eigenclass = class << self ; self ; end
        # true because of ancestor chain
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascadesToModule::Mock12::Module2 ).should == true
      end
    end
  end

end
