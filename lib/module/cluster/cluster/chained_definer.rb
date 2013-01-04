
class ::Module::Cluster::Cluster::ChainedDefiner

  ################
  #  initialize  #
  ################
  
  ###
  # @param cluster [Module::Cluster::Cluster]
  #
  #        Cluster instance ChainedDefiner is for.
  #
  def initialize( cluster )
    
    @cluster = cluster
    
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
    
    @cluster.add_instance_context( *contexts )
    @cluster.add_hook_context( :before_include )
    @cluster.action( & block ) if block_given?

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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def after_include( *contexts, & block )

    @cluster.add_instance_context( *contexts )
    @cluster.add_hook_context( :after_include )
    @cluster.action( & block ) if block_given?
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def before_extend( *contexts, & block )
    
    @cluster.add_instance_context( *contexts )
    @cluster.add_hook_context( :before_extend )
    @cluster.action( & block ) if block_given?
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def after_extend( *contexts, & block )

    @cluster.add_instance_context( *contexts )
    @cluster.add_hook_context( :after_extend )
    @cluster.action( & block ) if block_given?
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def subclass( & block )
    
    @cluster.add_hook_context( :subclass )
    @cluster.action( & block ) if block_given?
    
    return self

  end
  
  #############
  #  cascade  #
  #############
  
  def cascade( & block )
    
    @cluster.cascade( & block )
    
    return self
    
  end

  ################
  #  cascade_to  #
  ################
  
  def cascade_to( *cascade_contexts, & block )
    
    @cluster.add_cascade_context( *cascade_contexts )
    @cluster.action( & block ) if block_given?
    
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
  def before( *modules, & block )
    
    unless modules.empty?
      @before_modules ||= { }
      @before_modules.clear
      modules.each do |this_module|
        @before_modules[ this_module ] = true
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
  def after( *modules, & block )

    unless modules.empty?
      @after_modules ||= { }
      @after_modules.clear
      modules.each do |this_module|
        @after_modules[ this_module ] = true
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

    return new_stack_frame( :include, *modules, & block )
    
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
    
    return new_stack_frame( :include, *modules, & block )
    
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
    
    return new_stack_frame( :include, *modules, & block )
    
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
    
    return new_stack_frame( nil, *modules, & block )
    
  end
  
  ######################################################################################################################
      private ##########################################################################################################
  ######################################################################################################################

  #####################
  #  new_stack_frame  #
  #####################
  
  def new_stack_frame( event_context, *modules, & block )

    frame = ::Module::Cluster::Cluster::Frame.new( @cluster.instance,
                                                   @cluster.name,
                                                   @cluster.cascade_contexts ? @cluster.cascade_contexts.dup : nil,
                                                   @cluster.instance_contexts ? @cluster.instance_contexts.dup : nil,
                                                   modules,
                                                   event_context,
                                                   block  )
    
    instance_controller = @cluster.instance_controller
    
    @cluster.hook_contexts.each do |this_hook_context|
      instance_controller.stack( this_hook_context ).insert_before_and_after( @before_modules, 
                                                                              @after_modules, 
                                                                              *modules )
    end
  
    return self
    
  end
  
end
