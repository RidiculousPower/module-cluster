
###
# Interface implemenation for ModuleCluster::Cluster::Cluster. 
#   Declared separately so that methods can be easily overridden.
#
module ::Module::Cluster::Cluster::ClusterInterface
  
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
    
  end

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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] 
  #
  def before_include( *contexts, & block )
    
    hook_controller = @instance_controller.before_include_controller
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] 
  #
  def after_include( *contexts, & block )

    hook_controller = @instance_controller.after_include_controller
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller.chain_proxy.cluster_name( @name ).context( *contexts )

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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] 
  #
  def before_extend( *contexts, & block )
    
    hook_controller = @instance_controller.before_extend_controller
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] 
  #
  def after_extend( *contexts, & block )

    hook_controller = @instance_controller.after_extend_controller
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end
  
  ##############
  #  subclass  #
  ##############
  
  ###
  # Create subclass event hook.
  #
  # @overload subclass
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] 
  #
  def subclass( *contexts, & block )
    
    # contexts parameter included for compatibility with multiple-hook-controller proxy
    
    hook_controller = @instance_controller.subclass_controller
    
    chain_proxy_instance = hook_controller.chain_proxy

    chain_proxy_instance.cluster_name( @name )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end
  
  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  ###
  # Create before-include and before-extend event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def before_include_or_extend( *contexts, & block )
    
    hook_controller = @instance_controller.before_include_extend_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  ###
  # Create after-include and after-extend event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def after_include_or_extend( *contexts, & block )
    
    hook_controller = @instance_controller.after_include_extend_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance
    
  end
  
  alias_method :after_extend_or_include, :after_include_or_extend
  
  ################################
  #  before_include_or_subclass  #
  #  before_subclass_or_include  #
  ################################
  
  ###
  # Create before-include and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def before_include_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.before_include_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end

  alias_method :before_subclass_or_include, :before_include_or_subclass

  ###############################
  #  after_include_or_subclass  #
  #  after_subclass_or_include  #
  ###############################
  
  ###
  # Create after-include and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def after_include_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.after_include_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end
  
  alias_method :after_subclass_or_include, :after_include_or_subclass
  
  ###############################
  #  before_extend_or_subclass  #
  #  before_subclass_or_extend  #
  ###############################
  
  ###
  # Create before-extend and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def before_extend_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.before_extend_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end

  alias_method :before_subclass_or_extend, :before_extend_or_subclass

  ##############################
  #  after_extend_or_subclass  #
  #  after_subclass_or_extend  #
  ##############################
  
  ###
  # Create after-extend and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def after_extend_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.after_extend_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end
  
  alias_method :after_subclass_or_extend, :after_extend_or_subclass
  
  ##########################################
  #  before_include_or_extend_or_subclass  #
  #  before_include_or_subclass_or_extend  #
  #  before_extend_or_include_or_subclass  #
  #  before_extend_or_subclass_or_include  #
  #  before_subclass_or_include_or_extend  #
  #  before_subclass_or_extend_or_include  #
  ##########################################
  
  ###
  # Create before-include and before-extend and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def before_include_or_extend_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.before_include_extend_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end

  alias_method :before_include_or_subclass_or_extend, :before_include_or_extend_or_subclass
  alias_method :before_extend_or_include_or_subclass, :before_include_or_extend_or_subclass
  alias_method :before_extend_or_subclass_or_include, :before_include_or_extend_or_subclass
  alias_method :before_subclass_or_include_or_extend, :before_include_or_extend_or_subclass
  alias_method :before_subclass_or_extend_or_include, :before_include_or_extend_or_subclass

  #########################################
  #  after_include_or_extend_or_subclass  #
  #  after_include_or_subclass_or_extend  #
  #  after_extend_or_include_or_subclass  #
  #  after_extend_or_subclass_or_include  #
  #  after_subclass_or_include_or_extend  #
  #  after_subclass_or_extend_or_include  #
  #########################################
  
  ###
  # Create after-include and after-extend and subclass event hooks.
  #
  # @overload before_include( context, ... )
  #
  #   @param context Optional context for which hook should be active: :any, :module, :class, :instance.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] 
  #
  def after_include_or_extend_or_subclass( *contexts, & block )

    hook_controller = @instance_controller.after_include_extend_subclass_proxy
    
    chain_proxy_instance = hook_controller.chain_proxy
    
    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
    if block_given?
      chain_proxy_instance.action( & block )
    end
    
    return chain_proxy_instance

  end
  
  alias_method :after_include_or_subclass_or_extend, :after_include_or_extend_or_subclass
  alias_method :after_extend_or_include_or_subclass, :after_include_or_extend_or_subclass
  alias_method :after_extend_or_subclass_or_include, :after_include_or_extend_or_subclass
  alias_method :after_subclass_or_include_or_extend, :after_include_or_extend_or_subclass
  alias_method :after_subclass_or_extend_or_include, :after_include_or_extend_or_subclass

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ##############
  #  instance  #
  ##############

  ###
  # @private
  #
  # Instance for which cluster is operative.
  #
  # @!attribute [reader] Instance.
  #
  # @return [Object] Instance.
  #
  attr_reader :instance
  
end
