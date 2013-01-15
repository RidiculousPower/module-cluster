
require_relative '../../lib/module/cluster.rb'

require_relative '../helpers/cascaded.rb'
require_relative '../helpers/executed.rb'

require_relative '../support/integration.rb'
require_relative '../support/block_state.rb'
require_relative '../support/named_class_and_module.rb'

describe ::Module::Cluster do
    
  let( :module_instance ) { execute_hook( include_or_extend, execution_enabled_instance, ::Module.new.name( :ModuleInstance ), block_state ) }
  let( :class_instance ) { execute_hook( include_or_extend, execution_enabled_instance, ::Class.new.name( :ClassInstance ), block_state ) }
  let( :instance_of_class ) { execute_hook( include_or_extend, execution_enabled_instance, class_instance.new, block_state ) }
  let( :class_inheriting_from_module ) { execute_hook( include_or_extend, execution_enabled_instance, ::Class.new( ::Module ).name( :ClassInheritingFromModule ), block_state ) }
  let( :instance_of_class_inheriting_from_module ) { class_inheriting_from_module.new.name( :InstanceOfClassInheritingFromModule ) }
   
  let( :module_a ) { ::Module.new.name( :ModuleA ) }
  let( :module_b ) { ::Module.new.name( :ModuleB ) }
  let( :module_c ) { ::Module.new.name( :ModuleC ) }
  let( :module_d ) { ::Module.new.name( :ModuleD ) }

  let( :include_modules ) { [ module_a, module_b ] }
  let( :extend_modules ) { [ module_c, module_d ] }
  let( :block_state ) { BlockState.new }
  let( :block_action ) { _block_state = block_state ; block_state.block = ::Proc.new { _block_state.block_ran! } }
  
  let( :cluster_name ) { :test_cluster }

  let( :execution_contexts ) { [ ] }
  let( :cascade_contexts ) { [ ] }
  
  let( :execution_enabled_module ) { enable_for_execution( ::Module.new.name( :ExecutionEnabledModule ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts ) }
  let( :execution_enabled_class ) { enable_for_execution( ::Class.new.name( :ExecutionEnabledClass ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts ) }
  let( :execution_enabled_class_inheriting_from_module ) { enable_for_execution( ::Class.new( ::Module ).name( :ExecutionEnabledClassInheritingFromModule ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts ) }

  let( :cascade_enabled_module ) { enable_for_cascade( ::Module.new.name( :CascadeEnabledModule ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts, cascade_contexts ) }
  let( :cascade_enabled_class ) { enable_for_cascade( ::Class.new.name( :CascadeEnabledClass ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts, cascade_contexts ) }
  let( :cascade_enabled_class_inheriting_from_module ) { enable_for_cascade( ::Class.new( ::Module ).name( :CascadeEnabledClassInheritingFromModule ).extend( ::Module::Cluster ), cluster_name, event_context, include_modules, extend_modules, block_action, execution_contexts, cascade_contexts ) }

  let( :_module_including_or_extending_cascade_enabled_module ) do
    _cascade_enabled_module = cascade_enabled_module
    case include_or_extend
      when :include
        module_instance = ::Module.new.name( :ModuleIncludingCascadeEnabledModule ) { include( _cascade_enabled_module ) }
      when :extend
        module_instance = ::Module.new.name( :ModuleExtendedByCascadeEnabledModule ).extend( _cascade_enabled_module )
    end
  end

  let( :subclass ) { class_instance ; block_state.clear ; ::Class.new( class_instance ).name( :Subclass ) }
  let( :subclass_of_subclass ) { subclass ; block_state.clear ; ::Class.new( subclass ).name( :SubclassOfSubclass ) }

  let( :class_under_module_including_or_extending_cascade_enabled_module ) do
    _module_including_or_extending_cascade_enabled_module = module_including_or_extending_cascade_enabled_module
    block_state.clear
    case include_or_extend
      when :include
        class_under_module = ::Class.new.name( :ClassUnderModuleIncludingCascadeEnabledModule ) { include( _module_including_or_extending_cascade_enabled_module ) }
      when :extend
        class_under_module = ::Class.new.name( :ClassUnderModuleExtendingCascadeEnabledModule ).extend( _module_including_or_extending_cascade_enabled_module )
    end
    class_under_module
  end
  let( :subclass_of_class_under_module_including_or_extending_cascade_enabled_module ) { class_under_module_including_or_extending_cascade_enabled_module ; block_state.clear ; ::Class.new( class_under_module_including_or_extending_cascade_enabled_module ).name( :ClassUnderModuleIncludingCascadeEnabledModule ) }
  let( :subclass_of_subclass_of_class_under_module_including_or_extending_cascade_enabled_module ) { subclass_of_class_under_module_including_or_extending_cascade_enabled_module ; block_state.clear ; ::Class.new( subclass_of_class_under_module_including_or_extending_cascade_enabled_module ).name( :SubclassOfClassUnderModuleIncludingCascadeEnabledModule ) }
  
  let( :inherited_modules_args ) { [ execution_enabled_instance, include_modules, extend_modules ] }
  let( :executed_block_args ) { [ execution_enabled_instance, block_state ] }
  let( :cascade_module_args ) { [ ::Module::Cluster, execution_enabled_instance, event_context, include_modules, extend_modules ] }
  let( :cascade_block_args ) { [ ::Module::Cluster, execution_enabled_instance, event_context, block_state ] }
  
  # execute_but_not_cascade
  # execute_and_cascade
  # execute_and_cascade_block_only
  # execute_or_cascade
  # cascade_but_not_execute
  
  context 'when module' do

    let( :execution_enabled_instance ) { cascade_enabled_module }
    
    context 'executing' do
      context 'for hooked module' do
        it 'will execute but not cascade' do
          module_instance.should execute_but_not_cascade
        end
      end
      context 'for hooked class' do
        it 'will execute but not cascade' do
          class_instance.should execute_but_not_cascade
        end
      end
      context 'for hooked instance' do
        it 'will execute but not cascade' do
          object_instance.should_not execute_or_cascade
        end
      end
    end
    context 'cascading' do
      context 'to :any' do
        context 'for hooked module' do
          it 'will execute and cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will execute for nth module and cascade' do
            nth_module.should execute_and_cascade
          end
          it 'will execute for the first class and cascade only the block' do
            first_class.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will execute and cascade only the block' do
            class_instance.should execute_and_cascade_block_only
          end
        end
        context 'for hooked instance' do
          it 'will execute but not cascade' do
            instance.should execute_but_not_cascade
          end
        end
      end
      context 'to :module' do
        context 'for hooked module' do
          it 'will execute and cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will execute for nth module and cascade' do
            nth_module.should execute_and_cascade
          end
          it 'will execute for the first class and cascade only the block' do
            first_class.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will not execute or cascade' do
            class_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :class' do
        context 'for hooked module' do
          it 'will not execute or cascade' do
            module_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked class' do
          it 'will execute but not cascade' do
            class_instance.should execute_but_not_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :subclass' do
        context 'for hooked module' do
          it 'will not execute but will cascade' do
            module_instance.should cascade_but_not_execute
          end
          it 'will not execute in the first class but will cascade' do
            first_class.should cascade_but_not_execute
          end
          it 'will execute in the first subclass but will only cascade the block' do
            first_subclass.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will not execute but will cascade' do
            class_instance.should cascade_but_not_execute
          end
          it 'will execute in the first subclass but will only cascade the block' do
            first_subclass.should execute_and_cascade_block_only
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :each_subclass' do
        context 'for hooked module' do
          it 'will not execute but will cascade' do
            module_instance.should cascade_but_not_execute
          end
          it 'will not execute in the first class but will cascade' do
            first_class.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked class' do
          it 'will not execute but will cascade' do
            class_instance.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :class, :subclass' do
        context 'for hooked module' do
          it 'will not execute but will cascade' do
            module_instance.should cascade_but_not_execute
          end
          it 'will execute in the first class but will cascade only the block' do
            first_class.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will execute but will cascade only the block' do
            class_instance.should execute_and_cascade_block_only
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :class, :each_subclass' do
        context 'for hooked module' do
          it 'will not execute but will cascade' do
            module_instance.should cascade_but_not_execute
          end
          it 'will execute in the first class and cascade' do
            first_class.should execute_and_cascade
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked class' do
          it 'will execute and cascade' do
            class_instance.should execute_and_cascade
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :module, :class' do
        context 'for hooked module' do
          it 'will execute and will cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will execute in the first class but not cascade' do
            first_class.should execute_but_not_cascade
          end
        end
        context 'for hooked class' do
          it 'will execute but not cascade' do
            class_instance.should execute_but_not_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :module, :subclass' do
        context 'for hooked module' do
          it 'will execute and will cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will not execute in the first class but will cascade' do
            first_class.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and cascade only the block' do
            first_subclass.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will not execute but will cascade' do
            class_instance.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and cascade only the block' do
            first_subclass.should execute_and_cascade_block_only
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :module, :each_subclass' do
        context 'for hooked module' do
          it 'will execute and cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will not execute in the first class but will cascade' do
            first_class.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked class' do
          it 'will not execute but will cascade' do
            class_instance.should cascade_but_not_execute
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :module, :class, :subclass' do
        context 'for hooked module' do
          it 'will not execute but will cascade' do
            module_instance.should cascade_but_not_execute
          end
          it 'will execute in the first class and cascade' do
            first_class.should execute_and_cascade
          end
          it 'will execute in the first subclass but will cascade only the block' do
            first_subclass.should execute_and_cascade_block_only
          end
        end
        context 'for hooked class' do
          it 'will execute and cascade' do
            class_instance.should execute_and_cascade
          end
          it 'will execute in the first subclass and cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in the nth subclass and cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context 'to :module, :class, :each_subclass' do
        context 'for hooked module' do
          it 'will execute and cascade' do
            module_instance.should execute_and_cascade
          end
          it 'will execute in the first class and cascade' do
            first_class.should execute_and_cascade
          end
          it 'will execute in the first subclass and will cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in each nth subclass and will cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked class' do
          it 'will execute and cascade' do
            class_instance.should execute_and_cascade
          end
          it 'will execute in the first subclass and cascade' do
            first_subclass.should execute_and_cascade
          end
          it 'will execute in the nth subclass and cascade' do
            nth_subclass.should execute_and_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
    end
    context 'conditionally executing' do
      context ':module' do
        context 'for hooked module' do
          it 'will execute but not cascade' do
            module_instance.should execute_but_not_cascade
          end
        end
        context 'for hooked class' do
          it 'will not execute or cascade' do
            class_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context ':class' do
        context 'for hooked module' do
          it 'will not execute or cascade' do
            module_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked class' do
          it 'will execute but not cascade' do
            class_instance.should execute_but_not_cascade
          end
        end
        context 'for hooked instance' do
          it 'will not execute or cascade' do
            instance.should_not execute_or_cascade
          end
        end
      end
      context ':instance' do
        context 'for hooked module' do
          it 'will not execute or cascade' do
            module_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked class' do
          it 'will not execute or cascade' do
            class_instance.should_not execute_or_cascade
          end
        end
        context 'for hooked instance' do
          it 'will execute but not cascade' do
            instance.should execute_but_not_cascade
          end
        end
      end
    end
    context 'conditionally cascading' do
      context ':module' do
        context 'to :module' do
          context 'for hooked module' do
            it 'will execute and cascade' do
              module_instance.should execute_and_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :class' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :subclass' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :each_subclass' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
            it 'will execute for the first subclass and cascade (if explicit include/extend cascading is desired)' do
              first_subclass.should execute_and_cascade
            end
            it 'will execute for the nth subclass and cascade (if explicit include/extend cascading is desired)' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute but will cascade' do
              class_instance.should cascade_but_not_execute
            end
            it 'will execute for the first subclass and cascade (if explicit include/extend cascading is desired)' do
              first_subclass.should execute_and_cascade
            end
            it 'will execute for the nth subclass and cascade (if explicit include/extend cascading is desired)' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :module, :class' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
            it 'will execute in the first class but not cascade' do
              first_class.should execute_but_not_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :module, :subclass' do
          context 'for hooked module' do
            it 'will execute and cascade' do
              module_instance.should execute_and_cascade
            end
            it 'first class will not execute but will cascade' do
              first_class.should cascade_but_not_execute
            end
            it 'first subclass will execute and cascade only the block' do
              first_subclass.should execute_and_cascade_block_only
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :module, :each_subclass' do
          context 'for hooked module' do
            it 'will execute and cascade' do
              module_instance.should execute_and_cascade
            end
            it 'first class will not execute but will cascade' do
              first_class.should cascade_but_not_execute
            end
            it 'nth subclass will execute and cascade' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :module, :class, :subclass' do
          context 'for hooked module' do
            it 'will execute and cascade' do
              module_instance.should execute_and_cascade
            end
            it 'first class will execute and cascade only the block' do
              first_class.should cascade_but_not_execute
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :module, :class, :each_subclass' do
          context 'for hooked module' do
            it 'will execute and cascade' do
              module_instance.should execute_and_cascade
            end
            it 'first class will execute and cascade' do
              first_class.should cascade_but_not_execute
            end
            it 'first subclass will execute and cascade' do
              first_subclass.should execute_and_cascade
            end
            it 'nth subclass will execute and cascade' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :class, :subclass' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
            it 'first class will execute and cascade only the block' do
              first_class.should cascade_but_not_execute
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              class_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :class, :each_subclass' do
          context 'for hooked module' do
            it 'will not execute but will cascade' do
              module_instance.should cascade_but_not_execute
            end
            it 'first class will execute and cascade' do
              first_class.should cascade_but_not_execute
            end
            it 'first subclass will execute and cascade' do
              first_subclass.should execute_and_cascade
            end
            it 'nth subclass will execute and cascade' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
      end
      context ':class' do
        context 'to :subclass' do
          context 'for hooked module' do
            it 'will not execute or cascade' do
              module_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute but will cascade' do
              class_instance.should cascade_but_not_execute
            end
            it 'will execute in the first subclass and cascade only the block' do
              first_subclass.should execute_and_cascade_block_only
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
        context 'to :each_subclass' do
          context 'for hooked module' do
            it 'will not execute or cascade' do
              module_instance.should_not execute_or_cascade
            end
          end
          context 'for hooked class' do
            it 'will not execute but will cascade' do
              class_instance.should cascade_but_not_execute
            end
            it 'will execute in the first subclass and cascade' do
              first_subclass.should execute_and_cascade
            end
            it 'will execute in the nth subclass and cascade' do
              nth_subclass.should execute_and_cascade
            end
          end
          context 'for hooked instance' do
            it 'will not execute or cascade' do
              instance.should_not execute_or_cascade
            end
          end
        end
      end
    end
  end
  
  context 'when class' do
    context 'executing' do
      context 'class => subclass' do
        it 'will execute for the first subclass but not cascade' do
          first_subclass.should execute_but_not_cascade
        end
      end
    end
    context 'cascading' do
      context 'to :any' do
        it 'will execute for the first subclass and cascade the block only (since include/extend cascade implicitly)' do
          first_subclass.should execute_and_cascade_block_only
        end
      end
      context 'to :subclass' do
        it 'will execute for the first subclass and cascade the block only (since include/extend cascade implicitly)' do
          first_subclass.should execute_and_cascade_block_only
        end
      end
      context 'to :each_subclass' do
        it 'will execute for the first subclass and cascade (if explicit include/extend cascading is desired)' do
          first_subclass.should execute_and_cascade
        end
        it 'will execute for the nth subclass and cascade (if explicit include/extend cascading is desired)' do
          first_subclass.should execute_and_cascade
        end
      end
    end
  end
    
  context 'when class inheriting from module' do
    it 'will automatically inherit module hooks defined on the class singleton for instances (:before_include, :after_include, :before_extend, :after_extend)' do
      instance_of_class_inheriting_from_module.should have_inherited_module_stacks
    end
    it 'will not inherit module hooks defined on the class singleton for subclasses (:subclass)' do
      instance_of_class_inheriting_from_module.should_not have_inherited_subclass_stack
    end
  end
  
end
