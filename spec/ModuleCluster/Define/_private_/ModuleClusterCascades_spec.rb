
require_relative '../../../../lib/module-cluster.rb'

describe ModuleCluster::Define::ModuleClusterCascades do

  ##############################################
  #  anonymous_module_cascade_append_features  #
  ##############################################

  it 'it can construct an anonymous module each time requested to append features with modules' do
    class ModuleCluster::Define::ModuleClusterCascades::Mock01
      extend ModuleCluster::Define::ModuleClusterCascades
      module Module1
      end
      module Module2
      end
      anonymous_module_cascade_append_features_instance = anonymous_module_cascade_append_features( :include, Module1, Module2 )
      anonymous_module_cascade_append_features_instance.is_a?( Module ).should == true
      anonymous_module_cascade_append_features_instance.instance_methods.include?( :append_features ).should == true
      module SomeModule
      end
      SomeModule.extend( anonymous_module_cascade_append_features_instance )
      SomeModule.respond_to?( :append_features ).should == true
      module SomeOtherModule
        include ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeModule ) ).should == true
      end
      module Cascade1
        include ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeOtherModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeModule ) ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeModule ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::SomeOtherModule ) ).should == true
      end
      anonymous_module_cascade_append_features_instance2 = anonymous_module_cascade_append_features( :extend, Module1, Module2 )
      anonymous_module_cascade_append_features_instance2.should_not == anonymous_module_cascade_append_features_instance
      module AnotherModule
      end
      AnotherModule.extend( anonymous_module_cascade_append_features_instance2 )
      AnotherModule.respond_to?( :append_features ).should == true
      module YetAnotherModule
        include ModuleCluster::Define::ModuleClusterCascades::Mock01::AnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) ).should == true
      end
      module Cascade2
        include ModuleCluster::Define::ModuleClusterCascades::Mock01::YetAnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock01::Module2 ) ).should == true
      end
    end
  end

  #######################################
  #  anonymous_module_cascade_included  #
  #######################################

  it 'it can construct an anonymous module each time requested to include with modules' do
    class ModuleCluster::Define::ModuleClusterCascades::Mock02
      extend ModuleCluster::Define::ModuleClusterCascades
      module Module1
      end
      module Module2
      end
      anonymous_module_cascade_included_instance = anonymous_module_cascade_included( :include, Module1, Module2 )
      anonymous_module_cascade_included_instance.is_a?( Module ).should == true
      anonymous_module_cascade_included_instance.instance_methods.include?( :included ).should == true
      module SomeModule
      end
      SomeModule.extend( anonymous_module_cascade_included_instance )
      SomeModule.respond_to?( :included ).should == true
      module SomeOtherModule
        include ModuleCluster::Define::ModuleClusterCascades::Mock02::SomeModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::SomeModule ) ).should == false
      end
      module Cascade1
        include ModuleCluster::Define::ModuleClusterCascades::Mock02::SomeOtherModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::SomeModule ) ).should == false
      end
      anonymous_module_cascade_included_instance2 = anonymous_module_cascade_included( :extend, Module1, Module2 )
      anonymous_module_cascade_included_instance2.should_not == anonymous_module_cascade_included_instance
      module AnotherModule
      end
      AnotherModule.extend( anonymous_module_cascade_included_instance2 )
      AnotherModule.respond_to?( :included ).should == true
      module YetAnotherModule
        include ModuleCluster::Define::ModuleClusterCascades::Mock02::AnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) ).should == true
      end
      module Cascade2
        include ModuleCluster::Define::ModuleClusterCascades::Mock02::YetAnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock02::Module2 ) ).should == true
      end
    end
  end

  ############################################
  #  anonymous_module_cascade_extend_object  #
  ############################################

  it 'it can construct an anonymous module each time requested to extend object with modules' do
    class ModuleCluster::Define::ModuleClusterCascades::Mock03
      extend ModuleCluster::Define::ModuleClusterCascades
      module Module1
      end
      module Module2
      end
      anonymous_module_cascade_extend_object_instance = anonymous_module_cascade_extend_object( :include, Module1, Module2 )
      anonymous_module_cascade_extend_object_instance.is_a?( Module ).should == true
      anonymous_module_cascade_extend_object_instance.instance_methods.include?( :extend_object ).should == true
      module SomeModule
      end
      SomeModule.extend( anonymous_module_cascade_extend_object_instance )
      SomeModule.respond_to?( :extend_object ).should == true
      module SomeOtherModule
        extend ModuleCluster::Define::ModuleClusterCascades::Mock03::SomeModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ) ).should == true
      end
      module Cascade1
        extend ModuleCluster::Define::ModuleClusterCascades::Mock03::SomeOtherModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ) ).should == true
      end
      anonymous_module_cascade_extend_object_instance2 = anonymous_module_cascade_extend_object( :extend, Module1, Module2 )
      anonymous_module_cascade_extend_object_instance2.should_not == anonymous_module_cascade_extend_object_instance
      module AnotherModule
      end
      AnotherModule.extend( anonymous_module_cascade_extend_object_instance2 )
      AnotherModule.respond_to?( :extend_object ).should == true
      module YetAnotherModule
        extend ModuleCluster::Define::ModuleClusterCascades::Mock03::AnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ) ).should == true
      end
      module Cascade2
        extend ModuleCluster::Define::ModuleClusterCascades::Mock03::YetAnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock03::Module2 ) ).should == true
      end
    end
  end

  #######################################
  #  anonymous_module_cascade_extended  #
  #######################################

  it 'it can construct an anonymous module each time requested to extend with modules' do
    class ModuleCluster::Define::ModuleClusterCascades::Mock04
      extend ModuleCluster::Define::ModuleClusterCascades
      module Module1
      end
      module Module2
      end
      anonymous_module_cascade_extended_instance = anonymous_module_cascade_extended( :include, Module1, Module2 )
      anonymous_module_cascade_extended_instance.is_a?( Module ).should == true
      anonymous_module_cascade_extended_instance.instance_methods.include?( :extended ).should == true
      module SomeModule
      end
      SomeModule.extend( anonymous_module_cascade_extended_instance )
      SomeModule.respond_to?( :extended ).should == true
      module SomeOtherModule
        extend ModuleCluster::Define::ModuleClusterCascades::Mock04::SomeModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ) ).should == true
      end
      module Cascade1
        extend ModuleCluster::Define::ModuleClusterCascades::Mock04::SomeOtherModule
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ).should == true
        ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ).should == true
        ( ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ) > ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ) ).should == true
      end
      anonymous_module_cascade_extended_instance2 = anonymous_module_cascade_extended( :extend, Module1, Module2 )
      anonymous_module_cascade_extended_instance2.should_not == anonymous_module_cascade_extended_instance
      module AnotherModule
      end
      AnotherModule.extend( anonymous_module_cascade_extended_instance2 )
      AnotherModule.respond_to?( :extended ).should == true
      module YetAnotherModule
        extend ModuleCluster::Define::ModuleClusterCascades::Mock04::AnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ) ).should == true
      end
      module Cascade2
        extend ModuleCluster::Define::ModuleClusterCascades::Mock04::YetAnotherModule
        eigenclass = class << self ; self ; end
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ).should == true
        eigenclass.ancestors.include?( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ).should == true
        ( eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module1 ) > eigenclass.ancestors.index( ModuleCluster::Define::ModuleClusterCascades::Mock04::Module2 ) ).should == true
      end
    end    
  end

end
