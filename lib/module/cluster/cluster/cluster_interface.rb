
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

  ##############
  #  instance  #
  ##############

  ###
  # Instance for which cluster is operative.
  #
  # @!attribute [reader] Instance.
  #
  # @return [Object] Instance.
  #
  attr_reader :instance
  
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
  
  def enabled?
    
    return @enabled
    
  end
  
  ################
  #  disabled?   #
  #  suspended?  #
  ################
  
  def disabled?
    
    return ! @enabled
    
  end
  
  alias_method :suspended?, :disabled?
  
  #############
  #  disable  #
  #  suspend  #
  #############
  
  def disable
    
    @enabled = false
    
  end

  alias_method :suspend, :disable

  ############
  #  enable  #
  ############
  
  def enable
    
    @enabled = true
    
  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # Create include event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeEventProxy] 
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
  # Create include event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeEventProxy] 
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
  # Create extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendEventProxy] 
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
  # Create extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendEventProxy] 
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
  # @return [ModuleCluster::Cluster::EventProxy::SubclassEventProxy] 
  #
  def subclass( *contexts, & block )

    hook_controller = @instance_controller.subclass_controller
    
    chain_proxy_instance = hook_controller.chain_proxy

    chain_proxy_instance.cluster_name( @name ).context( *contexts )
    
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
  # Create include and extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrExtendEventProxy] 
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
  # Create include and extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrExtendEventProxy] 
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
  # Create include and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrSubclassEventProxy] 
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
  # Create include and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrSubclassEventProxy] 
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
  # Create extend and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendOrSubclassEventProxy] 
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
  # Create extend and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendOrSubclassEventProxy] 
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
  # Create include and extend and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrExtendOrSubclassEventProxy] 
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
  # Create include and extend and subclass event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeOrExtendOrSubclassEventProxy] 
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

end
