
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ClassCluster do

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  it 'should return true if class, false otherwise' do
    ModuleCluster::Define::ClassCluster.should_include_or_extend?( Kernel ).should == false
    ModuleCluster::Define::ClassCluster.should_include_or_extend?( Class ).should == true
    ModuleCluster::Define::ClassCluster.should_include_or_extend?( Object.new ).should == false    
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should report false' do
    ModuleCluster::Define::ClassCluster.should_cascade?( Kernel ).should == false
    ModuleCluster::Define::ClassCluster.should_cascade?( Class ).should == false
    ModuleCluster::Define::ClassCluster.should_cascade?( Object.new ).should == false
  end
  
	#################################
	#  class_include_also_includes  #
	#################################

  it 'can include other modules when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock01
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_also_includes( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock01::Module2 ).should == false
      end
    end
  end
	
	################################
	#  class_include_also_extends  #
	################################
	
  it 'can extend other modules when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock02
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_also_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock02::Module2 ).should == true
      end
    end    
  end
	
	#############################################
	#  class_include_also_includes_and_extends  #
	#############################################

  it 'can include and extend other modules when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock03
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_also_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock03::Module2 ).should == true
      end
    end
  end

	################################
	#  class_extend_also_includes  #
	################################

  it 'can include other modules when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock04
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_also_includes( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock04::Module2 ).should == false
      end
    end
  end
	
	###############################
	#  class_extend_also_extends  #
	###############################
	
  it 'can extend other modules when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock05
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_also_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ClassCluster::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock05::Module2 ).should == false
      end
    end
  end
	
	############################################
	#  class_extend_also_includes_and_extends  #
	############################################

  it 'can include and extend other modules when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock06
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_also_includes_and_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ClassCluster::Mock06
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock06::Module2 ).should == false
      end
    end
  end

	#####################################
	#  class_include_prepends_includes  #
	#####################################

  it 'can include other modules before this one when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock07
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_prepends_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock07::Module2 ).should == false
      end
    end
  end

	####################################
	#  class_include_prepends_extends  #
	####################################
	
  it 'can extend other modules before this one when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock08
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_prepends_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock08::Module2 ).should == true
      end
    end
  end
	
	#################################################
	#  class_include_prepends_includes_and_extends  #
	#################################################

  it 'can include and extend other modules before this one when this one is included in a class' do
    module ModuleCluster::Define::ClassCluster::Mock09
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock09::Module2 ).should == true
      end
    end    
  end

	####################################
	#  class_extend_prepends_includes  #
	####################################

  it 'can include other modules before this one when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock10
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_prepends_includes( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock10::Module2 ).should == false
      end
    end
  end

	###################################
	#  class_extend_prepends_extends  #
	###################################
	
  it 'can extend other modules before this one when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock11
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_prepends_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock11
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock11
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ClassCluster::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock11::Module2 ).should == false
      end
    end
  end
	
	################################################
	#  class_extend_prepends_includes_and_extends  #
	################################################

  it 'can include and extend other modules before this one when this one extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock12
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_extend_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ClassCluster::Mock12
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ClassCluster::Mock12
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ClassCluster::Mock12
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock12::Module2 ).should == false
      end
    end
  end
	
	###########################################
	#  class_include_or_extend_also_includes  #
	###########################################

  it 'can include other modules when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock13
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_also_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
      end
      class ClassProof2
        include ModuleCluster::Define::ClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock13::Module2 ).should == false
      end
    end
  end

	##########################################
	#  class_include_or_extend_also_extends  #
	##########################################

  it 'can extend other modules when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock14
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_also_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock14::Module2 ).should == true
      end
    end
  end

	#######################################################
	#  class_include_or_extend_also_includes_and_extends  #
	#######################################################

  it 'can include and extend other modules when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock15
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_also_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == false
      end
      module ModuleProo2
        extend ModuleCluster::Define::ClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock15::Module2 ).should == true
      end
    end
  end

	###############################################
	#  class_include_or_extend_prepends_includes  #
	###############################################

  it 'can include other modules before this one when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock16
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_prepends_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
      end
      class ClassProof2
        extend ModuleCluster::Define::ClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock16::Module2 ).should == false
      end
    end
  end

	##############################################
	#  class_include_or_extend_prepends_extends  #
	##############################################

  it 'can extend other modules before this one when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock17
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_prepends_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ClassCluster::Mock17
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock17::Module2 ).should == false
      end
    end
  end

	###########################################################
	#  class_include_or_extend_prepends_includes_and_extends  #
	###########################################################

  it 'can include and extend other modules before this one when this one is included in or extends a class' do
    module ModuleCluster::Define::ClassCluster::Mock18
      extend ModuleCluster::Define::ClassCluster
      module Module1
      end
      module Module2
      end
      class_include_or_extend_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClassCluster::Mock18::Module2 ).should == true
      end
    end    
  end

end
