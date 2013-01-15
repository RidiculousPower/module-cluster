
require_relative '../../../../lib/module/cluster.rb'

require_relative '../../../support/named_class_and_module.rb'
require_relative '../../../support/block_state.rb'

require_relative '../../../helpers/created.rb'
require_relative '../../../helpers/context.rb'

describe ::Module::Cluster::Cluster::FrameDefiner do

  before :all do
    MockModuleCluster = ::Class.new do
      def instance
        @module_instance ||= ::Module.new.name( :Instance )
      end
      def instance_controller
        @instance_controller ||= ::Module::Cluster.instance_controller( @module_instance )
      end
      def name
        @name ||= :cluster_name
      end
    end
    MockClassCluster = ::Class.new( MockModuleCluster ) do
      def instance
        @class_instance ||= ::Class.new.name( :ClassInstance )
      end
    end
  end
  
  let( :module_instance ) { mock_cluster.instance }
  let( :controller_for_module ) { mock_cluster.instance_controller }
  
  let( :cluster_name ) { mock_cluster.name }
  let( :frame ) { ::Module::Cluster::Cluster::Frame.new( module_instance, cluster_name, execution_contexts, cascade_contexts, modules, include_or_extend, block_action ) }
  let( :modules ) { nil }
  let( :include_or_extend ) { nil }
  let( :block_action ) { nil }
  
  let( :mock_cluster ) { ::MockModuleCluster.new }
  let( :frame_definer ) { ::Module::Cluster::Cluster::FrameDefiner.new( mock_cluster ) }

  let( :module_a ) { ::Module.new.name( :ModuleA ) }
  let( :module_b ) { ::Module.new.name( :ModuleB ) }
  let( :module_c ) { ::Module.new.name( :ModuleC ) }
  let( :module_d ) { ::Module.new.name( :ModuleD ) }
  
  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################
  
  context '========  Internal State Administration  ========' do
    
    ######################
    #  add_hook_context  #
    ######################
  
    context '#add_hook_context' do
      let( :hook_context ) { :before_include }
      let( :add_hook_context ) do
        _hook_context = hook_context
        frame_definer.instance_eval { add_hook_context( _hook_context ) }
        frame_definer
      end
      it 'can add a hook context to apply to hook frames defined next' do
        add_hook_context.should have_added_hook_context( hook_context )
      end
    end
  
    ###########################
    #  add_execution_context  #
    ###########################
  
    context '#add_execution_context' do
      let( :execution_context ) { :module }
      let( :add_execution_context ) do
        _execution_context = execution_context
        frame_definer.instance_eval { add_execution_context( _execution_context ) }
        frame_definer
      end
      it 'can add an instance context to apply to hook frames defined next' do
        add_execution_context.should have_added_execution_context( execution_context )
      end
    end

    #########################
    #  add_cascade_context  #
    #########################
  
    context '#add_cascade_context' do
      let( :cascade_context ) { :module }
      let( :add_cascade_context ) do
        _cascade_context = cascade_context
        frame_definer.instance_eval { add_cascade_context( _cascade_context ) }
        frame_definer
      end
      it 'can add a cascade context to apply to hook frames defined next' do
        add_cascade_context.should have_added_cascade_context( cascade_context )
      end
    end
  
    #####################
    #  new_stack_frame  #
    #####################
  
    context '#new_stack_frame' do
      let( :hook_contexts ) { [ :before_include, :before_extend, :after_include, :after_extend ] }
    
      let( :new_stack_frame_args ) { [ include_or_extend, modules, block_action ] }
      let( :new_stack_verify_args ) { [ frame_definer, hook_contexts, include_or_extend, modules, block_action ] }
      
      let( :new_stack_frame ) do
        new_stack_frame = nil
        _hook_contexts = hook_contexts
        _new_stack_frame_args = new_stack_frame_args
        frame_definer.instance_eval do
          _hook_contexts.each { |this_hook_context| add_hook_context( this_hook_context ) }
          new_stack_frame = new_stack_frame( *_new_stack_frame_args )
        end
        new_stack_frame
      end
      
      context 'when no context' do
        let( :cascade_contexts ) { nil }
        let( :execution_contexts ) { nil }
        it 'creates a frame with nil context' do
          new_stack_frame.should have_created_new_stack_frame( *new_stack_verify_args )
        end
      end

      context 'when empty contexts' do
        let( :cascade_contexts ) { [ ] }
        let( :execution_contexts ) { [ ] }
        it 'creates a frame with nil context' do
          new_stack_frame.should have_created_new_stack_frame( *new_stack_verify_args )
        end
      end
    
      context 'when context contents' do
        let( :cascade_contexts ) { [ :class ] }
        let( :execution_contexts ) { [ :module ] }
        it 'creates a frame with context arrays duplicated' do
          new_stack_frame.should have_created_new_stack_frame( *new_stack_verify_args )
        end
      
      end
    
    end
  
  end
  
  ######################################################################################################################
  #   public ###########################################################################################################
  ######################################################################################################################
  
  context '========  Context Definition  ========' do
  
    #############
    #  cluster  #
    #############

    context '#cluster' do
      let( :cluster ) { frame_definer.cluster }
      it 'is for a cluster' do
        cluster.should == mock_cluster
      end
    end
  
    #############
    #  context  #
    #############

    context '#context' do
      let( :execution_contexts ) { [ :class ] }
      let( :context ) do
        frame_definer.context( *execution_contexts )
        frame_definer
      end
      it 'declares an instance context to apply to hook frames defined next' do
        context.should have_added_execution_context( *execution_contexts )
      end
    end
  
    ###########
    #  clear  #
    ###########
  
    context '#clear' do

      let( :clear ) { frame_definer.clear }

      context 'when no context' do
        it 'should remain as is' do
          clear.should have_cleared_contexts
        end
      end

      context 'when empty contexts' do
        it 'should remain as is' do
          clear.should have_cleared_contexts
        end
      end
    
      context 'when context contents' do
        it 'should clear context state' do
          clear.should have_cleared_contexts
        end
      end
    
    end

    context '=========  Hook Contexts  ========' do

      let( :hook_declaration ) do
        frame_definer.__send__( action )
        frame_definer
      end
      
      ####################
      #  before_include  #
      ####################
  
      context '#before_include' do
        let( :action ) { :before_include }
        let( :hook_contexts ) { [ :before_include ] }
        let( :before_include ) { hook_declaration }
        it 'can add :before_include to hook context to apply to hook frames defined next' do
          before_include.should have_added_hook_context( *hook_contexts )
        end

      end

      ###################
      #  after_include  #
      ###################
  
      context '#after_include' do
        let( :action ) { :after_include }
        let( :hook_contexts ) { [ :after_include ] }
        let( :after_include ) { hook_declaration }
        it 'can add :after_include to hook context to apply to hook frames defined next' do
          after_include.should have_added_hook_context( *hook_contexts )
        end
      end
  
      ###################
      #  before_extend  #
      ###################
  
      context '#before_extend' do
        let( :action ) { :before_extend }
        let( :hook_contexts ) { [ :before_extend ] }
        let( :before_extend ) { hook_declaration }
        it 'can add :before_extend to hook context to apply to hook frames defined next' do
          before_extend.should have_added_hook_context( *hook_contexts )
        end
      end
  
      ##################
      #  after_extend  #
      ##################
  
      context '#after_extend' do
        let( :action ) { :after_extend }
        let( :hook_contexts ) { [ :after_extend ] }
        let( :after_extend ) { hook_declaration }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          after_extend.should have_added_hook_context( *hook_contexts )
        end
      end
  
      ##############
      #  subclass  #
      ##############
  
      context '#subclass' do
        let( :action ) { :subclass }
        let( :hook_contexts ) { [ :subclass ] }
        let( :mock_cluster ) { ::MockClassCluster.new }
        let( :subclass ) { hook_declaration }
        it 'can add :subclass to hook context to apply to hook frames defined next' do
          subclass.should have_added_hook_context( *hook_contexts )
        end
      end
    
      ##############################
      #  before_include_or_extend  #
      ##############################

      context '#before_include_or_extend' do
        let( :action ) { :before_include_or_extend }
        let( :hook_contexts ) { [ :before_include, :before_extend ] }
        let( :before_include_or_extend ) { hook_declaration }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          before_include_or_extend.should have_added_hook_context( *hook_contexts )
        end
      end

      #############################
      #  after_include_or_extend  #
      #############################

      context '#after_include_or_extend' do
        let( :action ) { :after_include_or_extend }
        let( :hook_contexts ) { [ :after_include, :after_extend ] }
        let( :after_include_or_extend ) { hook_declaration }
        it 'can add :after_extend to hook context to apply to hook frames defined next' do
          after_include_or_extend.should have_added_hook_context( *hook_contexts )
        end
      end
    
    end
    
    context '=========  Cascade Contexts  ========' do

      #############
      #  cascade  #
      #############
  
      context '#cascade' do
        let( :cascade_contexts ) { [ :any ] } 
        let( :cascade ) do
          frame_definer.cascade
          frame_definer
        end
        it 'declares cascading for all instances to apply to hook frames defined next' do
          cascade.should have_added_cascade_context( *cascade_contexts )
        end
      end

      ################
      #  cascade_to  #
      ################
  
      context '#cascade_to' do
        let( :cascade_contexts ) { [ :class, :module ] } 
        let( :cascade_to ) do
          frame_definer.cascade_to( *cascade_contexts )
          frame_definer
        end
        it 'declares a cascade context to apply to hook frames defined next' do
          cascade_to.should have_added_cascade_context( *cascade_contexts )
        end
      end

    end
    
    context '=========  Stack Insert Order  ========' do
      
      ############
      #  before  #
      ############

      context '#before' do
        
        
        let( :before_modules ) { [ module_a, module_b ] }
        
        let( :before ) do
          frame_definer.before( include_or_extend, *before_modules )
          frame_definer
        end
        
        context 'include_or_extend is nil' do
          it 'matches any frame with specified modules' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include' do
          let( :include_or_extend ) { :include }
          it 'matches any frame where specified modules are included' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend' do
          let( :include_or_extend ) { :extend }
          it 'matches any frame where specified modules are extended' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include_or_extend' do
          let( :include_or_extend ) { :include_or_extend }
          it 'matches any frame with specified modules' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend_or_include' do
          let( :include_or_extend ) { :extend_or_include }
          it 'matches any frame with specified modules' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :include_and_extend' do
          let( :include_or_extend ) { :include_and_extend }
          it 'matches any frame where specified modules are included and extended' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end

        context 'include_or_extend is :extend_and_include' do
          let( :include_or_extend ) { :extend_and_include }
          it 'matches any frame where specified modules are extended and included' do
            before.should have_added_before_module_context( include_or_extend, before_modules )
          end
        end
              
      end

      ###########
      #  after  #
      ###########

      context '#after' do

        
        let( :after_modules ) { [ module_a, module_b ] }

        let( :after ) do
          frame_definer.after( include_or_extend, *after_modules )
          frame_definer
        end

        context 'include_or_extend is nil' do
          it 'matches any frame with specified modules' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include' do
          let( :include_or_extend ) { :include }
          it 'matches any frame where specified modules are included' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend' do
          let( :include_or_extend ) { :extend }
          it 'matches any frame where specified modules are extended' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include_or_extend' do
          let( :include_or_extend ) { :include_or_extend }
          it 'matches any frame with specified modules' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend_or_include' do
          let( :include_or_extend ) { :extend_or_include }
          it 'matches any frame with specified modules' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :include_and_extend' do
          let( :include_or_extend ) { :include_and_extend }
          it 'matches any frame where specified modules are included and extended' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

        context 'include_or_extend is :extend_and_include' do
          let( :include_or_extend ) { :extend_and_include }
          it 'matches any frame where specified modules are extended and included' do
            after.should have_added_after_module_context( include_or_extend, after_modules )
          end
        end

      end
    
    end
    
  end
  
  context '========  Hook Frame Declaration  ========' do
    
    let( :modules ) { [ module_a ] }
    let( :block_state ) { BlockState.new }
    let( :block_action ) { nil }

    let( :hook_contexts ) { [ :before_include, :before_extend, :after_include, :after_extend ] }

    let( :frame_args ) { [ hook_contexts, include_or_extend, modules, block_state ] }  
  
    let( :frame_creation_method ) do
      # we have to have the frame put on a stack somewhere
      hook_contexts.each do |this_hook_context|
        frame_definer.__send__( this_hook_context )
      end
      # then we create the frame by calling the method we're testing
      frame_definer.__send__( include_or_extend, *modules ) if include_or_extend
      frame_definer.action( & block_action ) if block_action
      frame_definer
    end
    
    #############
    #  include  #
    #############
  
    context '#include' do
      let( :include_or_extend ) { :include }
      let( :include ) { frame_creation_method }
      it 'creates a frame with include_or_extend set to :include' do
        include.should have_created_frame( *frame_args )
      end
    end
  
    ############
    #  extend  #
    ############

    context '#extend' do
      let( :include_or_extend ) { :extend }
      let( :extend ) { frame_creation_method }
      it 'creates a frame with include_or_extend set to :extend' do
        extend.should have_created_frame( *frame_args )
      end
    end

    ########################
    #  include_and_extend  #
    ########################

    context '#include_and_extend' do
      let( :include_or_extend ) { :include_and_extend }
      let( :include_and_extend ) { frame_creation_method }
      it 'creates a frame with include_or_extend set to :include_and_extend' do
        include_and_extend.should have_created_frame( *frame_args )
      end
    end

    ########################
    #  extend_and_include  #
    ########################

    context '#extend_and_include' do
      let( :include_or_extend ) { :extend_and_include }
      let( :extend_and_include ) { frame_creation_method }
      it 'creates a frame with include_or_extend set to :extend_and_include' do
        extend_and_include.should have_created_frame( *frame_args )
      end
    end
  
    ############
    #  action  #
    ############
  
    context '#action' do
      let( :include_or_extend ) { nil }
      let( :action ) { frame_creation_method }
      let( :block_action ) { _block_state = block_state ; block_state.block = ::Proc.new { _block_state.block_ran! } }
      it 'creates a frame with a block' do
        action.should have_created_frame( *frame_args )
      end
    end

  end
  
end
