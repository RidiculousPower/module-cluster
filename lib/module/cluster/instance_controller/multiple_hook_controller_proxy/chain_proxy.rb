
###
# A MultipleHookControllerProxy uses a MultipleHookControllerProxy::ChainProxy 
#   to chain commands that rely on chained state.
#
class ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  def initialize( parent_multiple_hook_controller_proxy )

    @parent_multiple_hook_controller_proxy = parent_multiple_hook_controller_proxy
    
    @hook_controllers = @parent_multiple_hook_controller_proxy.hook_controllers

    @proxies = @hook_controllers.collect( & :chain_proxy )
    
  end

  #############
  #  include  #
  #############

  def include( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.include( *modules )
    end

    return self
    
  end

  ############
  #  extend  #
  ############

  def extend( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.extend( *modules )
    end

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.include_and_extend( *modules )
    end

    return self
    
  end
  
  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.extend_and_include( *modules )
    end

    return self
    
  end
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.action( & block )
    end
    
    return self
    
  end

  ################
  #  cascade     #
  #  cascade_to  #
  ################
  
  def cascade( *cascade_contexts, & block )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.cascade( *cascade_contexts, & block )
    end
    
    return self
    
  end
  
  alias_method :cascade_to, :cascade
  
  ###################
  #  before_extend  #
  ###################
  
  def before_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.before_extend( *modules )
    end
    
    return self
    
  end

  ####################
  #  before_include  #
  ####################
  
  def before_include( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.before_include( *modules )
    end
    
    return self
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  def before_include_or_extend( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.before_include_or_extend( *modules )
    end
    
    return self
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  def after_include( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.after_include( *modules )
    end
    
    return self
    
  end

  ##################
  #  after_extend  #
  ##################
  
  def after_extend( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.after_extend( *modules )
    end
    
    return self
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  def after_include_or_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.after_include_or_extend( *modules )
    end
    
    return self
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend

  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ###########################################
  #  parent_multiple_hook_controller_proxy  #
  ###########################################
  
  ###
  # @private
  #
  # Hook controller for which this instance is operative as a chaining proxy.
  #
  attr_reader :parent_multiple_hook_controller_proxy
  
  #############
  #  proxies  #
  #############
  
  ###
  # @private
  #
  # Proxies for which this instance is operative as a chaining proxy.
  #
  attr_reader :proxies
  
  ######################
  #  hook_controllers  #
  ######################

  ###
  # @private
  #
  # Hook controllers that this instance is proxying.
  #
  attr_reader :hook_controllers

  ##################
  #  cluster_name  #
  ##################

  ###
  # @private
  #
  # Set cluster name for which chained actions will be inserted in stack.
  #
  def cluster_name( cluster_name )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.cluster_name( cluster_name )
    end
    
    return self
    
  end

  #############
  #  context  #
  #############
  
  ###
  # @private
  #
  # Set index where chained actions will be inserted in stack.
  #
  def context( *contexts )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.context( *contexts )
    end
    
    return self
    
  end
  
end
