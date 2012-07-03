
require_relative '../../lib/module/cluster.rb'

describe ::Module::Cluster do

  ###################
  #  include hooks  #
  ###################
  
  # before - without block
  
  it 'can create before-include hooks' do
    module ::Module::Cluster::BeforeIncludeHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_before_include_hook = cluster( :cluster_name ).before_include
        new_before_include_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
        
      end

    end
  end

  # after - without block

  it 'can create after-include hooks' do
    module ::Module::Cluster::AfterIncludeHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_after_include_hook = cluster( :cluster_name ).after_include
        new_after_include_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
        
      end

    end
  end

  # before - with block
  
  it 'can create before-include hooks with block events' do
    module ::Module::Cluster::BeforeIncludeHookBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_before_include_hook = cluster( :cluster_name ).before_include do |instance|
          block_ran = true
        end
        
        new_before_include_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end
    
    end
  end
  
  # after - with block
  
  it 'can create after-include hooks with block events' do
    module ::Module::Cluster::AfterIncludeHookBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_after_include_hook = cluster( :cluster_name ).after_include do |instance|
          block_ran = true
        end
        
        new_after_include_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
    
      end

    end
  end
  
  ##################
  #  extend hooks  #
  ##################

  # before - without block

  it 'can create before-extend hooks' do
    module ::Module::Cluster::BeforeExtendHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_before_extend_hook = cluster( :cluster_name ).before_extend
        new_before_extend_hook.is_a?( ::Module::Cluster::Cluster::BeforeExtendHook ).should == true
      
      end

    end
  end

  # after - without block

  it 'can create after-extend hooks' do
    module ::Module::Cluster::AfterExtendHookMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_after_extend_hook = cluster( :cluster_name ).before_extend
        new_after_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end

  # before - with block

  it 'can create extend hooks with block events' do
    module ::Module::Cluster::BeforeExtendHookBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        block_ran = false
        new_before_extend_hook = cluster( :cluster_name ).before_extend do |instance|
          block_ran = true
        end
        
        new_before_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end

  # after - with block

  it 'can create extend hooks with block events' do
    module ::Module::Cluster::AfterExtendHookBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        block_ran = false
        new_after_extend_hook = cluster( :cluster_name ).before_extend do |instance|
          block_ran = true
        end
        
        new_after_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end

  ####################
  #  subclass hooks  #
  ####################

  # module - without block
  
  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassModuleHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_subclass_hook = cluster( :cluster_name ).subclass
        new_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end
  
  # module - with block
  
  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassModuleHookBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_subclass_hook = cluster( :cluster_name ).subclass do |instance|
          block_ran = true
        end
        new_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end
  
  # class - without block
  
  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassClassHookMock

      module ClusterClassMock
        
        extend ::Module::Cluster
        
        new_subclass_hook = cluster( :cluster_name ).subclass
        new_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # class - with block
  
  it 'can create subclass hooks with block events' do
    module ::Module::Cluster::SubclassClassHookBlockMock

      module ClusterClassMock
        
        extend ::Module::Cluster
        
        block_ran = false
        new_subclass_hook = cluster( :cluster_name ).subclass do |instance|
          block_ran = true
        end
        new_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true
      
      end

    end
  end

  #######################
  #  mixed event hooks  #
  #######################

  # before include or extend - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeExtendHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_before_include_extend_hook = cluster( :cluster_name ).before_include_or_extend 
        new_before_include_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end
  
  # before include or extend - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeExtendHookCombinationBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_before_include_extend_hook = cluster( :cluster_name ).before_include_or_extend do |instance|
          block_ran = true
        end

        new_before_include_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end
  
  # after include or extend - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeExtendHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_after_include_extend_hook = cluster( :cluster_name ).after_include_or_extend 
        new_after_include_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # after include or extend - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeExtendHookCombinationBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_after_include_extend_hook = cluster( :cluster_name ).after_include_or_extend do |instance|
          block_ran = true
        end

        new_after_include_extend_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end
  
  # before include or extend or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeExtendSubclassHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_before_include_extend_subclass_hook = cluster( :cluster_name ).before_include_or_extend_or_subclass 
        new_before_include_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # before include or extend or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeExtendSubclassHookCombinationBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_before_include_extend_subclass_hook = cluster( :cluster_name ).before_include_or_extend_or_subclass do |instance|
          block_ran = true
        end

        new_before_include_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # after include or extend or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeExtendSubclassHookCombinationMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_after_include_extend_subclass_hook = cluster( :cluster_name ).after_include_or_extend_or_subclass 
        new_after_include_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end
    
    end
  end

  # after include or extend or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeExtendSubclassHookCombinationBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_after_include_extend_subclass_hook = cluster( :cluster_name ).after_include_or_extend_or_subclass do |instance|
          block_ran = true
        end

        new_after_include_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # before include or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeSubclassHookCombinationMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_before_include_subclass_hook = cluster( :cluster_name ).before_include_or_subclass 
        new_before_include_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end
    
    end
  end
  
  # before include or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeIncludeSubclassHookCombinationBlockMock
      
      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_before_include_subclass_hook = cluster( :cluster_name ).before_include_or_subclass do |instance|
          block_ran = true
        end

        new_before_include_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end
  
  # after include or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeSubclassHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_after_include_subclass_hook = cluster( :cluster_name ).after_include_or_subclass 
        new_after_include_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # after include or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterIncludeSubclassHookCombinationBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_after_include_subclass_hook = cluster( :cluster_name ).after_include_or_subclass do |instance|
          block_ran = true
        end
        
        new_after_include_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # before extend or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeExtendSubclassHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_before_extend_subclass_hook = cluster( :cluster_name ).before_extend_or_subclass 
        new_before_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # before extend or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::BeforeExtendSubclassHookCombinationBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_before_extend_subclass_hook = cluster( :cluster_name ).before_extend_or_subclass do |instance|
          block_ran = true
        end

        new_before_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # after extend or subclass - without block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterExtendSubclassHookCombinationMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        new_after_extend_subclass_hook = cluster( :cluster_name ).after_extend_or_subclass 
        new_after_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  # after extend or subclass - with block

  it 'can create any combination of include, extend, subclass hooks with block events' do
    module ::Module::Cluster::AfterExtendSubclassHookCombinationBlockMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        block_ran = false
        new_after_extend_subclass_hook = cluster( :cluster_name ).after_extend_or_subclass do |instance|
          block_ran = true
        end
        new_after_extend_subclass_hook.is_a?( ::Module::Cluster::Cluster::Hook ).should == true

      end

    end
  end

  #######################
  #  conditional hooks  #
  #######################

  # class - before
  
  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_include_hook              = cluster( :cluster_name ).before_include( :class )
        class_extend_hook               = cluster( :cluster_name ).before_extend( :class )
        class_include_or_extend_hook    = cluster( :cluster_name ).before_include_or_extend( :class )

      end

    end
  end

  # class - after
  
  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_include_hook              = cluster( :cluster_name ).after_include( :class )
        class_extend_hook               = cluster( :cluster_name ).after_extend( :class )
        class_include_or_extend_hook    = cluster( :cluster_name ).after_include_or_extend( :class )

      end

    end
  end
  
  # module

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeModuleConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        module_include_hook             = cluster( :cluster_name ).before_include( :module )
        module_extend_hook              = cluster( :cluster_name ).before_extend( :module )
        module_include_or_extend_hook   = cluster( :cluster_name ).before_include_or_extend( :module )

      end

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterModuleConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        module_include_hook             = cluster( :cluster_name ).after_include( :module )
        module_extend_hook              = cluster( :cluster_name ).after_extend( :module )
        module_include_or_extend_hook   = cluster( :cluster_name ).after_include_or_extend( :module )

      end

    end
  end
  
  # instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        instance_include_hook           = cluster( :cluster_name ).before_include( :instance )
        instance_extend_hook            = cluster( :cluster_name ).before_extend( :instance )
        instance_include_or_extend_hook = cluster( :cluster_name ).before_include_or_extend( :instance )

      end

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        instance_include_hook           = cluster( :cluster_name ).after_include( :instance )
        instance_extend_hook            = cluster( :cluster_name ).after_extend( :instance )
        instance_include_or_extend_hook = cluster( :cluster_name ).after_include_or_extend( :instance )

      end

    end
  end
  
  # class or module

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassModuleConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_or_module_include_hook              = cluster( :cluster_name ).before_include( :class, :module )
        class_or_module_extend_hook               = cluster( :cluster_name ).before_extend( :class, :module )
        class_or_module_include_or_extend_hook    = cluster( :cluster_name ).before_include_or_extend( :class, :module )

      end

    end
  end
  
  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassModuleConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_or_module_include_hook              = cluster( :cluster_name ).after_include( :class, :module )
        class_or_module_extend_hook               = cluster( :cluster_name ).after_extend( :class, :module )
        class_or_module_include_or_extend_hook    = cluster( :cluster_name ).after_include_or_extend( :class, :module )

      end

    end
  end
  
  # class or instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_include_or_instance_extend_hook              = cluster( :cluster_name ).before_include( :class, :instance )
        class_or_instance_extend_hook                      = cluster( :cluster_name ).before_extend( :class, :instance )
        class_include_or_extend_or_instance_extend_hook    = cluster( :cluster_name ).before_include_or_extend( :class, :instance )

      end

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_include_or_instance_extend_hook              = cluster( :cluster_name ).after_include( :class, :instance )
        class_or_instance_extend_hook                      = cluster( :cluster_name ).after_extend( :class, :instance )
        class_include_or_extend_or_instance_extend_hook    = cluster( :cluster_name ).after_include_or_extend( :class, :instance )

      end

    end
  end
  
  # module or instance

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeModuleInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        module_include_or_instance_extend_hook             = cluster( :cluster_name ).before_include( :module, :instance )
        module_or_instance_extend_hook                     = cluster( :cluster_name ).before_extend( :module, :instance )
        module_include_or_extend_or_instance_extend_hook   = cluster( :cluster_name ).before_include_or_extend( :module, :instance )

      end

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterModuleInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        module_include_or_instance_extend_hook             = cluster( :cluster_name ).after_include( :module, :instance )
        module_or_instance_extend_hook                     = cluster( :cluster_name ).after_extend( :module, :instance )
        module_include_or_extend_or_instance_extend_hook   = cluster( :cluster_name ).after_include_or_extend( :module, :instance )

      end

    end
  end
  
  # class or module or instance (redundant with non-specification)

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::BeforeClassModuleInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_or_module_include_or_instance_extend_hook             = cluster( :cluster_name ).before_include( :class, :module, :instance )
        class_or_module_or_instance_extend_hook                     = cluster( :cluster_name ).before_extend( :class, :module, :instance )
        class_or_module_include_or_extend_or_instance_extend_hook   = cluster( :cluster_name ).before_include_or_extend( :class, :module, :instance )

      end

    end
  end

  it 'can qualify conditional include/extend/subclass hooks based on the instance including/extending/subclassing' do
    module ::Module::Cluster::AfterClassModuleInstanceConditionalHookMock

      module ClusterModuleMock
        
        extend ::Module::Cluster

        class_or_module_include_or_instance_extend_hook             = cluster( :cluster_name ).after_include( :class, :module, :instance )
        class_or_module_or_instance_extend_hook                     = cluster( :cluster_name ).after_extend( :class, :module, :instance )
        class_or_module_include_or_extend_or_instance_extend_hook   = cluster( :cluster_name ).after_include_or_extend( :class, :module, :instance )

      end

    end
  end

  ###################
  #  event actions  #
  ###################

  it 'can create event actions to perform at hook time' do
    module ::Module::Cluster::IncludeEventActionMock

      module ClusterModuleMock

        extend ::Module::Cluster

        # modules for hooks
        module IncludeModule
        end
        module ExtendModule
        end
        module PrependIncludeModule
        end
        module PrependExtendModule
        end

        # event hook - we arbitrarily use include hook
        # (we've tested event hooks elsewhere, now we test actions, which are from any hook)
        event_hook = cluster( :cluster_name ).after_include

        # include
        event_hook.include( PrependIncludeModule )

        # extend
        event_hook.extend( PrependExtendModule )

      end
      
      module SomeOtherModule
        
        include ::Module::Cluster::IncludeEventActionMock::ClusterModuleMock
        
        eigenclass = class << self ; self ; end
        
        ancestors.include?( ClusterModuleMock::IncludeModule ).should == true
        ancestors.include?( ClusterModuleMock::PrependIncludeModule ).should == true
        ancestors.index( ClusterModuleMock::IncludeModule ).should < ancestors.index( ClusterModuleMock::PrependIncludeModule )
        
        eigenclass.ancestors.include?( ClusterModuleMock::ExtendModule ).should == true
        eigenclass.ancestors.include?( ClusterModuleMock::PrependExtendModule ).should == true
        eigenclass.ancestors.index( ClusterModuleMock::ExtendModule ).should < ancestors.index( ClusterModuleMock::PrependExtendModule )
        
      end
      
    end
  end
  
end
