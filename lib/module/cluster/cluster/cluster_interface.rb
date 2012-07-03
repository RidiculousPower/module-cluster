
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
    @instance_controller = self.class::InstanceController.new( self )
    @name = name
    
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

  ####################
  #  before_include  #
  ####################
  
  ###
  # Create include event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeEventProxy] 
  #
  def before_include( & block )
    
    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller
    
  end

  ###################
  #  after_include  #
  ###################
  
  ###
  # Create include event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::IncludeEventProxy] 
  #
  def after_include( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

  end
  
  ###################
  #  before_extend  #
  ###################
  
  ###
  # Create extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendEventProxy] 
  #
  def before_extend( & block )
    
    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller
    
  end
  
  ##################
  #  after_extend  #
  ##################
  
  ###
  # Create extend event hook.
  #
  # @return [ModuleCluster::Cluster::EventProxy::ExtendEventProxy] 
  #
  def after_extend( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

  end
  
  ##############
  #  subclass  #
  ##############
  
  ###
  # Create subclass event hook.
  # 
  # @return [ModuleCluster::Cluster::EventProxy::SubclassEventProxy] 
  #
  def subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

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
  def before_include_or_extend( & block )
    
    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller
    
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
  def after_include_or_extend( & block )
    
    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller
    
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
  def before_include_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

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
  def after_include_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

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
  def before_extend_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

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
  def after_extend_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

  end
  
  alias_method :after_subclass_or_include, :after_include_or_subclass
  
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
  def before_include_or_extend_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

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
  def after_include_or_extend_or_subclass( & block )

    hook_controller = @instance_controller.before_include_controller
    
    if block_given?
      hook_controller.action( & block )
    end
    
    return hook_controller

  end
  
  alias_method :after_include_or_subclass_or_extend, :after_include_or_extend_or_subclass
  alias_method :after_extend_or_include_or_subclass, :after_include_or_extend_or_subclass
  alias_method :after_extend_or_subclass_or_include, :after_include_or_extend_or_subclass
  alias_method :after_subclass_or_include_or_extend, :after_include_or_extend_or_subclass
  alias_method :after_subclass_or_extend_or_include, :after_include_or_extend_or_subclass

  ######################
  #  include_cascades  #
  ######################
  
  def include_cascades( *context, & block )
    
    return chain_proxy.context( *context )
    
  end

  #####################
  #  extend_cascades  #
  #####################

  def extend_cascades( *context, & block )

    return chain_proxy.context( *context )

  end
  
  ################################
  #  include_or_extend_cascades  #
  #  extend_or_include_cascades  #
  ################################
  
  def include_or_extend_cascades( *context, & block )
    
    
    
    return chain_proxy.context( *context )
    
  end

  alias_method :extend_or_include_cascades, :include_or_extend_cascades
  
end
