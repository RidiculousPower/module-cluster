# -*- encoding : utf-8 -*-

###
# A FrameDefiner is associated with a cluster in order to create chained declarations of frames.
#
class ::Module::Cluster::Cluster::FrameDefiner

  ################
  #  initialize  #
  ################
  
  ###
  # @param cluster [::Module::Cluster::Cluster]
  #
  #        Cluster instance for which FrameDefiner defines frames.
  #
  def initialize( cluster )
    
    @cluster = cluster
    @hook_contexts = { }
    
  end

  #############
  #  cluster  #
  #############
  
  ###
  # Cluster instance for which FrameDefiner defines frames.
  #
  # @!attribute [r] [Object]
  #
  #             Cluster instance for which FrameDefiner defines frames.
  #
  attr_reader :cluster
  
  #############
  #  context  #
  #############

  ###
  # Define execution context for event frames defined after this call.
  #
  #   :any is the implicit execution context and does not need to be set explicitly.
  #
  # @overload context( execution_context, ... )
  #
  #   @param [:any,:class,:module,:instance] execution_context
  #
  #          Context for which event frames defined after this call will be executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def context( *contexts )

    @execution_contexts.clear if @execution_contexts
    add_execution_context( *contexts )
    
    return self
    
  end
  
  #############
  #  cascade  #
  #############
  
  ###
  # Define cascade context for event frames defined after this call as :any.
  #
  #   This is the same as calling #cascade_to( :any ).
  #
  # @yield [hooked_instance] 
  #
  #        Block action to execute at time hook frame executes.
  #
  # @yieldparam [Object] hooked_instance
  #
  #             Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def cascade( & block )
    
    @cascade_contexts.clear if @cascade_contexts
    add_cascade_context( :any )
    action( & block ) if block_given?
    
    return self
    
  end

  ################
  #  cascade_to  #
  ################
  
  ###
  # Define cascade context for event frames defined after this call.
  #
  # @overload cascade_to( cascade_context, ..., & block )
  #
  #   @param [:any,:module,:class,:subclass]
  #
  #          Context for which frames defined after this call should cascade.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def cascade_to( *cascade_contexts, & block )
    
    @cascade_contexts.clear if @cascade_contexts
    add_cascade_context( *cascade_contexts )
    action( & block ) if block_given?
    
    return self
    
  end

  ###########
  #  clear  #
  ###########
  
  ###
  # Reset state-related info.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def clear
    
    @hook_contexts.clear      if @hook_contexts
    @execution_contexts.clear if @execution_contexts
    @cascade_contexts.clear   if @cascade_contexts
    
    self
    
  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # Create before-include event hook.
  #
  # @overload before_include( context, ... )
  #
  #   @param context
  #
  #          Optional context for which hook should be active: :any, :module, :class.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def before_include( *contexts, & block )
    
    add_execution_context( *contexts )
    add_hook_context( :before_include )
    action( & block ) if block_given?
    
    return self
    
  end

  ###################
  #  after_include  #
  ###################
  
  ###
  # Create after-include event hook.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def after_include( *contexts, & block )

    add_execution_context( *contexts )
    add_hook_context( :after_include )
    action( & block ) if block_given?
    
    return self

  end
  
  ###################
  #  before_extend  #
  ###################
  
  ###
  # Create before-extend event hook.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def before_extend( *contexts, & block )
    
    add_execution_context( *contexts )
    add_hook_context( :before_extend )
    action( & block ) if block_given?
    
    return self
    
  end
  
  ##################
  #  after_extend  #
  ##################
  
  ###
  # Create after-extend event hook.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def after_extend( *contexts, & block )

    add_execution_context( *contexts )
    add_hook_context( :after_extend )
    action( & block ) if block_given?
    
    return self

  end
  
  ##############
  #  subclass  #
  ##############
  
  ###
  # Create subclass event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def subclass( & block )
    
    add_hook_context( :subclass )
    action( & block ) if block_given?
    
    return self

  end
  
  ##############################
  #  before_include_or_extend  #
  ##############################
  
  ###
  # Create before-include and before-extend event hooks.
  #
  # @overload before_include_or_extend( context, ... )
  #
  #   @param context
  #
  #          Optional context for which hook should be active: :any, :module, :class.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def before_include_or_extend( & block )
    
    add_hook_context( :before_include )
    add_hook_context( :before_extend )
    action( & block ) if block_given?
    
    return self
    
  end

  #############################
  #  after_include_or_extend  #
  #############################

  ###
  # Create after-include and after-extend event hooks.
  #
  # @overload after_include_or_extend( context, ... )
  #
  #   @param context
  #
  #          Optional context for which hook should be active: :any, :module, :class.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def after_include_or_extend( & block )

    add_hook_context( :after_include )
    add_hook_context( :after_extend )
    action( & block ) if block_given?
    
    return self

  end

  #######################
  #  before_initialize  #
  #######################
  
  def before_initialize( & block )
    
    case instance = @cluster.instance
      when ::Class
        instance.module_eval { include( ::Module::Cluster::InitializeSupport ) }
    end
    
    add_hook_context( :before_initialize )
    action( & block ) if block_given?
    
    return self
    
  end
  
  ######################
  #  after_initialize  #
  ######################
  
  def after_initialize( & block )

    case instance = @cluster.instance
      when ::Class
        instance.module_eval { include( ::Module::Cluster::InitializeSupport ) }
    end

    add_hook_context( :after_initialize )
    action( & block ) if block_given?
    
    return self

  end
  
  #####################
  #  before_instance  #
  #####################
  
  def before_instance( & block )
    
    case instance = @cluster.instance
      when ::Class
        instance.extend( ::Module::Cluster::InstanceSupport )
    end
    
    add_hook_context( :before_instance )
    action( & block ) if block_given?
    
    return self
    
  end
  
  ####################
  #  after_instance  #
  ####################
  
  def after_instance( & block )

    case instance = @cluster.instance
      when ::Class
        instance.extend( ::Module::Cluster::InstanceSupport )
    end

    add_hook_context( :after_instance )
    action( & block ) if block_given?
    
    return self

  end
  
  ############
  #  before  #
  ############

  ###
  # Declare context for defining hooks such that any hooks declared by #action, #include, 
  #   #extend, #include_and_extend, #extend_and_include, or when a block is passed will be 
  #   defined in the cluster stack before provided modules and the corresponding 
  #   include/extend action.
  #
  #   An ArgumentError exception will be raised if this is not possible.
  #
  # @overload before( include_or_extend, module_instance, ..., & block )
  #
  #   @param [nil,:include,:extend,:include_or_extend,
  #           :extend_or_include,:include_and_extend,:extend_and_include] include_or_extend
  #
  #          Only match modules with corresponding action.
  #          nil will match any action.
  #
  #   @param [Module] module_instance
  #
  #          Module to match.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def before( include_or_extend, *modules, & block )
    
    @before_modules ||= { }
    @before_modules.clear
    modules.each do |this_module|
      @before_modules[ this_module ] = include_or_extend
    end
    action( & block ) if block_given?
        
    return self
    
  end

  ###########
  #  after  #
  ###########

  ###
  # Declare context for defining hooks such that any hooks declared by #action, #include, 
  #   #extend, #include_and_extend, #extend_and_include, or when a block is passed will be 
  #   defined in the cluster stack after provided modules and the corresponding 
  #   include/extend action.
  #
  #   An ArgumentError exception will be raised if this is not possible.
  #
  # @overload after( include_or_extend, module_instance, ..., & block )
  #
  #   @param [nil,:include,:extend,:include_or_extend,
  #           :extend_or_include,:include_and_extend,:extend_and_include] include_or_extend
  #
  #          Only match modules with corresponding action.
  #          nil will match any action.
  #
  #   @param [Module] module_instance
  #
  #          Module to match.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def after( include_or_extend, *modules, & block )

    @after_modules ||= { }
    @after_modules.clear
    modules.each do |this_module|
      @after_modules[ this_module ] = include_or_extend
    end
    action( & block ) if block_given?
        
    return self
    
  end

  #############
  #  include  #
  #############
  
  ###
  # Declare that modules should be included at event hook.
  #
  # @overload include( module_instance, ..., & block )
  #
  #   @param [Module] module_instance
  #
  #          Module to include at event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def include( *modules, & block )

    new_stack_frame( :include, *modules, & block )
    
    return self
    
  end
  
  ############
  #  extend  #
  ############

  ###
  # Declare that modules should be extended at event hook.
  #
  # @overload extend( module_instance, ..., & block )
  #
  #   @param [Module] module_instance
  #
  #          Module to include at event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def extend( *modules, & block )

    new_stack_frame( :extend, *modules, & block )
    
    return self
    
  end

  ########################
  #  include_and_extend  #
  ########################

  ###
  # Declare that modules should be included and extended at event hook. See also #extend_and_include.
  #
  # @overload include_and_extend( module_instance, ..., & block )
  #
  #   @param [Module] module_instance
  #
  #          Module to include at event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def include_and_extend( *modules, & block )
    
    return new_stack_frame( :include_and_extend, *modules, & block )
    
  end

  ########################
  #  extend_and_include  #
  ########################

  ###
  # Declare that modules should be extended and included at event hook.
  #
  # @overload extend_and_include( module_instance, ..., & block )
  #
  #   @param [Module] module_instance
  #
  #          Module to include at event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def extend_and_include( *modules, & block )
    
    return new_stack_frame( :extend_and_include, *modules, & block )
    
  end
  
  ############
  #  action  #
  ############
  
  ###
  # Declare that action should be performed at event hook.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def action( & block )
    
    return new_stack_frame( nil, & block )
    
  end
  
  ######################################################################################################################
      private ##########################################################################################################
  ######################################################################################################################
    
  ######################
  #  add_hook_context  #
  ######################
  
  ###
  # Add hook context for event hook frames defined after this point.
  #
  # @param [:before_include,:before_extend,:after_include,:after_extend,:subclass] context
  #
  #        Hook context for which event hook frames defined after this point will execute.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def add_hook_context( context )

    case context
      when :before_include, :before_extend, :after_include, :after_extend
        case @cluster.instance
          when ::Class
            unless @cluster.instance <= ::Module
              raise ::RuntimeError, 'Include/Extend execution hooks cannot be created for classes.'
            end
        end
      when :subclass
        case @cluster.instance
          when ::Class
          when ::Module
            raise ::RuntimeError, 'Subclass execution hooks cannot be created for modules.'
        end
    end
    
    @hook_contexts[ context ] = true
    
    return self
    
  end
  
  ###########################
  #  add_execution_context  #
  ###########################
  
  ###
  # Add execution contexts for event hook frames defined after this point.
  #
  # @overload add_execution_context( context, ... )
  #
  #   @param [:any,:module,:class,:instance] context
  #   
  #          Instance context for which event hook frames defined after this point will execute.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def add_execution_context( *contexts )

    unless contexts.empty?
      
      @execution_contexts ||= { }
    
      contexts.each do |this_context|
        @execution_contexts[ this_context ] = true
      end
    
    end
    
  end

  #########################
  #  add_cascade_context  #
  #########################
  
  ###
  # Add cascade contexts for event hook frames defined after this point.
  #
  # @overload add_cascade_context( context, ... )
  #
  #   @param [:any,:module,:class,:instance] context
  #   
  #          Context for which event hook frames defined after this point will cascade.
  #
  # @return [::Module::Cluster::Cluster::FrameDefiner] Self.
  #
  def add_cascade_context( *contexts )
    
    unless contexts.empty?
      
      @cascade_contexts ||= { }
    
      contexts.each do |this_context|
        next if this_context.nil?
        @cascade_contexts[ this_context ] = true
      end
    
    end
    
  end
  
  #####################
  #  new_stack_frame  #
  #####################
  
  ###
  # Create a new stack frame using the current hook, execution, and cascade contexts. 
  #
  # @overload new_stack_frame( include_or_extend, module_instance, ..., & block )
  #
  #   @param [:include,:extend,:include_and_extend,:extend_and_include] include_or_extend
  #
  #          Include and/or extend module instances at execution of event hook frame.
  #
  #   @param [Module] module_instance
  #
  #          Module to include/extend.
  #
  #   @yield [hooked_instance] 
  #   
  #          Block action to execute at time hook frame executes.
  #   
  #   @yieldparam [Object] hooked_instance
  #   
  #               Instance for which hooked event is being executed.
  #
  # @return [::Module::Cluster::Cluster::Frame]
  #
  #         New stack frame for current context.
  #
  def new_stack_frame( include_or_extend, *modules, & block )

    frame = ::Module::Cluster::Cluster::Frame.new( @cluster.instance,
                                                   @cluster.name,
                                                   @execution_contexts ? @execution_contexts.keys.sort : nil,
                                                   @cascade_contexts ? @cascade_contexts.keys.sort : nil,
                                                   modules,
                                                   include_or_extend,
                                                   block )
    
    instance_controller = @cluster.instance_controller

    @hook_contexts.each do |this_hook_context, true_value|
      instance_controller.stack( this_hook_context ).insert_before_and_after( @before_modules, 
                                                                              @after_modules, 
                                                                              frame )
    end
  
    return frame
    
  end
  
end
