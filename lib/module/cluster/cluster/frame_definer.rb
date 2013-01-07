
class ::Module::Cluster::Cluster::FrameDefiner

  ################
  #  initialize  #
  ################
  
  ###
  # @param cluster [Module::Cluster::Cluster]
  #
  #        Cluster instance FrameDefiner is for.
  #
  def initialize( cluster )
    
    @cluster = cluster
    @hook_contexts = { }
    
  end

  #############
  #  context  #
  #############

  def context
  
    @instance_contexts ||= { }
    @instance_contexts.clear
    add_instance_context( *contexts )
    
    return self
    
  end
  
  ###########
  #  clear  #
  ###########
  
  ###
  # Reset state-related info.
  #
  def clear
    
    @hook_contexts.clear     if @hook_contexts
    @instance_contexts.clear if @instance_contexts
    @cascade_contexts.clear  if @cascade_contexts

  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # Create before-include event hook.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  # @return Self
  #
  def before_include( *contexts, & block )
    
    add_instance_context( *contexts )
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
  #
  def after_include( *contexts, & block )

    add_instance_context( *contexts )
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
  #
  def before_extend( *contexts, & block )
    
    add_instance_context( *contexts )
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
  #
  def after_extend( *contexts, & block )

    add_instance_context( *contexts )
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
  # @overload subclass
  #
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
  #
  def subclass( & block )
    
    add_hook_context( :subclass )
    action( & block ) if block_given?
    
    return self

  end
  
  #############
  #  cascade  #
  #############
  
  def cascade( & block )
    
    @cascade_contexts.clear if @cascade_contexts
    add_cascade_context( :any )
    action( & block ) if block_given?
    
    return self
    
  end

  ################
  #  cascade_to  #
  ################
  
  def cascade_to( *cascade_contexts, & block )
    
    @cascade_contexts.clear if @cascade_contexts
    add_cascade_context( *cascade_contexts )
    action( & block ) if block_given?
    
    return self
    
  end

  ############
  #  before  #
  ############

  ###
  # Declare context for defining hooks such that any hooks declared by #action, #include, 
  #   #extend, #include_and_extend, #extend_and_include, or when a block is passed will be 
  #   defined in the cluster stack before provided modules.
  #
  #   An ArgumentError exception will be raised if this is not possible.
  #
  def before( include_or_extend, *modules, & block )
    
    unless modules.empty?
      @before_modules ||= { }
      @before_modules.clear
      modules.each do |this_module|
        @before_modules[ this_module ] = include_or_extend
      end
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
  #   defined in the cluster stack after provided modules.
  #
  #   An ArgumentError exception will be raised if this is not possible.
  #
  def after( include_or_extend, *modules, & block )

    unless modules.empty?
      @after_modules ||= { }
      @after_modules.clear
      modules.each do |this_module|
        @after_modules[ this_module ] = include_or_extend
      end
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
  # @overload include( module, ..., & block )
  #
  #   @param module Module to include at event hook.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController] self
  #
  def include( *modules, & block )
    
    return new_stack_frame( :include, *modules, & block )
    
  end
  
  ############
  #  extend  #
  ############

  ###
  # Declare that modules should be extended at event hook.
  #
  # @overload extend( module, ..., & block )
  #
  #   @param module Module to extend at event hook.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController] self
  #
  def extend( *modules, & block )

    return new_stack_frame( :extend, *modules, & block )
    
  end

  ########################
  #  include_and_extend  #
  ########################

  ###
  # Declare that modules should be included and extended at event hook. See also #extend_and_include.
  #
  # @overload include_and_extend( module, ..., & block )
  #
  #   @param module Module to include and extend at event hook.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController] self
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
  # @overload extend_and_include( module, ..., & block )
  #
  #   @param module Module to extend and include at event hook.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController] self
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
  # @yield [hooked_instance] Block for event hook action.
  # @yieldparam hooked_instance Instance for which event hook is occurring. 
  #   Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController] self
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
  
  def add_hook_context( context )

    case context
      when :before_include, :before_extend, :after_include, :after_extend
        case @instance
          when ::Class
            unless @instance < ::Module
              raise ::RuntimeError, 'Include/Extend hooks cannot be created for classes.'
            end
        end
    end
    
    @hook_contexts[ context ] = true
    
    return self
    
  end
  
  ##########################
  #  add_instance_context  #
  ##########################
  
  def add_instance_context( *contexts )

    unless contexts.empty?
      
      @instance_contexts ||= { }
    
      contexts.each do |this_context|
        @instance_contexts[ this_context ] = true
      end
    
    end
    
  end

  #########################
  #  add_cascade_context  #
  #########################
  
  def add_cascade_context( *contexts )
    
    unless contexts.empty?
      
      @cascade_contexts ||= { }
    
      contexts.each do |this_context|
        @cascade_contexts[ this_context ] = true
      end
    
    end
    
  end
  
  #####################
  #  new_stack_frame  #
  #####################
  
  def new_stack_frame( event_context, *modules, & block )

    frame = ::Module::Cluster::Cluster::Frame.new( @cluster.instance,
                                                   @cluster.name,
                                                   @cascade_contexts ? @cascade_contexts.dup : nil,
                                                   @instance_contexts ? @instance_contexts.dup : nil,
                                                   modules,
                                                   event_context,
                                                   block )
    
    instance_controller = @cluster.instance_controller
    
    hook_contexts.each do |this_hook_context|
      instance_controller.stack( this_hook_context ).insert_before_and_after( @before_modules, 
                                                                              @after_modules, 
                                                                              *modules )
    end
  
    return self
    
  end
  
end
