
###
# @private
#
# Singleton methods for Module::Cluster, used internally to control 
#   cluster event definitions and hook execution.
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
  def enable_with_module_cluster( hooked_instance )
    
    case hooked_instance
      when ::Class
        hooked_instance.extend( ::Module::Cluster::ClassSupport )
        # if our class is a subclass of Module then its instances need ModuleSupport
        if hooked_instance < ::Module and not hooked_instance < ::Class
          hooked_instance.module_eval do
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
  # @param instance [Module,Class]
  #
  #        Instance for which cluster is defined.
  #
  # @param hooked_instance [Module,Class,Object]
  #
  #        Instance inheriting clusters.
  #
  # @return [true,false]
  #
  #         Whether hooked instance should be enabled with module cluster.
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
  # @param clustered_instance 
  #
  #        Module cluster enabled instance for which hooks are being activated.
  #
  # @param hooked_instance 
  #
  #        Inheriting instance for which events are being processed.
  #
  # @param event_context [:before_include,:after_include,:before_extend,:after_extend,:subclass]
  #
  #        Context for which cascade is occurring.
  #
  # @param stack [Array<Module::Cluster::Cluster::Frame>]
  #
  #        Stack of frames describing hooks to be evaluated.
  #
  def evaluate_cluster_stack( hooked_instance, clustered_instance, event_context )
    
    should_enable = false
    
    instance_controller = instance_controller( clustered_instance )
    instance_controller.stack( event_context ).each do |this_frame|
      next if instance_controller.cluster( this_frame.cluster_name ).disabled?
      cascades = evaluate_frame_cascade( this_frame, hooked_instance, clustered_instance, event_context )
      should_enable ||= cascades
      evaluate_frame_hook( this_frame, hooked_instance, clustered_instance, event_context )      
    end
    
    if should_enable
      enable_with_module_cluster( hooked_instance )
    end
    
    return self
    
  end

  ############################
  #  evaluate_frame_cascade  #
  ############################

  def evaluate_frame_cascade( frame, hooked_instance, clustered_instance, event_context )
    
    cascades = false
    
    if frame_should_cascade?( frame, hooked_instance, event_context )
      execute_frame_cascade( frame, hooked_instance, event_context )
      cascades = true
    end
    
    return cascades
    
  end

  ###########################
  #  frame_should_cascade?  #
  ###########################
  
  def frame_should_cascade?( frame, hooked_instance, event_context )
    
    should_cascade = false
    
    if ::Module === hooked_instance and
       cascade_contexts = frame.cascade_contexts
            
      if cascade_contexts.include?( :any )

        should_cascade = true

      else

        case hooked_instance
          when ::Class
            if event_context == :subclass
              should_cascade = cascade_contexts.include?( :subclass )
            else
              should_cascade = cascade_contexts.include?( :class )
            end
          when ::Module
            should_cascade = cascade_contexts.include?( :module ) || cascade_contexts.include?( :subclass )
        end
    
      end
      
    end
    
    return should_cascade
    
  end
  
  ###########################
  #  execute_frame_cascade  #
  ###########################
  
  def execute_frame_cascade( frame, hooked_instance, event_context )
    
    instance_controller( hooked_instance ).stack( event_context ).push( frame )
    
    return self

  end

  #########################
  #  evaluate_frame_hook  #
  #########################

  def evaluate_frame_hook( frame, hooked_instance, clustered_instance, event_context )
    
    executes = false
    
    if frame_should_execute?( frame, hooked_instance, event_context )
      execute_frame_hook( frame, hooked_instance, clustered_instance )
      executes = true
    end

    return executes
    
  end

  ###########################
  #  frame_should_execute?  #
  ###########################
  
  def frame_should_execute?( frame, hooked_instance, event_context )
    
    should_execute = false
    
    instance_contexts = frame.instance_contexts
    
    unless should_execute = instance_contexts.nil? || 
           instance_contexts.include?( :any )      ||
           instance_contexts.empty?

      case hooked_instance
        when ::Class
          if event_context == :subclass
            should_execute = instance_contexts.include?( :subclass )
          else
            should_execute = instance_contexts.include?( :class )
          end
        when ::Module
          should_execute = instance_contexts.include?( :module )
        else
          should_execute = instance_contexts.include?( :instance )
      end
      
    end
    
    return should_execute
    
  end

  ########################
  #  execute_frame_hook  # 
  ########################
  
  def execute_frame_hook( frame, hooked_instance, clustered_instance )
    
    # if we have a module to include/extend
    if modules = frame.modules and ! modules.empty?
      case frame.include_or_extend
        when :include
          hooked_instance.module_eval { include( *modules ) }
        when :extend
          hooked_instance.extend( *modules )
        when :include_and_extend
          hooked_instance.module_eval { include( *modules ) }
          hooked_instance.extend( *modules )
        when :extend_and_include
          hooked_instance.extend( *modules )
          hooked_instance.module_eval { include( *modules ) }
      end
    end
    
    if block_instance = frame.block_action
      clustered_instance.module_exec( hooked_instance, frame.cluster_owner, & block_instance )
    end
    
    return self
    
  end
  
end
