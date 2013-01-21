
#############################
#  setup_integration_tests  #
#############################

def setup_integration_tests
  
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
  
  let( :integration_args ) { [ clustered_instance, event_context, include_modules, extend_modules, block_state ] }
  let( :class_integration_args ) { [ clustered_instance, :subclass, include_modules, extend_modules, block_state ] }

  let( :event_context ) { :before_include }
  let( :include_or_extend ) { :include }

  let( :module_instance ) do
    _include_or_extend, _clustered_instance = include_or_extend, clustered_instance
    ::Module.new.name( :ModuleInstance ).module_eval { __send__( _include_or_extend, _clustered_instance ) }
  end

  let( :class_instance ) do
    _include_or_extend, _clustered_instance = include_or_extend, clustered_instance
    ::Class.new.name( :ClassInstance ).module_eval { __send__( _include_or_extend, _clustered_instance ) }
  end

  let( :object_instance ) { ::Object.new.name( :ObjectInstance ).extend( clustered_instance ) }
  
end
