
require_relative '../../lib/module/cluster.rb'

require_relative '../helpers/integration.rb'

require_relative '../support/block_state.rb'
require_relative '../support/named_class_and_module.rb'

require_relative 'setup.rb'

require_relative 'cluster_integration/module_execution_spec.rb'
require_relative 'cluster_integration/module_cascade_spec.rb'
require_relative 'cluster_integration/module_conditional_execution_spec.rb'
require_relative 'cluster_integration/module_conditional_cascade_spec.rb'

require_relative 'cluster_integration/class_execution_spec.rb'
require_relative 'cluster_integration/class_cascade_spec.rb'

#require_relative 'cluster_integration/class_inheriting_from_module_execution_spec.rb'

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

    end

    context ':before_extend' do

      let( :event_context ) { :before_extend }

      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration

    end

    context ':after_include' do

      let( :event_context ) { :after_include }

      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration

    end

    context ':after_extend' do

      let( :event_context ) { :after_extend }
      setup_integration_tests

      it_behaves_like :ModuleExecutionIntegration
      it_behaves_like :ModuleCascadeIntegration
      it_behaves_like :ModuleConditionalExecutionIntegration
      it_behaves_like :ModuleConditionalCascadeIntegration

    end

    context ':subclass' do

      let( :event_context ) { :subclass }

      setup_integration_tests

      it_behaves_like :ClassExecutionIntegration
      it_behaves_like :ClassCascadeIntegration

    end
    
  end
  
  #context 'when class' do
  #end
  #
  #context 'when class inheriting from module' do
  #
  #  setup_integration_tests
  #
  #  it_behaves_like :ClassInheritingFromModuleExecutionIntegration
  #  it_behaves_like :ClassInheritingFromModuleCascadeIntegration
  #
  #end
  
end
