
require_relative '../lib/module/cluster.rb'

require_relative '../spec/helpers/integration.rb'

require_relative '../spec/support/block_state.rb'
require_relative '../spec/support/named_class_and_module.rb'

require_relative 'setup.rb'

require_relative 'cluster_integration/module_execution.rb'
require_relative 'cluster_integration/module_cascade.rb'
require_relative 'cluster_integration/module_conditional_execution.rb'
require_relative 'cluster_integration/module_conditional_cascade.rb'

require_relative 'cluster_integration/class_execution.rb'
require_relative 'cluster_integration/class_cascade.rb'

require_relative 'cluster_integration/class_inheriting_from_module_instance_stacks.rb'
require_relative 'cluster_integration/class_inheriting_from_module_module_stacks.rb'
require_relative 'cluster_integration/class_inheriting_from_module_subclass_stacks.rb'

require_relative 'setup.rb'

describe ::Module::Cluster do

  context 'when module' do

    context ':before_include' do

      let( :event_context ) { :before_include }

      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration
      it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration

    end

    context ':before_extend' do

      let( :event_context ) { :before_extend }

      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration
      it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration

    end

    context ':after_include' do

      let( :event_context ) { :after_include }

      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration
      it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration

    end

    context ':after_extend' do

      let( :event_context ) { :after_extend }
      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration
      it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration

    end
    
  end
  
  context 'when class' do

    context ':subclass' do

      let( :event_context ) { :subclass }

      setup_integration_tests

      it_behaves_like :ClassExecutionIntegration
      it_behaves_like :ClassCascadeIntegration
      it_behaves_like :ClassInheritingFromModuleSubclassStacksIntegration
      
    end

  end
  
  context 'when class inheriting from module' do
  
    setup_integration_tests
  
    context 'subclass of class inheriting from module (class by way of :subclass event_context)' do
      
      context ':before_include' do
        let( :event_context ) { :before_include }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration
      end

      context ':before_extend' do
        let( :event_context ) { :before_extend }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration
      end

      context ':after_include' do
        let( :event_context ) { :after_include }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration
      end

      context ':after_extend' do
        let( :event_context ) { :after_extend }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleModuleStacksIntegration
      end

      context ':subclass' do
        let( :event_context ) { :subclass }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleSubclassStacksIntegration
      end

    end

    context 'instance of class inheriting from module (module by way of :instance event_context)' do
      
      context ':before_initialize' do
        let( :event_context ) { :before_initialize }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleInstanceStacksIntegration
      end

      context ':before_instance' do
        let( :event_context ) { :before_instance }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleInstanceStacksIntegration
      end

      context ':after_initialize' do
        let( :event_context ) { :after_initialize }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleInstanceStacksIntegration
      end

      context ':after_instance' do
        let( :event_context ) { :after_instance }
        setup_integration_tests
        it_behaves_like :ClassInheritingFromModuleInstanceStacksIntegration
      end
      
    end
  
  end
  
end
