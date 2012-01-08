
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::ClusterStack::Suspend do

  ##########################
  #  suspend_any_hooks     #
  #  all_hooks_suspended?  #
  #  resume_any_hooks      #
  ##########################

  it 'can suspend all hooks at once' do
    class ModuleCluster::ClusterStack::Suspend::Mock01
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock01.new
    instance.all_hooks_suspended?.should == false
    instance.suspend_any_hooks
    instance.all_hooks_suspended?.should == true
    instance.all_include_hooks_suspended?.should == true
    instance.all_extend_hooks_suspended?.should == true
    instance.include_hooks_suspended?.should == true
    instance.extend_hooks_suspended?.should == true
    instance.prepend_include_hooks_suspended?.should == true
    instance.prepend_extend_hooks_suspended?.should == true
    instance.resume_any_hooks
    instance.all_hooks_suspended?.should == false
  end
  
  ##################################
  #  suspend_any_include_hooks     #
  #  all_include_hooks_suspended?  #
  #  resume_any_include_hooks      #
  ##################################

  it 'can suspend all include hooks at once' do
    class ModuleCluster::ClusterStack::Suspend::Mock02
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock02.new
    instance.all_include_hooks_suspended?.should == false
    instance.suspend_any_include_hooks
    instance.all_include_hooks_suspended?.should == true
    instance.include_hooks_suspended?.should == true
    instance.prepend_include_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_extend_hooks_suspended?.should == false
    instance.resume_any_include_hooks
    instance.all_include_hooks_suspended?.should == false
  end

  #################################
  #  suspend_any_extend_hooks     #
  #  all_extend_hooks_suspended?  #
  #  resume_any_extend_hooks      #
  #################################

  it 'can suspend all extend hooks at once' do
    class ModuleCluster::ClusterStack::Suspend::Mock03
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock03.new
    instance.all_extend_hooks_suspended?.should == false
    instance.suspend_any_extend_hooks
    instance.all_extend_hooks_suspended?.should == true
    instance.extend_hooks_suspended?.should == true
    instance.prepend_extend_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_include_hooks_suspended?.should == false
    instance.resume_any_extend_hooks
    instance.all_extend_hooks_suspended?.should == false
  end

  ##############################
  #  suspend_include_hooks     #
  #  include_hooks_suspended?  #
  #  resume_include_hooks      #
  ##############################

  it 'can suspend all include hooks' do
    class ModuleCluster::ClusterStack::Suspend::Mock04
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock04.new
    instance.include_hooks_suspended?.should == false
    instance.suspend_include_hooks
    instance.include_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_include_hooks_suspended?.should == false
    instance.all_extend_hooks_suspended?.should == false
    instance.extend_hooks_suspended?.should == false
    instance.prepend_include_hooks_suspended?.should == false
    instance.prepend_extend_hooks_suspended?.should == false
    instance.resume_include_hooks
    instance.include_hooks_suspended?.should == false
  end

  #############################
  #  suspend_extend_hooks     #
  #  extend_hooks_suspended?  #
  #  resume_extend_hooks      #
  #############################

  it 'can suspend all extend hooks' do
    class ModuleCluster::ClusterStack::Suspend::Mock05
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock05.new
    instance.extend_hooks_suspended?.should == false
    instance.suspend_extend_hooks
    instance.extend_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_include_hooks_suspended?.should == false
    instance.all_extend_hooks_suspended?.should == false
    instance.include_hooks_suspended?.should == false
    instance.prepend_include_hooks_suspended?.should == false
    instance.prepend_extend_hooks_suspended?.should == false
    instance.resume_extend_hooks
    instance.extend_hooks_suspended?.should == false
  end

  ######################################
  #  suspend_prepend_include_hooks     #
  #  prepend_include_hooks_suspended?  #
  #  resume_prepend_include_hooks      #
  ######################################

  it 'can suspend all prepend include hooks' do
    class ModuleCluster::ClusterStack::Suspend::Mock06
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock06.new
    instance.prepend_include_hooks_suspended?.should == false
    instance.suspend_prepend_include_hooks
    instance.prepend_include_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_include_hooks_suspended?.should == false
    instance.all_extend_hooks_suspended?.should == false
    instance.include_hooks_suspended?.should == false
    instance.extend_hooks_suspended?.should == false
    instance.prepend_extend_hooks_suspended?.should == false
    instance.resume_prepend_include_hooks
    instance.prepend_include_hooks_suspended?.should == false
  end

  #####################################
  #  suspend_prepend_extend_hooks     #
  #  prepend_extend_hooks_suspended?  #
  #  resume_prepend_extend_hooks      #
  #####################################

  it 'can suspend all prepend extend hooks' do
    class ModuleCluster::ClusterStack::Suspend::Mock07
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock07.new
    instance.prepend_extend_hooks_suspended?.should == false
    instance.suspend_prepend_extend_hooks
    instance.prepend_extend_hooks_suspended?.should == true
    instance.all_hooks_suspended?.should == false
    instance.all_include_hooks_suspended?.should == false
    instance.all_extend_hooks_suspended?.should == false
    instance.include_hooks_suspended?.should == false
    instance.extend_hooks_suspended?.should == false
    instance.prepend_include_hooks_suspended?.should == false
    instance.resume_prepend_extend_hooks
    instance.prepend_extend_hooks_suspended?.should == false
  end

  ######################
  #  hooks_suspended?  #
  ######################

  it 'can report whether hooks are extended for all of current action' do
    class ModuleCluster::ClusterStack::Suspend::Mock08
      include ModuleCluster::ClusterStack::Suspend
    end
    instance = ModuleCluster::ClusterStack::Suspend::Mock08.new
    instance.hooks_suspended?( :prepend_include ).should == false
    instance.hooks_suspended?( :include ).should == false
    instance.hooks_suspended?( :prepend_extend ).should == false
    instance.hooks_suspended?( :extend ).should == false
    
    # suspend all
    instance.suspend_any_hooks
    instance.hooks_suspended?( :prepend_include ).should == true
    instance.hooks_suspended?( :include ).should == true
    instance.hooks_suspended?( :prepend_extend ).should == true
    instance.hooks_suspended?( :extend ).should == true
    instance.resume_any_hooks
    
    # suspend all include
    instance.suspend_any_include_hooks
    instance.hooks_suspended?( :prepend_include ).should == true
    instance.hooks_suspended?( :include ).should == true
    instance.hooks_suspended?( :prepend_extend ).should == false
    instance.hooks_suspended?( :extend ).should == false
    instance.resume_any_include_hooks
    
    # suspend all extend
    instance.suspend_any_extend_hooks
    instance.hooks_suspended?( :prepend_include ).should == false
    instance.hooks_suspended?( :include ).should == false
    instance.hooks_suspended?( :prepend_extend ).should == true
    instance.hooks_suspended?( :extend ).should == true
    instance.resume_any_extend_hooks
    
    # suspend prepend include
    instance.suspend_prepend_include_hooks
    instance.hooks_suspended?( :prepend_include ).should == true
    instance.hooks_suspended?( :include ).should == false
    instance.hooks_suspended?( :prepend_extend ).should == false
    instance.hooks_suspended?( :extend ).should == false
    instance.resume_prepend_include_hooks
    
    # suspend include
    instance.suspend_include_hooks
    instance.hooks_suspended?( :prepend_include ).should == false
    instance.hooks_suspended?( :include ).should == true
    instance.hooks_suspended?( :prepend_extend ).should == false
    instance.hooks_suspended?( :extend ).should == false
    instance.resume_include_hooks
    
    # suspend prepend extend
    instance.suspend_prepend_extend_hooks
    instance.hooks_suspended?( :prepend_include ).should == false
    instance.hooks_suspended?( :include ).should == false
    instance.hooks_suspended?( :prepend_extend ).should == true
    instance.hooks_suspended?( :extend ).should == false
    instance.resume_prepend_extend_hooks
    
    # suspend extend
    instance.suspend_extend_hooks
    instance.hooks_suspended?( :prepend_include ).should == false
    instance.hooks_suspended?( :include ).should == false
    instance.hooks_suspended?( :prepend_extend ).should == false
    instance.hooks_suspended?( :extend ).should == true
    instance.resume_extend_hooks
    
  end

end
