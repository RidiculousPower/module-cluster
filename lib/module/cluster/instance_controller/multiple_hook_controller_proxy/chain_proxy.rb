
###
# A MultipleHookControllerProxy uses a MultipleHookControllerProxy::ChainProxy 
#   to chain commands that rely on chained state.
#
class ::Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  ###
  # @private
  #
  # @param parent_multiple_hook_controller_proxy Multiple Hook Controller Proxy for which this Chain Proxy is operative.
  #
  def initialize( parent_multiple_hook_controller_proxy )

    @parent_multiple_hook_controller_proxy = parent_multiple_hook_controller_proxy
    
    @proxies = @parent_multiple_hook_controller_proxy.hook_controllers.collect( & :chain_proxy )
    
  end

  #############
  #  include  #
  #############

  ###
  # Declare that modules should be included at event hook in the context specified this chained declaration.
  #
  # @overload include( module, ..., & block )
  #
  #   @param module Module to include at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
  def include( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.include( *modules )
    end

    return self
    
  end

  ############
  #  extend  #
  ############

  ###
  # Declare that modules should be extended at event hook in the context specified this chained declaration.
  #
  # @overload extend( module, ..., & block )
  #
  #   @param module Module to extend at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
  def extend( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.extend( *modules )
    end

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  ###
  # Declare that modules should be included and extended at event hook in the context 
  #   specified this chained declaration. See also #extend_and_include.
  #
  # @overload include_and_extend( module, ..., & block )
  #
  #   @param module Module to include and extend at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
  def include_and_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.include_and_extend( *modules )
    end

    return self
    
  end
  
  ########################
  #  extend_and_include  #
  ########################

  ###
  # Declare that modules should be extended and included at event hook in the context 
  #   specified this chained declaration. Order is reversed from #include_and_extend.
  #
  # @overload extend_and_include( module, ..., & block )
  #
  #   @param module Module to extend and include at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
  def extend_and_include( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.extend_and_include( *modules )
    end

    return self
    
  end
  
  ############
  #  action  #
  ############
  
  ###
  # Declare that action should be performed at event hook in the context 
  #   specified this chained declaration.
  #
  # @yield [hooked_instance] Block for event hook action.
  # @yieldparam hooked_instance Instance for which event hook is occurring. 
  #   Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
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
  
  ###
  # Declare contexts to which declarations made from this declaration chain should cascade.
  #
  # @overload cascade( context, ..., & block )
  #
  #   @param context nil, :any, :class, :module, :subclass Contexts that should have event hooks cascaded into them.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] self
  #
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
  
  ###
  # Declare that chained actions should be inserted into the event stack prior to the location 
  #   in the same event stack where provided module(s) are specified to be extended.
  #
  # @overload before_extend( module, ..., & block )
  #
  #   @param module Module that insert should be prior to.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def before_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.before_extend( *modules )
    end
    
    return self
    
  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # Declare that chained actions should be inserted into the event stack prior to the location 
  #   in the same event stack where provided module(s) are specified to be included.
  #
  # @overload before_include( module, ..., & block )
  #
  #   @param module Module that insert should be prior to.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
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
  
  ###
  # Declare that chained actions should be inserted into the event stack prior to the location 
  #   in the same event stack where provided module(s) are specified to be included or extended.
  #
  # @overload before_include_or_extend( module, ..., & block )
  #
  #   @param module Module that insert should be prior to.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
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
  
  ###
  # Declare that chained actions should be inserted into the event stack after the location 
  #   in the same event stack where provided module(s) are specified to be included.
  #
  # @overload before_include( module, ..., & block )
  #
  #   @param module Module that insert should be after.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def after_include( *modules )

    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.after_include( *modules )
    end
    
    return self
    
  end

  ##################
  #  after_extend  #
  ##################
  
  ###
  # Declare that chained actions should be inserted into the event stack after the location 
  #   in the same event stack where provided module(s) are specified to be extended.
  #
  # @overload before_extend( module, ..., & block )
  #
  #   @param module Module that insert should be after.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
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
  
  ###
  # Declare that chained actions should be inserted into the event stack after the location 
  #   in the same event stack where provided module(s) are specified to be included or extended.
  #
  # @overload before_include_or_extend( module, ..., & block )
  #
  #   @param module Module that insert should be after.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def after_include_or_extend( *modules )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.after_include_or_extend( *modules )
    end
    
    return self
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend

  #############
  #  context  #
  #############
  
  ###
  # Set index where chained actions will be inserted in stack.
  #
  # @overload context( context, ... )
  #
  #   @param context nil, :any, :class, :module, :subclass Contexts that should have event hooks cascaded into them.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] Self.
  #
  def context( *contexts )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.context( *contexts )
    end
    
    return self
    
  end

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
  # @!attribute [reader] Multiple Hook Controller Proxy for which this instance is operative as a chaining proxy
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy] Parent Multiple Hook Controller Proxy.
  #
  attr_reader :parent_multiple_hook_controller_proxy
  
  #############
  #  proxies  #
  #############
  
  ###
  # @private
  #
  # @!attribute [reader] Proxies for which this instance is operative as a chaining proxy.
  #
  # @return [Array<Module::Cluster::InstanceController::HookController::ChainProxy>]
  #
  attr_reader :proxies
  
  ##################
  #  cluster_name  #
  ##################

  ###
  # @private
  #
  # Set cluster name for which chained actions will be inserted in stack.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] Self.
  #
  def cluster_name( cluster_name )
    
    @proxies.each do |this_hook_controller_chain_proxy|
      this_hook_controller_chain_proxy.cluster_name( cluster_name )
    end
    
    return self
    
  end
  
end
