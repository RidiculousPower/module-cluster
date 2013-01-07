
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
    
    @frame_definer = ::Module::Cluster::Cluster::FrameDefiner.new( self )
    
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

    @frame_definer.context( *contexts )
    
    return self
    
  end

  #############
  #  cascade  #
  #############
  
  def cascade( & block )
    
    @frame_definer.cascade( & block )

    return self
    
  end

  ################
  #  cascade_to  #
  ################
  
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
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
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
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
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
  # @overload subclass
  #
  # @return [Module::Cluster::InstanceController::HookController::FrameDefiner] 
  #
  def subclass( & block )
    
    return @frame_definer.subclass( & block )

  end
  
end
