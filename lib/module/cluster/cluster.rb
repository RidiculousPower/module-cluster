
###
# A Cluster controls stacks of event hooks for before/after include/extend/subclass events.
#   Clusters can be named so that they can be suspended/enabled separately.
#
class ::Module::Cluster::Cluster
  
  ################
  #  initialize  #
  ################
  
  ###
  #
  # @param instance Instance cluster is for.
  # 
  # @param name Name of cluster.
  #
  def initialize( instance, name )
    
    @instance = instance
    @instance_controller = ::Module::Cluster.instance_controller( instance )
    @name = name
    
    @enabled = true
    
    @hook_contexts = { }
    
  end

  ###########
  #  clear  #
  ###########
  
  ###
  # Reset state-related info.
  #
  def clear
    
    @hook_contexts.clear    if @hook_contexts
    @cascade_contexts.clear if @cascade_contexts

  end

  ###############
  #  instance   #
  ###############
  
  ###
  # Instance that defined cluster.
  #
  # @!attribute [r] [Object]
  #
  attr_reader :instance
  
  ##########################
  #  instance_controller   #
  ##########################
  
  ###
  # Instance controller for instance that defined cluster.
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
  # @!attribute [reader] Cluster name.
  #
  # @return [String] Name.
  #
  attr_reader :name

  ###############
  #  enabled?   #
  ###############
  
  ###
  # Query whether cluster is enabled.
  #
  # @return [true,false] Whether cluster is enabled.
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
  # @return [true,false] Whether cluster is disabled.
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
  # @return [Object] Self.
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
  # @return [Object] Self.
  #
  def enable
    
    @enabled = true
    
    return self
    
  end
  
  #############
  #  context  #
  #############

  def context( *contexts )

    @instance_contexts ||= { }
    
    @instance_contexts.clear
    
    add_instance_context( *contexts )
    
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
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def before_include( *contexts, & block )
    
    add_hook_context( :before_include )

    context( *contexts )
        
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def after_include( *contexts, & block )

    add_hook_context( :after_include )

    context( *contexts )
        
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def before_extend( *contexts, & block )
    
    add_hook_context( :before_extend )

    context( *contexts )
        
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
  #
  def after_extend( *contexts, & block )

    add_hook_context( :after_extend )

    context( *contexts )
        
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
  # @return [Module::Cluster::InstanceController::HookController::ChainedDefiner] 
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
  
  ######################
  #  add_hook_context  #
  ######################
  
  def add_hook_context( context )

    case context
      when :before_include, :before_extend, :after_include, :after_extend
        case @instance
          when ::Class
            unless @instance < ::Module
              raise ::RuntimeError, 'Include hooks cannot be created for classes.'
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

    @instance_contexts ||= { }
    
    contexts.each do |this_context|
      @instance_contexts[ this_context ] = true
    end
    
  end

  #########################
  #  add_cascade_context  #
  #########################
  
  def add_cascade_context( *contexts )
    
    @cascade_contexts ||= { }
    
    contexts.each do |this_context|
      @cascade_contexts[ this_context ] = true
    end
    
  end
  
end
