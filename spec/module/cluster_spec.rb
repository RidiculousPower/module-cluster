
require_relative '../../lib/module/cluster.rb'

require_relative '../helpers/support.rb'
require_relative '../support/named_class_and_module.rb'

describe ::Module::Cluster do

  let( :module_instance ) { ::Module.new.name( :ModuleInstance ) }
  let( :class_instance ) { ::Class.new.name( :ClassInstance ) }
  let( :class_inheriting_from_module ) { ::Class.new( ::Module ).name( :ClassInheritingFromModule ) }

  let( :enabled_module ) { module_instance.name( :EnabledModule ).extend( ::Module::Cluster ) }
  let( :enabled_class ) { class_instance.name( :EnabledClass ).extend( ::Module::Cluster ) }
  let( :enabled_class_inheriting_from_module ) { class_inheriting_from_module.name( :EnabledClassInheritingFromModule ).extend( ::Module::Cluster ) }
  let( :instance_of_enabled_class_inheriting_from_module ) { enabled_class_inheriting_from_module.new.name( :InstanceOfEnabledClassInheritingFromModule ) }
  
  let( :cluster_name ) { :cluster_name }
  
  ###################
  #  self.extended  #
  ###################
  
  context '::extended' do
    
    context 'when module' do
      let( :extended_module ) { enabled_module }
      it 'an extended class should have ModuleSupport (#append_features,#included,#extend_object,#extended)' do
        extended_module.should have_module_support
      end
      it 'an extended class should not have ClassSupport (#inherited)' do
        extended_module.should_not have_class_support
      end
    end

    context 'when class' do
      let( :extended_class ) { enabled_class }
      it 'an extended class should have ClassSupport (#inherited)' do
        extended_class.should have_class_support
      end
      it 'an extended class should not have ModuleSupport (#append_features,#included,#extend_object,#extended)' do
        extended_class.should_not have_module_support
      end
    end

    context 'when class inheriting from module' do
      let( :extended_class_inheriting_from_module_instance ) { enabled_class_inheriting_from_module }
      let( :instance_of_extended_class_inheriting_from_module_instance ) { instance_of_enabled_class_inheriting_from_module }
      it 'an extended class inheriting from module should not have ModuleSupport (#append_features,#included,#extend_object,#extended)' do
        extended_class_inheriting_from_module_instance.should_not have_module_support
      end
      it 'an extended class inheriting from module should have ClassSupport (#inherited)' do
        extended_class_inheriting_from_module_instance.should have_class_support
      end
      it 'an instance of an extended class inheriting from module should not have ClassSupport (#inherited)' do
        instance_of_extended_class_inheriting_from_module_instance.should_not have_class_support
      end
      it 'an instance of an extended class inheriting from module should have ModuleSupport (#append_features,#included,#extend_object,#extended)' do
        instance_of_extended_class_inheriting_from_module_instance.should have_module_support
      end
    end
    
  end
  
  #############
  #  cluster  #
  #############

  context '#cluster' do
    let( :cluster ) { enabled_instance.cluster( cluster_name ) }
    context 'when module' do
      let( :enabled_instance ) { enabled_module }
      it 'returns cluster from controller' do
        cluster.should == ::Module::Cluster.instance_controller( enabled_module ).cluster( cluster_name )
      end
    end
    context 'when class' do
      let( :enabled_instance ) { enabled_class }
      it 'returns cluster from controller' do
        cluster.should == ::Module::Cluster.instance_controller( enabled_class ).cluster( cluster_name )
      end
    end
    context 'when class inheriting from module' do
      let( :enabled_instance ) { enabled_class_inheriting_from_module }
      it 'returns cluster from controller' do
        cluster.should == ::Module::Cluster.instance_controller( enabled_class_inheriting_from_module ).cluster( cluster_name )
      end
    end
  end
  
  ##################
  #  has_cluster?  #
  ##################

  context '#has_cluster?' do
    let( :has_cluster? ) do
      enabled_instance.cluster( cluster_name )
      enabled_instance.has_cluster?( cluster_name )
    end
    context 'when module' do
      let( :enabled_instance ) { enabled_module }
      it 'returns cluster from controller' do
        has_cluster?.should == true
      end
    end
    context 'when class' do
      let( :enabled_instance ) { enabled_class }
      it 'returns cluster from controller' do
        has_cluster?.should == true
      end
    end
    context 'when class inheriting from module' do
      let( :enabled_instance ) { enabled_class_inheriting_from_module }
      it 'returns cluster from controller' do
        has_cluster?.should == true
      end
    end
  end
    
end
