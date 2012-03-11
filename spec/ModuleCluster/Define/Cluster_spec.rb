
require_relative '../../../lib/module-cluster.rb'

describe ::ModuleCluster::Define::Cluster do

	###########################
	#  include_also_includes  #
	###########################

  it 'include other modules when this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock01
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_includes( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock01
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock01
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock01::Module2 ).should == false
      end
    end
  end
	
	##########################
	#  include_also_extends  #
	##########################
	
  it 'extend other modules when this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock02
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock02
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock02
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock02::Module2 ).should == true
      end
    end
  end
	
	#######################################
	#  include_also_includes_and_extends  #
	#######################################

  it 'include and extend other modules when this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock03
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock03
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock03
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
      end
    end    
  end

	##########################
	#  extend_also_includes  #
	##########################

  it 'include other modules when this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock04
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_includes( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock04
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock04
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock04::Module2 ).should == false
      end
    end
  end
	
	#########################
	#  extend_also_extends  #
	#########################
	
  it 'extend other modules when this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock05
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock05
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock05
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Cluster::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock05::Module2 ).should == true
      end
    end
  end
	
	######################################
	#  extend_also_includes_and_extends  #
	######################################

  it 'include and extend other modules when this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock06
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock06
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock06
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Cluster::Mock06
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
      end
    end
  end

	###############################
	#  include_prepends_includes  #
	###############################

  it 'include other modules before this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock07
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_includes( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock07
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock07
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock07::Module2 ).should == false
      end
    end
  end

	##############################
	#  include_prepends_extends  #
	##############################
	
  it 'extend other modules before this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock08
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock08
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock08
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock08::Module2 ).should == true
      end
    end
  end
	
	###########################################
	#  include_prepends_includes_and_extends  #
	###########################################

  it 'include and extend other modules before this one is included' do
    module ::ModuleCluster::Define::Cluster::Mock09
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock09
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock09
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
      end
    end
  end

	##############################
	#  extend_prepends_includes  #
	##############################

  it 'include other modules before this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock10
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_includes( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock10
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module2 ).should == false
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock10
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock10::Module2 ).should == false
      end
    end
  end

	#############################
	#  extend_prepends_extends  #
	#############################
	
  it 'extend other modules before this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock11
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock11
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock11
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Cluster::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock11::Module2 ).should == true
      end
    end
  end
	
	##########################################
	#  extend_prepends_includes_and_extends  #
	##########################################

  it 'include and extend other modules before this one is extended' do
    module ::ModuleCluster::Define::Cluster::Mock12
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ::ModuleCluster::Define::Cluster::Mock12
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
      end
      class ClassProof
        extend ::ModuleCluster::Define::Cluster::Mock12
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Cluster::Mock12
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
      end
    end
  end
  
  #####################################
	#  include_or_extend_also_includes  #
	#####################################

  it 'can include other modules when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock13
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_also_includes( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock13
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::Cluster::Mock13
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock13
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == false
      end
      class ClassProof2
        include ::ModuleCluster::Define::Cluster::Mock13
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock13::Module2 ).should == false
      end
    end
  end

	####################################
	#  include_or_extend_also_extends  #
	####################################

  it 'can extend other modules when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock14
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock14
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::Cluster::Mock14
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock14
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::Cluster::Mock14
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock14::Module2 ).should == true
      end
    end
  end

	#################################################
	#  include_or_extend_also_includes_and_extends  #
	#################################################

  it 'can include and extend other modules when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock15
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_also_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :included ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock15
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
      end
      module ModuleProo2
        extend ::ModuleCluster::Define::Cluster::Mock15
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock15
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::Cluster::Mock15
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock15::Module2 ).should == true
      end
    end
  end

	#########################################
	#  include_or_extend_prepends_includes  #
	#########################################

  it 'can include other modules before this one when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock16
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_prepends_includes( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock16
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == false
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::Cluster::Mock16
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == false
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock16
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == false
      end
      class ClassProof2
        extend ::ModuleCluster::Define::Cluster::Mock16
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock16::Module2 ).should == false
      end
    end
  end

	########################################
	#  include_or_extend_prepends_extends  #
	########################################

  it 'can extend other modules before this one when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock17
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock17
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::Cluster::Mock17
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock17
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::Cluster::Mock17
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == false
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ::ModuleCluster::Define::Cluster::Mock17
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock17::Module2 ).should == true
      end
    end
  end

	#####################################################
	#  include_or_extend_prepends_includes_and_extends  #
	#####################################################

  it 'can include and extend other modules before this one when this one is included in or extends a class' do
    module ::ModuleCluster::Define::Cluster::Mock18
      extend ::ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_or_extend_prepends_includes_and_extends( Module1, Module2 ).name = :some_name
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ::ModuleCluster::Define::Cluster::Mock18
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
      end
      module ModuleProof2
        extend ::ModuleCluster::Define::Cluster::Mock18
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
      end
      class ClassProof
        include ::ModuleCluster::Define::Cluster::Mock18
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
      end
      class ClassProof2
        extend ::ModuleCluster::Define::Cluster::Mock18
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ::ModuleCluster::Define::Cluster::Mock18::Module2 ).should == true
      end
    end    
  end
	
end
