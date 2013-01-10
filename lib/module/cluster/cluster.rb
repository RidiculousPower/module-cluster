
###
# A Cluster controls stacks of event hooks for before/after include/extend/subclass events.
#   Clusters can be named so that they can be suspended/enabled separately.
#
class ::Module::Cluster::Cluster
  
  ################
  #  initialize  #
  ################
  
  ###
  # @param [Module,Class] instance 
  #
  #        Instance cluster is for.
  # 
  # @param name Name of cluster.
  #
  def initialize( instance, name )
    
    @instance = instance
    @instance_controller = ::Module::Cluster.instance_controller( instance )
    @name = name
    
    @enabled = true
    
    @frame_definer = ::Module::Cluster::Cluster::FrameDefiner.new( self )
    
  end

  ###############
  #  instance   #
  ###############
  
  ###
  # Instance that owns cluster.
  #
  # @!attribute [r] [Object]
  #
  attr_reader :instance
  
  ##########################
  #  instance_controller   #
  ##########################
  
  ###
  # Instance controller for instance that owns cluster.
  #
  # @!attribute [r] [Object]
  #
  attr_reader :instance_controller
  
  ##########
  #  name  #
  ##########
  
  ###
  # Name of cluster.
  #
  # @!attribute [reader] [String]
  #
  attr_reader :name

  ###############
  #  enabled?   #
  ###############
  
  ###
  # Query whether cluster is enabled.
  #
  # @return [true,false] 
  #
  #         Whether cluster is enabled.
  #
  def enabled?
    
    return @enabled
    
  end
  
  ################
  #  disabled?   #
  #  suspended?  #
  ################
  
  ###
  # Query whether cluster is disabled.
  #
  # @return [true,false] 
  #
  #         Whether cluster is disabled.
  #
  def disabled?
    
    return ! @enabled
    
  end
  
  alias_method :suspended?, :disabled?
  
  #############
  #  disable  #
  #  suspend  #
  #############
  
  ###
  # Disable cluster.
  #
  # @return [Module::Cluster::Cluster] Self.
  #
  def disable
    
    @enabled = false
    
    return self
    
  end

  alias_method :suspend, :disable

  ############
  #  enable  #
  ############
  
  ###
  # Re-enable cluster.
  #
  # @return [Module::Cluster::Cluster] Self.
  #
  def enable
    
    @enabled = true
    
    return self
    
  end
  
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
  # @return [Module::Cluster::Cluster] Self.
  #
  def context( *contexts )

    @frame_definer.context( *contexts )
    
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
  # @return [Module::Cluster::Cluster] Self.
  #
  def cascade( & block )
    
    @frame_definer.cascade( & block )

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
  # @return [Module::Cluster::Cluster] Self.
  #
  def cascade_to( *cascade_contexts, & block )
    
    @frame_definer.cascade_to( *cascade_contexts, & block )

    return self
    
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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def before_include( *contexts, & block )
    
    return @frame_definer.before_include( *contexts, & block )
    
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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def after_include( *contexts, & block )

    return @frame_definer.after_include( *contexts, & block )

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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def before_extend( *contexts, & block )
    
    return @frame_definer.before_extend( *contexts, & block )
    
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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def after_extend( *contexts, & block )

    return @frame_definer.after_extend( *contexts, & block )

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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def subclass( & block )
    
    return @frame_definer.subclass( & block )

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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def before_include_or_extend( *contexts, & block )

    return @frame_definer.before_include_or_extend( *contexts, & block )

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
  # @return [Module::Cluster::Cluster::FrameDefiner] 
  #
  def after_include_or_extend( *contexts, & block )

    return @frame_definer.after_include_or_extend( *contexts, & block )

  end
  
end
