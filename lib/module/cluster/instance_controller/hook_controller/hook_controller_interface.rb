
###
# Interface implementation for {::Module::Cluster::InstanceController::HookController 
#   Module::Cluster::InstanceController::HookController}. 
#   Implementation provided separately for ease of overloading.
#
module ::Module::Cluster::InstanceController::HookController::HookControllerInterface
  
  FrameStruct = ::Struct.new( :owner, :cluster, :context, :cascades, :block, :module, :action )
  
  ################
  #  initialize  #
  ################
  
  def initialize( name, parent_instance_controller )
    
    @name = name
    
    @parent_instance_controller = parent_instance_controller
        
    @instance = @parent_instance_controller.instance
    
    @stack = [ ]
    
    @extend_modules = { }
    @include_modules = { }
    
  end

  ###########
  #  stack  #
  ###########
  
  attr_reader :stack
  
  ##########
  #  name  #
  ##########
  
  attr_reader :name

  #############
  #  include  #
  #############

  def include( *modules, & block )
    
    include_at_index( -1, nil, nil, nil, false, *modules, & block )

    return self
    
  end
  
  ############
  #  extend  #
  ############

  def extend( *modules, & block )

    extend_at_index( -1, nil, nil, nil, false, *modules, & block )

    return self
    
  end

  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules, & block )
    
    modules.each do |this_module|
      include( this_module, & block )
      extend( this_module, & block )
    end
    
    return self
    
  end

  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules, & block )
    
    modules.each do |this_module|
      extend( this_module, & block )
      include( this_module, & block )
    end
    
    return self
    
  end
  
  ############
  #  action  #
  ############
  
  def action( & block )
    
    action_at_index( -1, nil, nil, nil, false, & block )
    
    return self
    
  end

  ###################
  #  before_extend  #
  ###################
  
  def before_extend( *modules, & block )
    
    before_module_index = lowest_index( :extend, *modules )
    
    proxy = chain_proxy
    
    proxy.index( before_module_index )
    
    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end

  ####################
  #  before_include  #
  ####################
  
  def before_include( *modules, & block )
    
    before_module_index = lowest_index( :include, *modules )
    
    proxy = chain_proxy
    
    proxy.index( before_module_index )

    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  def before_include_or_extend( *modules, & block )

    before_module_index = lowest_index( :include_or_extend, *modules )

    proxy = chain_proxy

    proxy.index( before_module_index )

    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  def after_include( *modules, & block )

    after_module_index = highest_index( :include, *modules ) + 1

    proxy = chain_proxy

    proxy.index( after_module_index )
    
    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end

  ##################
  #  after_extend  #
  ##################
  
  def after_extend( *modules, & block )

    after_module_index = highest_index( :extend, *modules ) + 1
    
    proxy = chain_proxy
    
    proxy.index( after_module_index )
    
    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  def after_include_or_extend( *modules, & block )
    
    after_module_index = highest_index( :include_or_extend, *modules ) + 1
    
    proxy = chain_proxy
    
    proxy.index( after_module_index )
    
    if block_given?
      proxy.action( & block )
    end
    
    return proxy
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ################################
  #  parent_instance_controller  #
  ################################
  
  ###
  # @private
  #
  # @!attribute [reader] Reference to instance controller for which this hook controller operates.
  #
  # @return [::Module::Cluster::InstanceController]
  #
  attr_reader :parent_instance_controller

  ######################
  #  include_at_index  #
  ######################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def include_at_index( index, cluster_name, contexts, cascade_to, explicit_set = false, *modules, & block )
    
    modules.each do |this_module|
      
      should_insert = true
      
      if @include_modules.has_key?( this_module )

        if explicit_set
          # if we have an existing index, insert at this one instead
          existing_index = @stack.index { |this_frame | this_frame.action == :include and 
                                                        this_frame.module == this_module }
          @stack.delete_at( existing_index )
          if existing_index < index
            index -= 1
          end
        else
          should_insert = false
        end

      end
      
      if should_insert
        this_stack_frame = self.class::FrameStruct.new( @instance, 
                                                        cluster_name, 
                                                        contexts ? contexts.empty? ? nil : contexts.dup : nil, 
                                                        cascade_to ? cascade_to.empty? ? nil : cascade_to.dup : nil, 
                                                        block, 
                                                        this_module, 
                                                        :include )
        @stack.insert( index, this_stack_frame )
        unless index < 0
          index += 1
        end
        @include_modules[ this_module ] = true
      end
      
    end
    
    return index
    
  end

  #####################
  #  extend_at_index  #
  #####################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def extend_at_index( index, cluster_name, contexts, cascade_to, explicit_set = false, *modules, & block )

    modules.each do |this_module|
      
      should_insert = true
      
      if @extend_modules.has_key?( this_module )

        if explicit_set
          # if we have an existing index, insert at this one instead
          existing_index = @stack.index { |this_frame | this_frame.action == :extend and 
                                                        this_frame.module == this_module }
          @stack.delete_at( existing_index )
          if index > 0 and existing_index < index
            index -= 1
          end
        else
          should_insert = false
        end

      end
      
      if should_insert
        this_stack_frame = self.class::FrameStruct.new( @instance, 
                                                        cluster_name, 
                                                        contexts ? contexts.empty? ? nil : contexts.dup : nil, 
                                                        cascade_to ? cascade_to.empty? ? nil : cascade_to.dup : nil, 
                                                        block, 
                                                        this_module, 
                                                        :extend )
        @stack.insert( index, this_stack_frame )
        unless index < 0
          index += 1
        end
        @extend_modules[ this_module ] = true
      end

    end
    
    return index
    
  end
  
  #################################
  #  include_and_extend_at_index  #
  #################################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def include_and_extend_at_index( index, cluster_name, contexts, cascade_to, explicit_set = false, *modules, & block )
    
    modules.each do |this_module|
      index = include_at_index( index, cluster_name, contexts, cascade_to, explicit_set, this_module, & block )
      index = extend_at_index( index, cluster_name, contexts, cascade_to, explicit_set, this_module, & block )
    end
    
    return index
    
  end

  #################################
  #  extend_and_include_at_index  #
  #################################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def extend_and_include_at_index( index, cluster_name, contexts, cascade_to, explicit_set = false, *modules, & block )
    
    modules.each do |this_module|
      extend_at_index( index, cluster_name, contexts, cascade_to, explicit_set, this_module, & block )
      include_at_index( index, cluster_name, contexts, cascade_to, explicit_set, this_module, & block )
    end
    
    return self
    
  end

  #####################
  #  action_at_index  #
  #####################
  
  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def action_at_index( index, cluster_name, contexts, cascade_to, explicit_set = false, & block )
    
    new_frame = self.class::FrameStruct.new( @instance, cluster_name, contexts, cascade_to, block )
    
    @stack.insert( index, new_frame )
    
    unless index < 0
      index += 1
    end
    
    return index
    
  end
  
  #################
  #  chain_proxy  #
  #################
  
  def chain_proxy

    @chain_proxy ||= self.class::ChainProxy.new( self )
    
    return @chain_proxy.reset_state
    
  end
  
  ######################################################################################################################
      private ##########################################################################################################
  ######################################################################################################################
  
  ##################
  #  lowest_index  #
  ##################
  
  def lowest_index( include_or_extend, *modules )
    
    return indexes( include_or_extend, *modules )[ 0 ]
    
  end

  ###################
  #  highest_index  #
  ###################
  
  def highest_index( include_or_extend, *modules )

    return indexes( include_or_extend, *modules )[ -1 ]
    
  end

  #############
  #  indexes  #
  #############
  
  def indexes( include_or_extend, *modules )

    indexes = [ ]
    
    proc = nil
        
    modules.each do |this_module|
      
      case include_or_extend
        when :include
          
          this_index = @stack.index do |this_stack_frame| 
            this_stack_frame.action == :include and 
            this_stack_frame.module == this_module
          end
          
        when :extend
          this_index = @stack.index do |this_stack_frame| 
            this_stack_frame.action == :extend and 
            this_stack_frame.module == this_module
          end
        when :include_or_extend
          matched_action = nil
          this_index = @stack.index do |this_stack_frame| 
            if this_stack_frame.action == :extend || this_stack_frame.action == :include and 
               this_stack_frame.module == this_module
              matched_action = this_stack_frame.action
              true
            end
          end
          if this_index
            match_action = nil
            case matched_action
              when :include
                match_action = :extend
              when :extend
                match_action = :include
            end
            # if we matched include or extend look for the other one from the other side
            second_index = @stack.rindex do |this_stack_frame|
              this_stack_frame.action == match_action and
              this_stack_frame.module == this_module
            end
            if second_index and second_index != this_index
              indexes.push( this_index )
              this_index = second_index
            end
          end
      end
                
      unless this_index
        raise ::Module::Cluster::Exception::ModuleNotInStack.new( self, this_module ) 
      end

      indexes.push( this_index )

    end

    return indexes.sort
    
  end
  
end
