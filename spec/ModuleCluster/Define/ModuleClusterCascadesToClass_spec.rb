
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ModuleClusterCascadesToClass do

	########################################
	#  include_cascades_includes_to_class  #
	########################################

  it 'include modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_includes_to_class( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock01::Module2 ).should == true
      end
    end
  end
	
	#######################################
	#  include_cascades_extends_to_class  #
	#######################################

  it 'extends modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_extends_to_class( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Proof2
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock02::Module2 ).should == true
      end
    end
  end
	
	####################################################
	#  include_cascades_includes_and_extends_to_class  #
	####################################################

  it 'include and extends modules for any class this module or any including modules are included in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_includes_and_extends_to_class( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock03::Module2 ).should == true
      end
    end
  end

	#######################################
	#  extend_cascades_includes_to_class  #
	#######################################

  it 'include modules for any class this module is extended in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_to_class( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock04::Module2 ).should == true
      end
    end
  end
	
	######################################
	#  extend_cascades_extends_to_class  #
	######################################

  it 'extend modules for any class this module is extended in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_extends_to_class( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module2 ).should == false
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Proof2
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock05::Module2 ).should == true
      end
    end
  end
	
	###################################################
	#  extend_cascades_includes_and_extends_to_class  #
	###################################################

  it 'include and extend modules for any class this module is extended in' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_and_extends_to_class( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == false
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock06::Module2 ).should == true
      end
    end
  end

	###################################################
	#  include_cascades_to_class_prepending_includes  #
	###################################################

  it 'include other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepending_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock07::Module2 ).should == true
      end
    end
  end
	
	##################################################
	#  include_cascades_to_class_prepending_extends  #
	##################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepending_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Proof2
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock08::Module2 ).should == true
      end
    end
  end
	
	###############################################################
	#  include_cascades_to_class_prepending_includes_and_extends  #
	###############################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module or including module is included' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      include_cascades_to_class_prepending_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == false
      end
      module Proof2
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == false
      end
      class Proof3
        include ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock09::Module2 ).should == true
      end
    end
  end

	##################################################
	#  extend_cascades_to_class_prepending_includes  #
	##################################################

  it 'include other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepending_includes( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock10::Module2 ).should == true
      end
    end
  end
	
	#################################################
	#  extend_cascades_to_class_prepending_extends  #
	#################################################

  it 'extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepending_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module2 ).should == false
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Proof2
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock11::Module2 ).should == true
      end
    end
  end
	
	##############################################################
	#  extend_cascades_to_class_prepending_includes_and_extends  #
	##############################################################

  it 'include and extend other modules for any class this module or any including modules are included in, before this module is extended' do
    module ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12
      extend ModuleCluster::Define::ModuleClusterCascadesToClass
      module Module1
      end
      module Module2
      end
      extend_cascades_to_class_prepending_includes_and_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12
      end
      module Proof2
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Proof1
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module2 ).should == false
      end
      class Proof3
        extend ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Proof2
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascadesToClass::Mock12::Module2 ).should == true
      end
    end
  end

end