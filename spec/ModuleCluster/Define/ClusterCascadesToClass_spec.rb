
require_relative '../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::ClusterCascadesToClass do

  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should cascade to classes' do
    ::ModuleCluster::Define::ClusterCascadesToClass.should_cascade?( Kernel ).should == true
    ::ModuleCluster::Define::ClusterCascadesToClass.should_cascade?( Class ).should == false
    ::ModuleCluster::Define::ClusterCascadesToClass.should_cascade?( Object.new ).should == false
  end

	########################################
	#  include_cascades_includes_to_class  #
	########################################

  it 'include modules for any class this module or any including modules are included in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock01
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_includes_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock01
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock01
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == true
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock01::Module2 ).should == true
      end
    end
  end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

  it 'extends modules for any class this module or any including modules are included in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock02
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_extends_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock02
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock02
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == true
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock02::Module2 ).should == true
      end
    end
  end
	
	####################################################
	#  include_cascades_includes_and_extends_to_class  #
	####################################################

  it 'include and extends modules for any class this module or any including modules are included in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock03
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_includes_and_extends_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock03
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock03
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == true
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock03::Module2 ).should == true
      end
    end
  end

	#######################################
	#  extend_cascades_includes_to_class  #
	#######################################

  it 'include modules for any class this module is extended in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock04
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock04::Module2 ).should == false
      end
    end
  end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

  it 'extend modules for any class this module is extended in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock05
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_extends_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock05::Module2 ).should == false
      end
    end
  end
	
	###################################################
	#  extend_cascades_includes_and_extends_to_class  #
	###################################################

  it 'include and extend modules for any class this module is extended in' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock06
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_and_extends_to_class( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock06::Module2 ).should == false
      end
    end
  end

	###################################################
	#  include_cascades_to_class_prepend_includes  #
	###################################################

  it 'include other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock07
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepend_includes( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock07
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock07
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock07::Module2 ).should == false
      end
    end
  end
	
	##################################################
	#  include_cascades_to_class_prepend_extends  #
	##################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock08
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepend_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock08
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock08
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == true
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock08::Module2 ).should == true
      end
    end
  end
	
	###############################################################
	#  include_cascades_to_class_prepend_includes_and_extends  #
	###############################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock09
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepend_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof1
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock09
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock09
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == true
      end
      module ModuleProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock09::Module2 ).should == true
      end
    end
  end

	##################################################
	#  extend_cascades_to_class_prepend_includes  #
	##################################################

  it 'include other modules for any class this module or any including modules are included in, before this module is extended' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock10
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepend_includes( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock10::Module2 ).should == false
      end
    end
  end
	
	#################################################
	#  extend_cascades_to_class_prepend_extends  #
	#################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock11
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepend_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock11::Module2 ).should == false
      end
    end
  end
	
	##############################################################
	#  extend_cascades_to_class_prepend_includes_and_extends  #
	##############################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ::ModuleCluster::Define::ClusterCascadesToClass::Mock12
      extend ::ModuleCluster::Define::ClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepend_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof1
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12
      end
      class ClassProof
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::ModuleProof1
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::ModuleProof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::ClusterCascadesToClass::Mock12::Module2 ).should == false
      end
    end
  end

end
