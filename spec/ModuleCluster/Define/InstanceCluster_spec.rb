
require_relative '../../../lib/module-cluster.rb'

describe ModuleCluster::Define::InstanceCluster do

  ####################################
  #  self.should_include_or_extend?  #
  ####################################

  it 'should return true if instance, false otherwise' do
    ModuleCluster::Define::InstanceCluster.should_include_or_extend?( Kernel ).should == false
    ModuleCluster::Define::InstanceCluster.should_include_or_extend?( Class ).should == false
    ModuleCluster::Define::InstanceCluster.should_include_or_extend?( Object.new ).should == true    
  end

  ##########################
  #  self.should_cascade?  #
  ##########################

  it 'should report false' do
    ModuleCluster::Define::InstanceCluster.should_cascade?( Kernel ).should == false
    ModuleCluster::Define::InstanceCluster.should_cascade?( Class ).should == false
    ModuleCluster::Define::InstanceCluster.should_cascade?( Object.new ).should == false
  end
	
	##################################
	#  instance_extend_also_extends  #
	##################################
	
  it 'can extend other modules when this one extends a module or instance' do
    module ModuleCluster::Define::InstanceCluster::Mock01
      extend ModuleCluster::Define::InstanceCluster
      module Module1
      end
      module Module2
      end
      instance_extend_also_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extended ).should == true
      module ModuleProof
        extend ModuleCluster::Define::InstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::InstanceCluster::Mock01
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::InstanceCluster::Mock01
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock01::Module2 ).should == true
      end
    end
  end

	######################################
	#  instance_extend_prepends_extends  #
	######################################
	
  it 'can extend other modules before this one when this one extends an instance' do
    module ModuleCluster::Define::InstanceCluster::Mock02
      extend ModuleCluster::Define::InstanceCluster
      module Module1
      end
      module Module2
      end
      instance_extend_prepends_extends( Module1, Module2 ).name = :some_name
      respond_to?( :extend_object ).should == true
      module ModuleProof
        extend ModuleCluster::Define::InstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module2 ).should == false
      end
      class ClassProof
        extend ModuleCluster::Define::InstanceCluster::Mock02
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module1 ).should == false
        ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module2 ).should == false
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module1 ).should == false
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module2 ).should == false
      end
      Object.new.instance_eval do
        extend ModuleCluster::Define::InstanceCluster::Mock02
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::InstanceCluster::Mock02::Module2 ).should == true
      end
    end
  end
	
end
