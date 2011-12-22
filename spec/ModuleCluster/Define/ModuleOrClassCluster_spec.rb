
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ModuleOrClassCluster do

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  it 'should return true if module or class, false otherwise' do
    ModuleCluster::Define::ModuleOrClassCluster.should_include_or_extend?( Kernel ).should == true
    ModuleCluster::Define::ModuleOrClassCluster.should_include_or_extend?( Class ).should == true
    ModuleCluster::Define::ModuleOrClassCluster.should_include_or_extend?( Object.new ).should == false    
  end
  
  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should report false' do
    ModuleCluster::Define::ModuleOrClassCluster.should_cascade?( Kernel ).should == false
    ModuleCluster::Define::ModuleOrClassCluster.should_cascade?( Class ).should == false
    ModuleCluster::Define::ModuleOrClassCluster.should_cascade?( Object.new ).should == false
  end
  
	###########################################
	#  module_or_class_include_also_includes  #
	###########################################

  it 'can include other modules when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock01
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_also_includes( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock01::Module2 ).should == false
      end
    end
  end
	
	##########################################
	#  module_or_class_include_also_extends  #
	##########################################
	
  it 'can extend other modules when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock02
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_also_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock02
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock02::Module2 ).should == true
      end
    end    
  end
	
	#######################################################
	#  module_or_class_include_also_includes_and_extends  #
	#######################################################

  it 'can include and extend other modules when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock03
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_also_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock03::Module2 ).should == true
      end
    end
  end

	##########################################
	#  module_or_class_extend_also_includes  #
	##########################################

  it 'can include other modules when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock04
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_also_includes( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock04::Module2 ).should == false
      end
    end
  end
	
	#########################################
	#  module_or_class_extend_also_extends  #
	#########################################
	
  it 'can extend other modules when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock05
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_also_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module2 ).should == true
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock05
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock05::Module2 ).should == false
      end
    end
  end
	
	######################################################
	#  module_or_class_extend_also_includes_and_extends  #
	######################################################

  it 'can include and extend other modules when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock06
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_also_includes_and_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module2 ).should == true
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock06
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock06::Module2 ).should == false
      end
    end
  end

	###############################################
	#  module_or_class_include_prepends_includes  #
	###############################################

  it 'can include other modules before this one when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock07
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_prepends_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock07::Module2 ).should == false
      end
    end
  end

	##############################################
	#  module_or_class_include_prepends_extends  #
	##############################################

  it 'can extend other modules before this one when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock08
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_prepends_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock08
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock08::Module2 ).should == true
      end
    end
  end
	
	###########################################################
	#  module_or_class_include_prepends_includes_and_extends  #
	###########################################################

  it 'can include and extend other modules before this one when this one is included in a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock09
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock09::Module2 ).should == true
      end
    end    
  end

	##############################################
	#  module_or_class_extend_prepends_includes  #
	##############################################

  it 'can include other modules before this one when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock10
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_prepends_includes( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock10::Module2 ).should == false
      end
    end
  end

	#############################################
	#  module_or_class_extend_prepends_extends  #
	#############################################

  it 'can extend other modules before this one when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock11
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_prepends_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock11
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module2 ).should == true
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock11
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock11::Module2 ).should == false
      end
    end
  end
	
	##########################################################
	#  module_or_class_extend_prepends_includes_and_extends  #
	##########################################################

  it 'can include and extend other modules before this one when this one extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock12
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_extend_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock12
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module2 ).should == true
      end
      class ClassProof
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock12
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock12
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock12::Module2 ).should == false
      end
    end
  end

	#####################################################
	#  module_or_class_include_or_extend_also_includes  #
	#####################################################

  it 'can include other modules when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock13
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_also_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == false
      end
      class ClassProof2
        include ModuleCluster::Define::ModuleOrClassCluster::Mock13
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock13::Module2 ).should == false
      end
    end
  end

	####################################################
	#  module_or_class_include_or_extend_also_extends  #
	####################################################

  it 'can extend other modules when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock14
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_also_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == true
      end
      module ModuleProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock14
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock14::Module2 ).should == true
      end
    end
  end

	#################################################################
	#  module_or_class_include_or_extend_also_includes_and_extends  #
	#################################################################

  it 'can include and extend other modules when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock15
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_also_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
      end
      module ModuleProo2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock15
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock15::Module2 ).should == true
      end
    end
  end

	#########################################################
	#  module_or_class_include_or_extend_prepends_includes  #
	#########################################################

  it 'can include other modules before this one when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock16
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_prepends_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == false
      end
      module ModuleProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == false
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == false
      end
      class ClassProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock16
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock16::Module2 ).should == false
      end
    end
  end

	########################################################
	#  module_or_class_include_or_extend_prepends_extends  #
	########################################################

  it 'can extend other modules before this one when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock17
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_prepends_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == true
      end
      module ModuleProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock17
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == true
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock17
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock17::Module2 ).should == false
      end
    end
  end

	#####################################################################
	#  module_or_class_include_or_extend_prepends_includes_and_extends  #
	#####################################################################

  it 'can include and extend other modules before this one when this one is included in or extends a module or class' do
    module ModuleCluster::Define::ModuleOrClassCluster::Mock18
      extend ModuleCluster::Define::ModuleOrClassCluster
      module Module1
      end
      module Module2
      end
      module_or_class_include_or_extend_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module ModuleProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
      end
      module ModuleProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
      end
      class ClassProof
        include ModuleCluster::Define::ModuleOrClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
      end
      class ClassProof2
        extend ModuleCluster::Define::ModuleOrClassCluster::Mock18
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleOrClassCluster::Mock18::Module2 ).should == true
      end
    end    
  end

end
