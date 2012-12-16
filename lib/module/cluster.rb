
# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

###
# Public interface to enable modules/classes with module-cluster capabilities.
#
module ::Module::Cluster

  @clusters = { }
  @instances = { }
  
  ###################
  #  self.extended  #
  ###################
  
  ###
  # Ensures that instance controller exists for extended instance 
  #   and enables class or module support as appropriate.
  #
  def self.extended( instance )
    
    case instance
      when ::Class
        instance.extend( ::Module::Cluster::ClassSupport )
        # if we have a subclass of ::Module we are a class that creates instances as modules
        if instance < ::Module
          instance.module_eval do
            include( ::Module::Cluster::ModuleSupport )
          end
        end
      when ::Module
        instance.extend( ::Module::Cluster::ModuleSupport )
    end
    
  end

  #############
  #  cluster  #
  #############
  
  ###
  # Get cluster for name. Will create cluster if it does not already exist.
  #
  # @param name Name of cluster.
  #
  def cluster( name )
    
    return ::Module::Cluster.cluster( self, name )
    
  end
  
  ##################
  #  has_cluster?  #
  ##################
  
  ###
  # Get cluster for name. Will create cluster if it does not already exist.
  #
  # @param name Name of cluster.
  #
  # @return [true,false] Whether cluster name exists for self.
  #
  def has_cluster?( name )
    
    return ::Module::Cluster.has_cluster?( self, name )
    
  end

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  ###
  # These methods are not actually in private space but are internal methods for inter-object
  # communications. They aren't intended for public interfacing.
  #

  ##################
  #  self.cluster  #
  ##################
  
  ###
  # @private
  #
  # Return cluster for instance or create if necessary
  #
  # @param instance 
  #          Instance for which cluster is being created.
  #
  # @param name 
  #          Name of cluster for instance.
  #
  # @return [ModuleCluster::Cluster::Cluster] Cluster instance.
  #
  def self.cluster( instance, name )

    unless instance_hash = @clusters[ instance ]
      @clusters[ instance ] = instance_hash = { }
    end
    
    name = name.to_sym
    
    unless cluster_instance = instance_hash[ name ]
      instance_hash[ name ] = cluster_instance = ::Module::Cluster::Cluster.new( instance, name )
    end
    
    return cluster_instance
    
  end

  #######################
  #  self.has_cluster?  #
  #######################
  
  ###
  # @private
  #
  # Return whether cluster exists for instance.
  #
  # @param instance 
  #          Instance for which cluster is being queried.
  #
  # @param name 
  #          Name of cluster for instance.
  #
  # @return [true,false] Whether cluster exists for instance.
  #
  def self.has_cluster?( instance, name )
    
    has_cluster = false
    
    if instance_hash = @clusters[ instance ]
      has_cluster = instance_hash.has_key?( name.to_sym )
    end
    
    return has_cluster
    
  end
  
  ##############################
  #  self.instance_controller  #
  ##############################

  ###
  # @private
  #
  # Return instance controller for instance or create if necessary
  #
  # @param instance 
  #          Instance for which instance controller is being created.
  #
  # @return [ModuleCluster::Cluster::InstanceController] Instance Controller instance.
  #
  def self.instance_controller( instance )
    
    unless instance_controller = @instances[ instance ]
      @instances[ instance ] = instance_controller = self::InstanceController.new( instance )
    end
    
    return instance_controller
    
  end
 
  ######################################
  #  self.hook_controller_for_context  #
  ######################################
  
  ###
  # @private
  #
  # Return instance controller for instance or create if necessary
  #
  # @param instance 
  #          Instance for which Hook Controller is being returned.
  #
  # @param event_context 
  #          Context for which event hooks are being processed.
  #
  # @return [ModuleCluster::Cluster::InstanceController::HookController] Hook Controller instance.
  #
  def self.hook_controller_for_context( instance, event_context )
    
    hook_stack = nil
    
    instance_controller = instance_controller( instance )
    
    case event_context
      
      when :before_include

        hook_stack = instance_controller.before_include_controller

      when :after_include

        hook_stack = instance_controller.after_include_controller

      when :before_extend

        hook_stack = instance_controller.before_extend_controller

      when :after_extend

        hook_stack = instance_controller.after_extend_controller

      when :subclass

        hook_stack = instance_controller.subclass_controller

    end
    
    return hook_stack
    
  end

  ##############################
  #  self.hook_cluster_events  #
  ##############################
  
  ###
  # @private
  #
  # Return instance controller for instance or create if necessary
  #
  # @param instance 
  #          Module cluster enabled instance for which hooks are being activated.
  #
  # @param hooked_instance 
  #          Iheriting instance for which events are being processed.
  #
  # @param event_context 
  #          Context for which event hooks are being processed.
  #
  # @return [ModuleCluster::Cluster::InstanceController::HookController] Hook Controller instance.
  #
  def self.hook_cluster_events( instance, hooked_instance, event_context )

    should_enable_with_module_cluster = cascade_hooks_to_instance( instance, hooked_instance, event_context )

    hook_controller_for_context( instance, event_context ).stack.each do |this_frame|

      # test to see if this frame's cluster is disabled
      unless cluster( instance, this_frame.cluster ).disabled?
         
        should_cascade = false
        should_perform_action = nil
         
        # if we cascade we do that first - test to see if we should cascade into instance
        if cascade_context = this_frame.cascades and ! cascade_context.empty?

          if cascade_context.include?( :any )

            should_cascade = true
            should_perform_action = true
            
            case hooked_instance
              when ::Class
                event_context = :subclass
            end

          else

            case hooked_instance
              when ::Class
                if event_context == :subclass
                  if cascade_context.include?( :subclass )
                    should_cascade = true
                    should_perform_action = true
                  end
                else
                  has_subclass = cascade_context.include?( :subclass )
                  has_class = cascade_context.include?( :class )
                  if has_class and has_subclass
                    should_cascade = true
                    should_perform_action = true
                    event_context = :subclass
                  elsif has_class
                    should_cascade = true
                    should_perform_action = true
                  elsif has_subclass
                    should_cascade = true
                    should_perform_action = false
                    event_context = :subclass
                  end
                end
              when ::Module
                if cascade_context.include?( :module )
                  should_cascade = true
                  should_perform_action = true
                elsif cascade_context.include?( :class ) or cascade_context.include?( :subclass )
                  should_cascade = true
                  should_perform_action = false
                end
            end

          end
          
          if should_cascade
            should_enable_with_module_cluster = true
            hook_controller_for_context( hooked_instance, event_context ).stack.push( this_frame )
          end

        elsif match_context = this_frame.context and ! match_context.empty?
          
          should_perform_action = perform_action_for_context?( hooked_instance, match_context, event_context )
        
        else
        
          # if we are supposed to cascade (and have no context) then we perform action
          # if we don't have a context then we perform action
          should_perform_action = true
        
        end

        if should_perform_action
          perform_action( instance, hooked_instance, this_frame )
        end

      end

    end
    
    if should_enable_with_module_cluster
      enable_with_module_cluster( hooked_instance )      
    end
    
  end
  
  ####################################
  #  self.cascade_hooks_to_instance  #
  ####################################
  
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
  # @param event_context [:all,:module,:class,:subclass,:instance]
  #
  #        Context for which cascade is occurring.
  #
  # @return [true,false]
  #
  #         Whether hooked instance should be enabled with module cluster.
  #
  def self.cascade_hooks_to_instance( instance, hooked_instance, event_context )
    
    should_enable_with_module_cluster = false
    
    # Subclass hooks always cascade to the first subclass.
    # If it should casade for each subclass that has to be declared explicitly and will be handled below.
    unless event_context == :subclass
      instance_controller = instance_controller( instance )
      if instance_controller.instance_variable_defined?( :@subclass_controller )
        hooked_instance_controller = instance_controller( hooked_instance )
        hooked_instance_controller.subclass_controller.stack.concat( instance_controller.subclass_controller.stack )
        should_enable_with_module_cluster = true
      end
    end
    
    return should_enable_with_module_cluster
    
  end

  #####################################
  #  self.enable_with_module_cluster  #
  #####################################
  
  ###
  # Enable hooked instance as a module cluster instance as appropriate.
  #   Used for cascading hooks to inheriting instance when inheriting instance 
  #   will also cause hooks to cascade to next hooked instance.
  #
  # @param hooked_instance [Module,Class,Object]
  #
  #        Instance inheriting clusters.
  # 
  def self.enable_with_module_cluster( hooked_instance )
    
    case hooked_instance
      when ::Class
        hooked_instance.extend( ::Module::Cluster::ClassSupport )
      when ::Module
        hooked_instance.extend( ::Module::Cluster::ModuleSupport )
    end    
    
  end

  #########################
  #  self.perform_action  #
  #########################
  
  ###
  # Perform appropriate hook action on hooked instance.
  # 
  # @param instance [Module,Class]
  #
  #        Instance for which cluster is defined.
  #
  # @param hooked_instance [Module,Class,Object]
  #
  #        Instance inheriting clusters.
  #
  # @param frame [Module::Cluster::InstanceController::HookController::HookControllerInterface::FrameStruct]
  #
  #        Frame struct describing hook details.
  #
  def self.perform_action( instance, hooked_instance, frame )
    
    # if we have a module to include/extend
    if module_instance = frame.module
      case frame.action
        when :include
          hooked_instance.module_eval do
            include module_instance
          end
        when :extend
          hooked_instance.extend( module_instance )
      end
    end

    # if we have a block it runs last
    if block_instance = frame.block
      instance.module_exec( hooked_instance, frame.owner, & block_instance )
    end
    
  end
  
  ######################################
  #  self.perform_action_for_context?  #
  ######################################
  
  ###
  # Query whether action should be performed for context.
  #
  # @param hooked_instance [Module,Class,Object]
  #
  #        Instance inheriting clusters.
  #
  # @param match_context [:all,:module,:class,:subclass,:instance]
  #
  #        Context for which cascade should occur.
  #
  # @param event_context [:all,:module,:class,:subclass,:instance]
  #
  #        Context where hook is occurring.
  #
  # @return [true,false]
  #
  #         Whether action should be performed for context.
  #
  def self.perform_action_for_context?( hooked_instance, match_context, event_context )

    case hooked_instance
      when ::Class
        if event_context == :subclass
          if match_context.include?( :subclass )
            should_perform_action = true
          end
        else
          if match_context.include?( :class )
            should_perform_action = true
          end
        end
      when ::Module
        if match_context.include?( :module )
          should_perform_action = true
        end
      else
        if match_context.include?( :instance )
          should_perform_action = true
        end
    end
    
    return should_perform_action
    
  end
  
end
