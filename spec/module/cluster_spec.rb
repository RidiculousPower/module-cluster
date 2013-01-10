
require_relative '../../lib/module/cluster.rb'

require_relative '../helpers/support.rb'

describe ::Module::Cluster do
  
  let( :module_instance ) { ::Module.new }
  let( :class_instance ) { ::Class.new }
  let( :class_inheriting_from_module ) { ::Class.new( ::Module ) }

  let( :enabled_module_instance ) { module_instance.extend( ::Module::Cluster ) }
  let( :enabled_class_instance ) { class_instance.extend( ::Module::Cluster ) }
  let( :enabled_class_inheriting_from_module_instance ) { class_inheriting_from_module.extend( ::Module::Cluster ) }
  let( :instance_of_enabled_class_inheriting_from_module_instance ) { enabled_class_inheriting_from_module_instance.new }
  
  let( :cluster_name ) { :cluster_name }
  
  ###################
  #  self.extended  #
  ###################
  
  context '::extended' do
    
    context 'when module' do
      it 'should call #enable_with_module_cluster' do
        enabled_module_instance.should have_module_support
        enabled_module_instance.should_not have_class_support
      end
    end

    context 'when class' do
      it 'should call #enable_with_module_cluster' do
        enabled_class_instance.should_not have_module_support
        enabled_class_instance.should have_class_support
      end
    end

    context 'when class inheriting from module' do
      it 'should call #enable_with_module_cluster' do
        enabled_class_inheriting_from_module_instance.should_not have_module_support
        enabled_class_inheriting_from_module_instance.should have_class_support
        instance_of_enabled_class_inheriting_from_module_instance.should have_module_support
      end
    end
    
  end
  
  #############
  #  cluster  #
  #############

  context '#cluster' do
    context 'when module' do
      it 'returns cluster from controller' do
        enabled_module_instance.cluster( cluster_name ).should == ::Module::Cluster.instance_controller( enabled_module_instance ).cluster( cluster_name )
      end
    end
    context 'when class' do
      it 'returns cluster from controller' do
        enabled_class_instance.cluster( cluster_name ).should == ::Module::Cluster.instance_controller( enabled_class_instance ).cluster( cluster_name )
      end
    end
    context 'when class inheriting from module' do
      it 'returns cluster from controller' do
        enabled_class_inheriting_from_module_instance.cluster( cluster_name ).should == ::Module::Cluster.instance_controller( enabled_class_inheriting_from_module_instance ).cluster( cluster_name )
      end
    end
  end
  
  ##################
  #  has_cluster?  #
  ##################

  context '#has_cluster?' do
    context 'when module' do
      it 'returns cluster from controller' do
        enabled_module_instance.has_cluster?( cluster_name ).should == false
        enabled_module_instance.cluster( cluster_name )
        enabled_module_instance.has_cluster?( cluster_name ).should == true
      end
    end
    context 'when class' do
      it 'returns cluster from controller' do
        enabled_class_instance.has_cluster?( cluster_name ).should == false
        enabled_class_instance.cluster( cluster_name )
        enabled_class_instance.has_cluster?( cluster_name ).should == true
      end
    end
    context 'when class inheriting from module' do
      it 'returns cluster from controller' do
        enabled_class_inheriting_from_module_instance.has_cluster?( cluster_name ).should == false
        enabled_class_inheriting_from_module_instance.cluster( cluster_name )
        enabled_class_inheriting_from_module_instance.has_cluster?( cluster_name ).should == true
      end
    end
  end
  
end
