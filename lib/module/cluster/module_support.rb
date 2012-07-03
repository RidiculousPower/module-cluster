
module ::Module::Cluster::ModuleSupport

  #####################
  #  append_features  #
  #####################

  def append_features( instance )
    
    ::ModuleSupport.instance( self ).prepend_includes.each do |this_prepend_include_hook|
      
      case this_prepend_include_hook
        
        when ::ModuleSupport::ClusterStack::ModuleSet
        
        when ::ModuleSet::ClusterStack::BlockAction
        
      end
      
    end
    
  end

  ##############
  #  included  #
  ##############

  def included( instance )

    ::ModuleSupport.instance( self ).includes.each do |this_include_hook|
      
      case this_include_hook
        
        when ::ModuleSupport::ClusterStack::ModuleSet
        
        when ::ModuleSet::ClusterStack::BlockAction
        
      end
      
    end
    
  end

  ###################
  #  extend_object  #
  ###################
  
  def extend_object( instance )

    ::ModuleSupport.instance( self ).prepend_extends.each do |this_extend_hook|
      
      case this_extend_hook
        
        when ::ModuleSupport::ClusterStack::ModuleSet
        
        when ::ModuleSet::ClusterStack::BlockAction
        
      end
      
    end
    
  end

  ##############
  #  extended  #
  ##############
  
  def extended( instance )

    ::ModuleSupport.instance( self ).extends.each do |this_prepend_extend_hook|
      
      case this_prepend_extend_hook
        
        when ::ModuleSupport::ClusterStack::ModuleSet
        
        when ::ModuleSet::ClusterStack::BlockAction
        
      end
      
    end
    
  end

  ##############################################
  #  execute_module_cluster_event_hooks_stack  #
  #############################################
  
  def execute_module_cluster_event_hooks_stack( instance, event_hook_stack )
    
    event_hook_stack.each do |this_event_hook|
      
      case this_event_hook
        
        when ::ModuleSupport::ClusterStack::ModuleSet
        
          this_event_hook.contexts.each do |this_context|
            
            case this_context
              
              when :module
                case instance
                  when ::Class
                  when ::Module
                    execute_event_hook( instance, this_event_hook )
                end
              when :class
                case instance
                  when ::Module
                  when ::Class
                    execute_event_hook( instance, this_event_hook )
                end
              when :instance
                case instance
                  when ::Module
                  else
                    execute_event_hook( instance, this_event_hook )
                end
            end
            
          end
          
          case this_event_hook.action
            
            when :include
              instance.module_eval
            when :extend
            when :include_and_extend
            
          end

          instance.extend( *this_prepend_include_hook.modules )

        when ::ModuleSet::ClusterStack::BlockAction

          this_prepend_include_hook.call()
      
      end
      
    end
    
  end

end
