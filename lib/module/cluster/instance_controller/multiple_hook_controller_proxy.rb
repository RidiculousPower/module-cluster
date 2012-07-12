
###
# Proxies before include or extend definitions to both include and extend controllers.
#
class ::Module::Cluster::InstanceController::MultipleHookControllerProxy
      
  ################
  #  initialize  #
  ################
  
  ###
  # @private
  # 
  # @param name Name of this Multiple Hook Controller Proxy.
  #
  # @param hook_controllers Hook Controllers for which this Proxy is operative.
  #
  def initialize( name, *hook_controllers )
    
    @name = name
    
    @hook_controllers = hook_controllers
        
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
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.include( *modules, & block )
    end

    return self
    
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

    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.extend( *modules, & block )
    end

    return self
    
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
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.include_and_extend( *modules, & block )
    end

    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  ###
  # Declare that modules should be extended and included at event hook. Order is reversed from #include_and_extend.
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
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.extend_and_include( *modules, & block )
    end

    return self
    
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
    
    @hook_controllers.each do |this_hook_controller|
      this_hook_controller.action( & block )
    end

    return self
    
  end

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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def before_extend( *modules, & block )
    
    return chain_proxy.before_extend( *modules, & block )
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def before_include( *modules, & block )
    
    return chain_proxy.before_include( *modules, & block )
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def before_include_or_extend( *modules, & block )

    return chain_proxy.before_include_or_extend( *modules, & block )
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def after_include( *modules, & block )

    return chain_proxy.after_include( *modules, & block )
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def after_extend( *modules, & block )

    return chain_proxy.after_extend( *modules, & block )
    
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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Chain Proxy for chained declarations.
  #
  def after_include_or_extend( *modules, & block )
    
    return chain_proxy.after_include_or_extend( *modules, & block )
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend
  
  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  #################
  #  chain_proxy  #
  #################
  
  ###
  # @private
  #
  # Get Chain Proxy instance used by this Multiple Hook Controller Proxy.
  #
  # @return [Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy] Chain Proxy instance.
  #
  def chain_proxy

    return @chain_proxy ||= self.class::ChainProxy.new( self )
    
  end

  ##########
  #  name  #
  ##########
  
  ###
  # @private
  #
  # Name of hook controller.
  #
  # @return [Symbol,String] Name.
  #
  attr_reader :name

  ######################
  #  hook_controllers  #
  ######################
  
  ###
  # @private
  #
  # @!attribute [reader] Hook Controllers this Proxy proxies.
  #
  # @return [Array<Module::Cluster::InstanceController::HookController>] Hook Controllers this Proxy proxies.
  #
  attr_reader :hook_controllers
    
end
