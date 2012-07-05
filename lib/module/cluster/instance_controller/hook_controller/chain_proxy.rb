
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
    @cascades_to = [ ]
    
    @index = -1
    
  end

  #############
  #  include  #
  #############

  def include( *modules, & block )
    
    @parent_hook_controller.include_at_index( @index, @cluster_name, @contexts, @cascades_to, true, *modules, & block )

    return self
    
  end

  ############
  #  extend  #
  ############

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
  
  def action( & block )
    
    @index = @parent_hook_controller.action_at_index( @index, @cluster_name, @contexts, @cascades_to, true, & block )
    
    return self
    
  end

  ################
  #  cascade     #
  #  cascade_to  #
  ################
  
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
  
  def before_extend( *modules )
    
    @index = parent_hook_controller.lowest_index( :extend, *modules )
    
    return self
    
  end

  ####################
  #  before_include  #
  ####################
  
  def before_include( *modules )
    
    @index = parent_hook_controller.lowest_index( :include, *modules )
    
    return self
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  def before_include_or_extend( *modules )

    @index = parent_hook_controller.lowest_index( :include_or_extend, *modules )
    
    return self
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  def after_include( *modules )

    @index = parent_hook_controller.highest_index( :include, *modules ) + 1
    
    return self
    
  end

  ##################
  #  after_extend  #
  ##################
  
  def after_extend( *modules )

    @index = parent_hook_controller.highest_index( :extend, *modules ) + 1
    
    return self
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
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

  ##############
  #  contexts  #
  ##############
  
  ###
  # @private
  #
  # Contexts (nil, :module, :class, :subclass, :instance) for which this instance is operative as a chain proxy.
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
  attr_reader :cascades_to
  
end
