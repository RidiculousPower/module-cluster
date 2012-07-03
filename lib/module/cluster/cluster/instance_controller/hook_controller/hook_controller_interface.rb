
###
# Interface implementation for {::Module::Cluster::Cluster::InstanceController::HookController 
#   Module::Cluster::Cluster::InstanceController::HookController}. 
#   Implementation provided separately for ease of overloading.
#
module ::Module::Cluster::Cluster::InstanceController::HookController::HookControllerInterface
  
  FrameStruct = ::Struct.new( :owner, :cascades, :block, :module, :action )
  
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

  ################################
  #  parent_instance_controller  #
  ################################
  
  attr_reader :parent_instance_controller

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

  def include( *modules )
    
    include_at_index( -1, false, *modules )

    return self
    
  end

  #############
  #  include  #
  #############

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def include_at_index( index, explicit_set = false, *modules )
    
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
        this_stack_frame = self.class::FrameStruct.new( @instance, nil, nil, this_module, :include )
        @stack.insert( index, this_stack_frame )
        unless index < 0
          index += 1
        end
        @include_modules[ this_module ] = true
      end
      
    end
    
    return index
    
  end
  
  ############
  #  extend  #
  ############

  def extend( *modules )

    extend_at_index( -1, false, *modules )

    return self
    
  end

  #####################
  #  extend_at_index  #
  #####################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def extend_at_index( index, explicit_set = false, *modules )
    
    modules.each do |this_module|
      
      should_insert = true
      
      if @extend_modules.has_key?( this_module )

        if explicit_set
          # if we have an existing index, insert at this one instead
          existing_index = @stack.index { |this_frame | this_frame.action == :extend and 
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
        this_stack_frame = self.class::FrameStruct.new( @instance, nil, nil, this_module, :extend )
        @stack.insert( index, this_stack_frame )
        unless index < 0
          index += 1
        end
        @extend_modules[ this_module ] = true
      end

    end
    
    return index
    
  end
  
  ########################
  #  include_and_extend  #
  ########################

  def include_and_extend( *modules )
    
    modules.each do |this_module|
      include( this_module )
      extend( this_module )
    end
    
    return self
    
  end

  #################################
  #  include_and_extend_at_index  #
  #################################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def include_and_extend_at_index( index, explicit_set = false, *modules )
    
    modules.each do |this_module|
      index = include_at_index( index, explicit_set, this_module )
      index = extend_at_index( index, explicit_set, this_module )
    end
    
    return index
    
  end

  ########################
  #  extend_and_include  #
  ########################

  def extend_and_include( *modules )
    
    modules.each do |this_module|
      extend( this_module )
      include( this_module )
    end
    
    return self
    
  end
  
  #################################
  #  extend_and_include_at_index  #
  #################################

  ###
  # @private
  #
  # Used by ChainProxy to insert modules before/after other modules.
  #
  def extend_and_include_at_index( index, explicit_set = false, *modules )
    
    modules.each do |this_module|
      extend_at_index( index, explicit_set, this_module )
      include_at_index( index, explicit_set, this_module )
    end
    
    return self
    
  end

  ############
  #  action  #
  ############
  
  def action( & block )
    
    action_at_index( -1, false, & block )
    
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
  def action_at_index( index, explicit_set = false, & block )
    
    new_frame = self.class::FrameStruct.new( @instance, nil, block )
    
    @stack.insert( index, new_frame )
    
    unless index < 0
      index += 1
    end
    
    return index
    
  end
  
  ###################
  #  before_extend  #
  ###################
  
  def before_extend( *modules )
    
    before_module_index = lowest_index( :extend, *modules )
    
    return chain_proxy.index( before_module_index )
    
  end

  ####################
  #  before_include  #
  ####################
  
  def before_include( *modules )
    
    before_module_index = lowest_index( :include, *modules )
    
    return chain_proxy.index( before_module_index )
    
  end

  ##############################
  #  before_include_or_extend  #
  #  before_extend_or_include  #
  ##############################
  
  def before_include_or_extend( *modules )

    before_module_index = lowest_index( :include_or_extend, *modules )

    return chain_proxy.index( before_module_index )
    
  end
  
  alias_method :before_extend_or_include, :before_include_or_extend
  
  ###################
  #  after_include  #
  ###################
  
  def after_include( *modules )

    after_module_index = highest_index( :include, *modules ) + 1

    return chain_proxy.index( after_module_index )
    
  end

  ##################
  #  after_extend  #
  ##################
  
  def after_extend( *modules )

    after_module_index = highest_index( :extend, *modules ) + 1

    return chain_proxy.index( after_module_index )
    
  end

  #############################
  #  after_include_or_extend  #
  #  after_extend_or_include  #
  #############################
  
  def after_include_or_extend( *modules )
    
    after_module_index = highest_index( :include_or_extend, *modules ) + 1
    
    return chain_proxy.index( after_module_index )
    
  end

  alias_method :after_extend_or_include, :after_include_or_extend

  #################
  #  chain_proxy  #
  #################
  
  def chain_proxy

    return @chain_proxy ||= self.class::ChainProxy.new( self )
    
  end
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################
  
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
