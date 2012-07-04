
###
# An InstanceController uses an InstanceController::HookController::ChainProxy to chain commands
#   that rely on chained state.
#
class ::Module::Cluster::InstanceController::HookController::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  def initialize( parent_hook_controller )
    
    @parent_hook_controller = parent_hook_controller
    
    @contexts = [ ]
    @cascade_to = [ ]
    
    @index = -1
    
  end

  #############
  #  include  #
  #############

  def include( *modules, & block )
    
    @parent_hook_controller.include_at_index( @index, @cluster_name, @contexts, @cascade_to, true, *modules, & block )

    return self
    
  end

  ############
  #  extend  #
  ############

  def extend( *modules, & block )

    @index = @parent_hook_controller.extend_at_index( @index, 
                                                      @cluster_name, 
                                                      @contexts, 
                                                      @cascade_to, 
                                                      true, 
                                                      *modules, 
                                                      & block )

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules, & block )
    
    @index = @parent_hook_controller.include_and_extend_at_index( @index, 
                                                                  @cluster_name, 
                                                                  @contexts, 
                                                                  @cascade_to, 
                                                                  true, 
                                                                  *modules, 
                                                                  & block )

    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules, & block )
    
    @index = @parent_hook_controller.extend_and_include_at_index( @index, 
                                                                  @cluster_name, 
                                                                  @contexts, 
                                                                  @cascade_to, 
                                                                  true, 
                                                                  *modules, 
                                                                  & block )

    return self
    
  end
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    @index = @parent_hook_controller.action_at_index( @index, @cluster_name, @contexts, @cascade_to, true, & block )
    
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
  def reset_state
    
    @cluster_name = nil
    @index = -1

    @contexts.clear
    @cascade_to.clear
    
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
  def index( index )
    
    @index = index
    
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
    
    @contexts.concat( contexts ).uniq!
    
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
  attr_reader :contexts
  
end
