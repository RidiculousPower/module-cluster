
###
# @private
#
# Controls event hook stacks for a given Module or Class instance.
#   Holds controllers for before/after include and extend and for after subclass events. 
#   Controllers hold action stacks, which include/extend modules, perform block actions, 
#   or cascade actions to an inheriting instance.
#
class ::Module::Cluster::InstanceController
  
  ################
  #  initialize  #
  ################
  
  ###
  # @param [Module,Class] instance
  #
  #        Instance for which Instance Controller is to operate.
  #
  def initialize( instance )
    
    @instance = instance
    @clusters = { }
    
  end

  ##############
  #  instance  #
  ##############
  
  ###
  # Get reference to object instance for which Instance Controller (self) is operative.
  #
  # @!attribute [reader] [Module,Class] 
  #
  #             Instance for which this Instance Controller operates.
  #
  attr_reader :instance
  
  #############
  #  cluster  #
  #############
  
  ###
  # Return cluster for instance or create if necessary
  #
  # @param [Module,Class] instance
  #
  #        Instance for which cluster is being created.
  #
  # @param [Symbol,String] name
  # 
  #        Name of cluster for instance.
  #
  # @return [ModuleCluster::Cluster::Cluster] 
  #
  #         Cluster instance.
  #
  def cluster( name )

    unless cluster_instance = @clusters[ name = name.to_sym ]
      @clusters[ name ] = cluster_instance = ::Module::Cluster::Cluster.new( @instance, name )
    end
    
    return cluster_instance
    
  end

  ##################
  #  has_cluster?  #
  ##################
  
  ###
  # Query whether cluster exists for instance.
  #
  # @param [Module,Class] instance 
  #
  #        Instance for which cluster is being queried.
  #
  # @param name 
  #
  #        Name of cluster for instance.
  #
  # @return [true,false] 
  #
  #         Whether cluster exists for instance.
  #
  def has_cluster?( name )
    
    return @clusters.has_key?( name.to_sym )
    
  end

  ###########
  #  stack  #
  ###########
  
  ###
  # Get stack for event context.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is occurring.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds event hook frames.
  #
  def stack( event_context )
    
    stack = nil
    
    case event_context
      when :before_include
        stack = before_include_stack
      when :after_include
        stack = after_include_stack
      when :before_extend
        stack = before_extend_stack
      when :after_extend
        stack = after_extend_stack
      when :subclass
        stack = subclass_stack
    end
    
    return stack
    
  end
  
  ####################
  #  subclass_stack  #
  ####################
  
  ###
  # Get subclass event hook stack.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds subclass event hook frames.
  #
  def subclass_stack

    return @subclass_stack ||= ::Module::Cluster::InstanceController::Stack.new

  end
  
  ##########################
  #  before_include_stack  #
  ##########################
  
  ###
  # Get before-include event hook stack.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds before-include event hook frames.
  #
  def before_include_stack

    return @before_include_stack ||= ::Module::Cluster::InstanceController::Stack.new

  end

  #########################
  #  before_extend_stack  #
  #########################

  ###
  # Get before-extend event hook stack.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds before-extend event hook frames.
  #
  def before_extend_stack

    return @before_extend_stack ||= ::Module::Cluster::InstanceController::Stack.new

  end

  #########################
  #  after_include_stack  #
  #########################
  
  ###
  # Get after-include event hook stack.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds after-include event hook frames.
  #
  def after_include_stack

    return @after_include_stack ||= ::Module::Cluster::InstanceController::Stack.new

  end

  ########################
  #  after_extend_stack  #
  ########################

  ###
  # Get after-extend event hook stack.
  #
  # @return [Module::Cluster::InstanceController::Stack]
  #
  #         Stack that holds after-extend event hook frames.
  #
  def after_extend_stack

    return @after_extend_stack ||= ::Module::Cluster::InstanceController::Stack.new

  end

  #########################
  #  has_subclass_stack?  #
  #########################
  
  ###
  # Query whether subclass hook stack exists.
  #
  # @return [true,false] 
  #
  #         Whether subclass hook stack exists.
  #
  def has_subclass_stack?

    return @subclass_stack ? true : false

  end
  
  ###############################
  #  has_before_include_stack?  #
  ###############################
  
  ###
  # Query whether before-include hook stack exists.
  #
  # @return [true,false] 
  #
  #         Whether before-include hook stack exists.
  #
  def has_before_include_stack?

    return @before_include_stack ? true : false

  end

  ##############################
  #  has_before_extend_stack?  #
  ##############################

  ###
  # Query whether before-extend hook stack exists.
  #
  # @return [true,false] 
  #
  #         Whether before-extend hook stack exists.
  #
  def has_before_extend_stack?

    return @before_extend_stack ? true : false

  end

  ##############################
  #  has_after_include_stack?  #
  ##############################
  
  ###
  # Query whether after-include hook stack exists.
  #
  # @return [true,false] 
  #
  #         Whether after-include hook stack exists.
  #
  def has_after_include_stack?

    return @after_include_stack ? true : false

  end

  #############################
  #  has_after_extend_stack?  #
  #############################

  ###
  # Query whether after-extend hook stack exists.
  #
  # @return [true,false] 
  #
  #         Whether after-extend hook stack exists.
  #
  def has_after_extend_stack?

    return @after_extend_stack ? true : false

  end
    
end
