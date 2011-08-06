
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::Cluster do

	###########################
	#  include_also_includes  #
	###########################

  it 'include other modules when this one is included' do
    module ModuleCluster::Define::Cluster::Mock01
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_includes( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock01
        ancestors.include?( ModuleCluster::Define::Cluster::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock01::Module2 ).should == true
      end
    end
  end
	
	##########################
	#  include_also_extends  #
	##########################
	
  it 'extend other modules when this one is included' do
    module ModuleCluster::Define::Cluster::Mock02
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock02
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock02::Module2 ).should == true
      end
    end
  end
	
	#######################################
	#  include_also_includes_and_extends  #
	#######################################

  it 'include and extend other modules when this one is included' do
    module ModuleCluster::Define::Cluster::Mock03
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_also_includes_and_extends( Module1, Module2 )
      respond_to?( :included ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock03
        ancestors.include?( ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock03::Module2 ).should == true
      end
    end
    
  end

	##########################
	#  extend_also_includes  #
	##########################

  it 'include other modules when this one is extended' do
    module ModuleCluster::Define::Cluster::Mock04
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_includes( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock04
        ancestors.include?( ModuleCluster::Define::Cluster::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock04::Module2 ).should == true
      end
    end
  end
	
	#########################
	#  extend_also_extends  #
	#########################
	
  it 'extend other modules when this one is extended' do
    module ModuleCluster::Define::Cluster::Mock05
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock05
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock05::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock05::Module2 ).should == true
      end
    end
  end
	
	######################################
	#  extend_also_includes_and_extends  #
	######################################

  it 'include and extend other modules when this one is extended' do
    module ModuleCluster::Define::Cluster::Mock06
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_also_includes_and_extends( Module1, Module2 )
      respond_to?( :extended ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock06
        ancestors.include?( ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock06::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock06::Module2 ).should == true
      end
    end
  end

	###############################
	#  include_prepends_includes  #
	###############################

  it 'include other modules before this one is included' do
    module ModuleCluster::Define::Cluster::Mock07
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_includes( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock07
        ancestors.include?( ModuleCluster::Define::Cluster::Mock07::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock07::Module2 ).should == true
      end
    end
  end

	##############################
	#  include_prepends_extends  #
	##############################
	
  it 'extend other modules before this one is included' do
    module ModuleCluster::Define::Cluster::Mock08
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock08
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock08::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock08::Module2 ).should == true
      end
    end
  end
	
	###########################################
	#  include_prepends_includes_and_extends  #
	###########################################

  it 'include and extend other modules before this one is included' do
    module ModuleCluster::Define::Cluster::Mock09
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      include_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :append_features ).should == true
      module Proof
        include ModuleCluster::Define::Cluster::Mock09
        ancestors.include?( ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock09::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock09::Module2 ).should == true
      end
    end
  end

	##############################
	#  extend_prepends_includes  #
	##############################

  it 'include other modules before this one is extended' do
    module ModuleCluster::Define::Cluster::Mock10
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_includes( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock10
        ancestors.include?( ModuleCluster::Define::Cluster::Mock10::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock10::Module2 ).should == true
      end
    end
  end

	#############################
	#  extend_prepends_extends  #
	#############################
	
  it 'extend other modules before this one is extended' do
    module ModuleCluster::Define::Cluster::Mock11
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock11
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock11::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock11::Module2 ).should == true
      end
    end
  end
	
	##########################################
	#  extend_prepends_includes_and_extends  #
	##########################################

  it 'include and extend other modules before this one is extended' do
    module ModuleCluster::Define::Cluster::Mock12
      extend ModuleCluster::Define::Cluster
      module Module1
      end
      module Module2
      end
      extend_prepends_includes_and_extends( Module1, Module2 )
      respond_to?( :extend_object ).should == true
      module Proof
        extend ModuleCluster::Define::Cluster::Mock12
        ancestors.include?( ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock12::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::Cluster::Mock12::Module2 ).should == true
      end
    end
  end
  
end
