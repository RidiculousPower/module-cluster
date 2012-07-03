
###
# An InstanceController uses an InstanceController::HookController::ChainProxy to chain commands
#   that rely on chained state.
#
class ::Module::Cluster::Cluster::InstanceController::HookController::ChainProxy
  
  ################
  #  initialize  #
  ################
  
  def initialize( parent_hook_controller )
    
    @parent_hook_controller = parent_hook_controller

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
  #  include  #
  #############

  def include( *modules )
    
    @parent_hook_controller.include_at_index( @index, true, *modules )

    return self
    
  end

  ############
  #  extend  #
  ############

  def extend( *modules )

    @index = @parent_hook_controller.extend_at_index( @index, true, *modules )

    return self

  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules )
    
    @index = @parent_hook_controller.include_and_extend_at_index( @index, true, *modules )

    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules )
    
    @index = @parent_hook_controller.extend_and_include_at_index( @index, true, *modules )

    return self
    
  end
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    @index = @parent_hook_controller.action_at_index( @index, true, *modules )
    
    return self
    
  end
  
end
