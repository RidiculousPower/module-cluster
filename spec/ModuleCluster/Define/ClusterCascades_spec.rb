
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ClusterCascades do

	###############################
	#  include_cascades_includes  #
	###############################

  it 'include modules for any class or module this module is included in' do
    module ModuleCluster::Define::ClusterCascades::Mock01
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_includes( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock01
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock01::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock01::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock01::Module2 ).should == true
      end
    end
  end
	
	##############################
	#  include_cascades_extends  #
	##############################

  it 'extends modules for any class or module this module is included in' do
    module ModuleCluster::Define::ClusterCascades::Mock02
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock02
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock02::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock02::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock02::Module2 ).should == true
      end
    end
  end
	
	###########################################
	#  include_cascades_includes_and_extends  #
	###########################################

  it 'include and extends modules for any class or module this module is included in' do
    module ModuleCluster::Define::ClusterCascades::Mock03
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock03
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock03::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock03::Module2 ).should == true
      end
    end
  end

	##############################
	#  extend_cascades_includes  #
	##############################

  it 'include modules for any class or module this module is extended in' do
    module ModuleCluster::Define::ClusterCascades::Mock04
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_includes( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock04
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock04::Module2 ).should == true
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock04::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock04::Module2 ).should == true
      end
    end
  end
	
	#############################
	#  extend_cascades_extends  #
	#############################

  it 'extend modules for any class or module this module is extended in' do
    module ModuleCluster::Define::ClusterCascades::Mock05
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock05::Module2 ).should == true
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock05::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock05::Module2 ).should == true
      end
    end
  end
	
	##########################################
	#  extend_cascades_includes_and_extends  #
	##########################################

  it 'include and extend modules for any class or module this module is extended in' do
    module ModuleCluster::Define::ClusterCascades::Mock06
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_includes_and_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock06
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module2 ).should == true
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock06::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock06::Module2 ).should == true
      end
    end
  end

	##########################################
	#  include_cascades_prepending_includes  #
	##########################################

  it 'include other modules for any class or module this module is included in, before this module is included' do
    module ModuleCluster::Define::ClusterCascades::Mock07
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_prepending_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock07
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock07::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock07::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock07::Module2 ).should == true
      end
    end
  end
	
	#########################################
	#  include_cascades_prepending_extends  #
	#########################################

  it 'extend other modules for any class or module this module is included in, before this module is included' do
    module ModuleCluster::Define::ClusterCascades::Mock08
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_prepending_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock08
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock08::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock08::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock08::Module2 ).should == true
      end
    end
  end
	
	######################################################
	#  include_cascades_prepending_includes_and_extends  #
	######################################################

  it 'include and extend other modules for any class or module this module is included in, before this module is included' do
    module ModuleCluster::Define::ClusterCascades::Mock09
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      include_cascades_prepending_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof1
        include ModuleCluster::Define::ClusterCascades::Mock09
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module2 ).should == true
      end
      module Proof2
        include ModuleCluster::Define::ClusterCascades::Mock09::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock09::Module2 ).should == true
      end
    end
  end

	#########################################
	#  extend_cascades_prepending_includes  #
	#########################################

  it 'include other modules for any class or module this module is included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascades::Mock10
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_prepending_includes( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock10
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock10::Module2 ).should == true
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock10::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock10::Module2 ).should == true
      end
    end
  end
	
	########################################
	#  extend_cascades_prepending_extends  #
	########################################

  it 'extend other modules for any class or module this module is included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascades::Mock11
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_prepending_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock11::Module2 ).should == true
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock11::Proof1
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock11::Module2 ).should == true
      end
    end
  end
	
	#####################################################
	#  extend_cascades_prepending_includes_and_extends  #
	#####################################################
  
  it 'include and extend other modules for any class or module this module is included in, before this module is extended' do
    module ModuleCluster::Define::ClusterCascades::Mock12
      extend ModuleCluster::Define::ClusterCascades
      module Module1
      end
      module Module2
      end
      extend_cascades_prepending_includes_and_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof1
        extend ModuleCluster::Define::ClusterCascades::Mock12
      end
      module Proof2
        extend ModuleCluster::Define::ClusterCascades::Mock12::Proof1
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ClusterCascades::Mock12::Module2 ).should == true
      end
    end
  end
  
end
