
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
    
    unless cluster_instance = instance_hash[ name ]
      instance_hash[ name ] = cluster_instance = ::Module::Cluster::Cluster.new( instance, name )
    end
    
    return cluster_instance
    
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

    requires_module_cluster_enable = false
    
    # Subclass hooks always cascade to the first subclass.
    # If it should casade for each subclass that has to be declared explicitly and will be handled below.
    unless event_context == :subclass
      instance_controller = instance_controller( instance )
      if instance_controller.instance_variable_defined?( :@subclass_controller )
        hooked_instance_controller = instance_controller( hooked_instance )
        hooked_instance_controller.subclass_controller.stack.concat( instance_controller.subclass_controller.stack )
        requires_module_cluster_enable = true
      end
    end

    hook_controller_for_context( instance, event_context ).stack.each do |this_frame|

      cascade_controller = event_context

      # test to see if this frame's cluster is disabled
      unless cluster( instance, this_frame.cluster ).disabled?
         
        should_cascade = false
        should_perform_action = nil
         
        # if we cascade we do that first - test to see if we should cascade into instance
        if cascade_context = this_frame.cascades

          if cascade_context.include?( :any )

            should_cascade = true
            should_perform_action = true
            
            case hooked_instance
              when ::Class
                cascade_controller = :subclass
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
                    cascade_controller = :subclass
                  elsif has_class
                    should_cascade = true
                    should_perform_action = true
                  elsif has_subclass
                    should_cascade = true
                    should_perform_action = false
                    cascade_controller = :subclass
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
            requires_module_cluster_enable = true
            hook_controller_for_context( hooked_instance, cascade_controller ).stack.push( this_frame )
          end

        end
        
        if cascade_context
          
          # already handled
        
        elsif match_context = this_frame.context

          # if we have a context we test against instance to see if we match, then we perform action
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
          
        else

          # if we are supposed to cascade (and have no context) then we perform action
          # if we don't have a context then we perform action
          should_perform_action = true

        end

        if should_perform_action

          # if we have a module to include/extend
          if this_module = this_frame.module
            case this_action = this_frame.action
              when :include
                hooked_instance.module_eval do
                  include this_module
                end
              when :extend
                hooked_instance.extend( this_module )
            end
          end
      
          # if we have a block it runs last
          if this_block = this_frame.block
            this_block.call( hooked_instance )
          end

        end

      end

    end
    
    if requires_module_cluster_enable
      
      case hooked_instance
        when ::Class
          hooked_instance.extend( ::Module::Cluster::ClassSupport )
        when ::Module
          hooked_instance.extend( ::Module::Cluster::ModuleSupport )
      end
      
    end
    
  end

end
