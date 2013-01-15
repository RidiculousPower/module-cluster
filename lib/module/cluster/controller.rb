
###
# @private
#
# Singleton methods for Module::Cluster, used internally to control cluster event definitions 
#   and hook execution.
#
module ::Module::Cluster::Controller

  ###################
  #  self.extended  #
  ###################
  
  ###
  # Ensure that initialization occurs when used to enable an instance as a Module::Cluster controller.
  #
  # @param instance [Object]
  #
  #        Instance to be enabled as Module::Cluster controller.
  #
  def self.extended( instance )
    
    instance.instance_eval do
      @instances = { }
      @already_included = { }
      @already_extended = { }
    end
    
  end
  
  #########################
  #  instance_controller  #
  #########################

  ###
  # Get instance controller for instance. Creates instance controller if necessary.
  #
  # @param instance [Module,Class]
  #
  #        Instance for which instance controller is being created.
  #
  # @return [ModuleCluster::Cluster::InstanceController] 
  #
  #         Instance Controller instance.
  #
  def instance_controller( instance )

    unless instance_controller = @instances[ instance ]

      @instances[ instance ] = instance_controller = ::Module::Cluster::InstanceController.new( instance )

      # If instance is a module instance of a class that inherits from module then instance
      # needs to inherit stacks defined in its class.
      case instance
        when ::Module
          instance_class = instance.class
          if instance_class < ::Module and not instance_class < ::Class
            cascade_include_extend_stacks( instance, instance_class )
          end
      end

    end
    
    return instance_controller
    
  end
  
  ################################
  #  enable_with_module_cluster  #
  ################################
  
  ###
  # Enable hooked instance as a module cluster instance as appropriate.
  #   Used for cascading hooks to inheriting instance when inheriting instance 
  #   will also cause hooks to cascade to next hooked instance.
  #
  # @param hooked_instance [Module,Class,Object]
  #
  #        Instance inheriting clusters.
  # 
  # @return [::Module::Cluster::Controller] Self.
  #
  def enable_with_module_cluster( hooked_instance )
    
    case hooked_instance
      when ::Class
        hooked_instance.extend( ::Module::Cluster::ClassSupport )
        # if our class is a subclass of Module then its instances need ModuleSupport
        if hooked_instance < ::Module and not hooked_instance < ::Class
          hooked_instance.module_eval do
            include( ::Module::Cluster )
            include( ::Module::Cluster::ModuleSupport )
          end
        end
      when ::Module
        hooked_instance.extend( ::Module::Cluster::ModuleSupport )
    end    
    
    return self
    
  end

  ###################################
  #  cascade_include_extend_stacks  #
  ###################################
  
  ###
  # Cause instance to inherit frames in before/after include/extend stacks from another instance.
  # 
  # @param to_instance [Module,Class]
  #
  #        Instance that will inherit frames.
  #
  # @param from_instance [Module,Class]
  #
  #        Instance where frames already exist.
  # 
  # @return [::Module::Cluster::Controller] Self.
  #
  def cascade_include_extend_stacks( to_instance, from_instance )
    
    if from_instance_controller = @instances[ from_instance ]

      to_instance_controller = @instances[ to_instance ]

      if from_instance_controller.has_before_include_stack?
        to_instance_controller.before_include_stack.concat( from_instance_controller.before_include_stack )
      end

      if from_instance_controller.has_after_include_stack?
        to_instance_controller.after_include_stack.concat( from_instance_controller.after_include_stack )
      end

      if from_instance_controller.has_before_extend_stack?
        to_instance_controller.before_extend_stack.concat( from_instance_controller.before_extend_stack )
      end

      if from_instance_controller.has_after_extend_stack?
        to_instance_controller.after_extend_stack.concat( from_instance_controller.after_extend_stack )
      end

    end

    return self

  end
  
  ############################
  #  cascade_subclass_stack  #
  ############################
  
  ###
  # Cascade cluster hooks for instance into hooked instance (causing hooked instance to inherit the hooks).
  #
  # @param to_instance [Module,Class]
  #
  #        Instance that will inherit frames.
  #
  # @param from_instance [Module,Class,Object]
  #
  #        Instance where frames already exist.
  #
  # @return [::Module::Cluster::Controller] Self.
  #
  def cascade_subclass_stack( to_instance, from_instance )

    if from_instance_controller = @instances[ from_instance ] and 
       from_instance_controller.has_subclass_stack?
      
      to_instance_controller = @instances[ to_instance ]
      to_instance_controller.subclass_stack.concat( from_instance_controller.subclass_stack )
    
    end
    
    return self
    
  end
  
  ############################
  #  evaluate_cluster_stack  #
  ############################
  
  ###
  # Iterate provided stack of cluster frames, cascading and/or executing frames
  #   as appropriate.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is occurring.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being activated.
  #
  # @return [::Module::Cluster::Controller] Self.
  #
  def evaluate_cluster_stack( event_context, hooked_instance, clustered_instance )
    
    should_enable = false
    
    @already_included.clear
    @already_extended.clear
    
    instance_controller( clustered_instance ).stack( event_context ).each do |this_frame|

      if frame_should_evaluate?( this_frame, event_context, hooked_instance, clustered_instance )
        case should_cascade = frame_should_cascade?( this_frame, event_context, hooked_instance, clustered_instance )
          when nil
            execute_frame_hook( this_frame, hooked_instance, clustered_instance )
          when :execute_and_cascade
            should_enable = true
            execute_frame_hook( this_frame, hooked_instance, clustered_instance )
            execute_frame_cascade( this_frame, event_context, hooked_instance, clustered_instance )
          when :execute_and_cascade_block
            should_enable = true
            execute_frame_hook( this_frame, hooked_instance, clustered_instance )
            execute_frame_cascade( this_frame, event_context, hooked_instance, clustered_instance, true )
          when :cascade
            should_enable = true
            execute_frame_cascade( this_frame, event_context, hooked_instance, clustered_instance )
          when :cascade_block
            should_enable = true
            execute_frame_cascade( this_frame, event_context, hooked_instance, clustered_instance, true )
        end
      end
    end
    
    if should_enable
      enable_with_module_cluster( hooked_instance )
    end
    
    return self
    
  end
  
  ############################
  #  frame_should_evaluate?  #
  ############################
  
  ###
  # Query whether frame should evaluate cascade and execution.
  #
  # @param frame
  #
  #        Frame being evaluated.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is being evaluated.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being activated.
  #
  # @return [true,false]
  #
  #         Whether frame cascades.
  #
  def frame_should_evaluate?( frame, event_context, hooked_instance, clustered_instance )
    
    frame_should_evaluate = false
    
    unless instance_controller( clustered_instance ).cluster( frame.cluster_name ).disabled?

      if event_context == :subclass
        
        # subclass is never testing against execution context since it is a cascade hook
        # this means it always evaluates to determine cascade behavior
        frame_should_evaluate = true
        
      elsif execution_contexts = frame.execution_contexts
        
        if execution_contexts.include?( :any )
          
          frame_should_evaluate = true
        
        else
          
          case hooked_instance
            when ::Class
              frame_should_evaluate = true if execution_contexts.include?( :class )
            when ::Module
              frame_should_evaluate = true if execution_contexts.include?( :module )
            else
              frame_should_evaluate = true if execution_contexts.include?( :instance )
          end

        end
      
      else
        
        frame_should_evaluate = true

      end

    end
    
    return frame_should_evaluate
    
  end

  ###########################
  #  frame_should_cascade?  #
  ###########################
  
  ###
  # Evaluate whether frame should cascade into hooked instance.
  #
  # @param frame
  #
  #        Frame being evaluated.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is being evaluated.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being activated.
  #
  # @return [nil,false,:cascade,:execute_and_cascade,:execute_and_cascade_block]
  #
  #         Whether frame should cascade.
  #
  def frame_should_cascade?( frame, event_context, hooked_instance, clustered_instance )
    
    should_cascade = nil
    
    if cascade_contexts = frame.cascade_contexts

      should_cascade = false

      case clustered_instance
        when ::Class # Class => Class
          if cascade_contexts.include?( :each_subclass )
            should_cascade = :execute_and_cascade
          elsif cascade_contexts.include?( :any )  || 
                cascade_contexts.include?( :subclass )
            should_cascade = :execute_and_cascade_block
          end
        when ::Module # Module => Module, Module => Class
          case hooked_instance
            when ::Class
              if cascade_contexts.include?( :any )  ||
                 cascade_contexts.include?( :class )
                should_cascade = :execute_and_cascade_block
              elsif cascade_contexts.include?( :each_subclass )
                should_cascade = :cascade
              elsif cascade_contexts.include?( :subclass )
                should_cascade = :cascade
              end
            when ::Module
              if cascade_contexts.include?( :any )  || 
                 cascade_contexts.include?( :module )
                should_cascade = :execute_and_cascade
              elsif cascade_contexts.include?( :class )     ||
                    cascade_contexts.include?( :subclass )  ||
                    cascade_contexts.include?( :each_subclass )
                should_cascade = :cascade
              end
          end
      end

    end
       
    return should_cascade
    
  end
  
  ###########################
  #  execute_frame_cascade  #
  ###########################
  
  ###
  # Cascade frame into hooked instance.
  #
  # @param frame
  #
  #        Frame being evaluated.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is being evaluated.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being executed.
  #
  # @return [::Module::Cluster::Controller] Self.
  #
  def execute_frame_cascade( frame, event_context, hooked_instance, clustered_instance, block_only = false )
    
    cascade_frame = nil
    
    # if we only cascade block then we need a new frame
    if frame.cascade_contexts
      cascade_frame = frame.class.new( frame.cluster_owner,
                                       frame.cluster_name, 
                                       nil, 
                                       frame.cascade_contexts,
                                       block_only ? nil : frame.modules, 
                                       block_only ? nil : frame.include_or_extend,
                                       frame.block_action )
    else
      cascade_frame = frame
    end
    
    # put the cascading frame on the right stack
    case clustered_instance
      when ::Class  # Class => Class
        instance_controller( hooked_instance ).subclass_stack.push( cascade_frame )
      when ::Module 
        case hooked_instance
          when ::Class  # Module => Class
            instance_controller( hooked_instance ).subclass_stack.push( cascade_frame )
          when ::Module # Module => Module
            instance_controller( hooked_instance ).stack( event_context ).push( cascade_frame )
        end
    end
    
    return self

  end

  ########################
  #  execute_frame_hook  # 
  ########################
  
  ###
  # Execute frame for hooked instance.
  #
  # @param frame
  #
  #        Frame being executed.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being activated.
  #
  # @return [::Module::Cluster::Controller] Self.
  #
  def execute_frame_hook( frame, hooked_instance, clustered_instance )

    # if we have a module to include/extend
    if modules = frame.modules
      case frame.include_or_extend
        when :include
          case hooked_instance
            when ::Module
              execute_include_modules( hooked_instance, *modules )
          end
        when :extend
          execute_extend_modules( hooked_instance, *modules )
        when :include_and_extend
          execute_include_modules( hooked_instance, *modules )
          execute_extend_modules( hooked_instance, *modules )
        when :extend_and_include
          execute_extend_modules( hooked_instance, *modules )
          execute_include_modules( hooked_instance, *modules )
      end
    end

    if block_instance = frame.block_action
      clustered_instance.module_exec( hooked_instance, frame.cluster_owner, & block_instance )
    end
    
    return self
    
  end
  
  #############################
  #  execute_include_modules  #
  #############################
  
  ###
  # Include modules in hooked instance unless this stack evaluation has already done so.
  #
  # @overload execute_include_modules( hooked_instance, module, ... )
  #
  #   @param [Module,Class] hooked_instance
  #
  #          Instance that will includes modules.
  #
  #   @param [Module] module
  #
  #          Module to use for include.
  #
  # @return [Module::Controller::Controller] Self.
  #
  def execute_include_modules( hooked_instance, *modules )
    
    modules.delete_if do |this_module|
      already_included = false
      if @already_included[ this_module ]
        already_included = true
      else # mark for next frame
        @already_included[ this_module ] = true
      end
      already_included
    end
    
    hooked_instance.module_eval { include( *modules ) } unless modules.empty?

    return self
    
  end
  
  ############################
  #  execute_extend_modules  #
  ############################
  
  ###
  # Extend hooked instance with modules unless this stack evaluation has already done so.
  #
  # @overload execute_extend_modules( hooked_instance, module, ... )
  #
  #   @param [Module,Class] hooked_instance
  #
  #          Instance that will includes modules.
  #
  #   @param [Module] module
  #
  #          Module to use for extend.
  #
  # @return [Module::Controller::Controller] Self.
  #
  def execute_extend_modules( hooked_instance, *modules )

    modules.delete_if do |this_module|
      already_extended = false
      if @already_extended[ this_module ]
        already_extended = true
      else
        @already_extended[ this_module ] = true
      end
      already_extended
    end

    hooked_instance.extend( *modules ) unless modules.empty?

  end
  
  
end
34