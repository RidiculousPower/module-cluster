
###
# An InstanceController uses an InstanceController::HookController::ChainProxy to chain commands
#   that rely on chained state.
#
class ::Module::Cluster::InstanceController::HookController::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  ###
  # @private
  #
  # @param parent_hook_controller Hook Controller for which this Chain Proxy is operative.
  #
  def initialize( parent_hook_controller )
    
    @parent_hook_controller = parent_hook_controller
    
    @contexts = [ ]
    @cascades_to = [ ]
    
    @index = -1
    
  end

  #############
  #  include  #
  #############

  ###
  # Declare that modules should be included at event hook in the context specified this chained declaration.
  #
  # @overload include( module, .., & block )
  #
  #   @param module Module to include at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def include( *modules, & block )
    
    @parent_hook_controller.include_at_index( @index, @cluster_name, @contexts, @cascades_to, true, *modules, & block )

    return self
    
  end

  ############
  #  extend  #
  ############

  ###
  # Declare that modules should be extended at event hook in the context specified this chained declaration.
  #
  # @overload extend( module, .., & block )
  #
  #   @param module Module to extend at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def extend( *modules, & block )

    @index = @parent_hook_controller.extend_at_index( @index, 
                                                      @cluster_name, 
                                                      @contexts, 
                                                      @cascades_to, 
                                                      true, 
                                                      *modules, 
                                                      & block )

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  ###
  # Declare that modules should be included and extended at event hook in the context 
  #   specified this chained declaration. See also #extend_and_include.
  #
  # @overload include_and_extend( module, .., & block )
  #
  #   @param module Module to include and extend at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def include_and_extend( *modules, & block )
    
    @index = @parent_hook_controller.include_and_extend_at_index( @index, 
                                                                  @cluster_name, 
                                                                  @contexts, 
                                                                  @cascades_to, 
                                                                  true, 
                                                                  *modules, 
                                                                  & block )

    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  ###
  # Declare that modules should be extended and included at event hook in the context 
  #   specified this chained declaration. Order is reversed from #include_and_extend.
  #
  # @overload extend_and_include( module, .., & block )
  #
  #   @param module Module to extend and include at event hook in the context specified this chained declaration.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def extend_and_include( *modules, & block )
    
    @index = @parent_hook_controller.extend_and_include_at_index( @index, 
                                                                  @cluster_name, 
                                                                  @contexts, 
                                                                  @cascades_to, 
                                                                  true, 
                                                                  *modules, 
                                                                  & block )

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
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def action( & block )
    
    @index = @parent_hook_controller.action_at_index( @index, @cluster_name, @contexts, @cascades_to, true, & block )
    
    return self
    
  end

  ################
  #  cascade     #
  #  cascade_to  #
  ################
  
  ###
  # Declare contexts to which declarations made from this declaration chain should cascade.
  #
  # @overload cascade( context, .., & block )
  #
  #   @param context nil, :any, :class, :module, :subclass Contexts that should have event hooks cascaded into them.
  #
  #   @yield [hooked_instance] Block for event hook action.
  #   @yieldparam hooked_instance Instance for which event hook is occurring. 
  #     Equivalent to parameter for #included and #extended.
  # 
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def cascade( *cascade_contexts, & block )

    case cascade_contexts.count

      when 0

        @cascades_to.clear
        @cascades_to.push( :any )

      when 1

        if cascade_contexts[ 0 ].nil?
          @cascades_to.clear
        else
          @cascades_to.replace( cascade_contexts )
        end

      else

        @cascades_to.replace( cascade_contexts )

    end
    
    if block_given?
      action( & block )
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
  # @overload before_extend( module, .., & block )
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
    
    @index = parent_hook_controller.lowest_index( :extend, *modules )
    
    return self
    
  end

  ####################
  #  before_include  #
  ####################
  
  ###
  # Declare that chained actions should be inserted into the event stack prior to the location 
  #   in the same event stack where provided module(s) are specified to be included.
  #
  # @overload before_include( module, .., & block )
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
    
    @index = parent_hook_controller.lowest_index( :include, *modules )
    
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
  # @overload before_include_or_extend( module, .., & block )
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

    @index = parent_hook_controller.lowest_index( :include_or_extend, *modules )
    
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
  # @overload before_include( module, .., & block )
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

    @index = parent_hook_controller.highest_index( :include, *modules ) + 1
    
    return self
    
  end

  ##################
  #  after_extend  #
  ##################
  
  ###
  # Declare that chained actions should be inserted into the event stack after the location 
  #   in the same event stack where provided module(s) are specified to be extended.
  #
  # @overload before_extend( module, .., & block )
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

    @index = parent_hook_controller.highest_index( :extend, *modules ) + 1
    
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
  # @overload before_include_or_extend( module, .., & block )
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
    
    @index = parent_hook_controller.highest_index( :include_or_extend, *modules ) + 1
    
    return self
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend

  #############
  #  context  #
  #############
  
  ###
  # Set context for matching instance to determine whether to perform chained actions in stack.
  #
  # @overload context( context, .. )
  #
  #   @param context nil, :any, :class, :module, :subclass Contexts that should have event hooks cascaded into them.
  #
  # @return [Module::Cluster::InstanceController::HookController::ChainProxy] Self.
  #
  def context( *contexts )
    
    @contexts.replace( contexts )
    
    return self
    
  end

  ######################################################################################################################
  #   private ##########################################################################################################
  ######################################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ############################
  #  parent_hook_controller  #
  ############################
  
  ###
  # @private
  #
  # Hook controller for which this instance is operative as a chaining proxy.
  #
  attr_reader :parent_hook_controller
  
  #################
  #  reset_state  #
  #################
  
  ###
  # @private
  #
  # Reset internal state data so that proxy can be re-used for chaining in a new context.
  #
  # @return [Module::Cluster::InstanceController::ChainProxy] Self.
  #
  def reset_state
    
    @cluster_name = nil
    @index = -1

    @contexts.clear
    @cascades_to.clear
    
    return self
    
  end

  ##################
  #  cluster_name  #
  ##################

  ###
  # @private
  #
  # Set cluster name for which chained actions will be inserted in stack.
  #
  # @return [Module::Cluster::InstanceController::ChainProxy] Self.
  #
  def cluster_name( cluster_name )
    
    @cluster_name = cluster_name
    
    return self
    
  end

  ###########
  #  index  #
  ###########
  
  ###
  # @private
  #
  # Set index where chained actions will be inserted in stack.
  #
  # @return [Module::Cluster::InstanceController::ChainProxy] Self.
  #
  def index( index )
    
    @index = index
    
    return self
    
  end

  ##############
  #  contexts  #
  ##############
  
  ###
  # @private
  #
  # Contexts (nil, :module, :class, :subclass, :instance) for which this instance is operative as a chain proxy.
  #
  # @return [Array<Symbol,nil>] Contexts for which this Chain Proxy instance is operative.
  #
  attr_reader :contexts
  
  #################
  #  cascades_to  #
  #################
  
  ###
  # @private
  #
  # Contexts (nil, :module, :class, :subclass, :instance) for which this instance cascades.
  #
  # @return [Array<Symbol,nil>] Contexts for which this Chain Proxy instance cascades.
  #
  attr_reader :cascades_to
  
end
