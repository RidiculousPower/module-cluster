
module ::ModuleCluster::CascadeFeatures::PerformCascades

  ######################
  #  perform_cascades  #
  ######################
  
  def perform_cascades( module_self, action, hooked_instance, set_stack )

    # This method is called when a ::ModuleCluster module is included or extended.
    # It determines what modules should be included/extended and which should cascade.

    unless module_self.hooks_suspended?( action )
      
      # for each set:
      set_stack.each do |this_set|
        
        # if this particular set is suspended, skip to the next
        next if this_set.suspended
        
        # Block sets simply run a block at a hook. 
        # They do not include or extend returns from the block.
        # The hooked module will not be extended by ::ModuleCluster.
        if this_set.is_a?( ::ModuleCluster::ClusterStack::Block::Set )

          # if our blocks are set to cascade then we need to copy inherit hooks
          if this_set.dependency_module.should_cascade?( hooked_instance )
            cascade_block_into_hooked_instance( module_self, action, hooked_instance, this_set )
          end
          
          if this_set.dependency_module.should_run_block?( hooked_instance )

            case this_set.runtime_block.arity
              when 0
                module_self.instance_eval( & this_set.runtime_block )
              else
                module_self.instance_exec( hooked_instance, & this_set.runtime_block )
            end

          end
        
        # Other sets take parameters and an optional block. The optional block returns are included
        # or extended like the parameters provided.
        else

          if should_cascade = this_set.dependency_module.should_cascade?( hooked_instance )
            # cascade parameter modules as appropriate
            cascade_modules_into_hooked_instance( module_self, 
                                                  hooked_instance, 
                                                  this_set, 
                                                  this_set.modules )
          end
        
          # dependency modules can cause instances to be included/extended and/or cascade
          should_include = this_set.dependency_module.should_include_or_extend?( hooked_instance )

          # include/extend parameter modules as appropriate
          if should_include
            include_extend_modules( module_self, hooked_instance, this_set, this_set.modules )        
          end
          
          # process runtime block if present
          if this_set.runtime_includes_or_extends_block
          
            # if we have a runtime block, run block and collect returns as appropriate
            if runtime_modules = collect_block_runtime_result_modules( module_self, 
                                                                       hooked_instance, 
                                                                       this_set )
        
              # cascade return modules if appropriate
              if should_cascade
                cascade_modules_into_hooked_instance( module_self, 
                                                      hooked_instance, 
                                                      this_set, 
                                                      runtime_modules )
              end
              
              # include/extend return modules if appropriate
              if should_include
                include_extend_modules( module_self, hooked_instance, this_set, runtime_modules )
              end
              
            end
          
          end
        
        end
      
      end
    
    end
       
  end

  ############################
  #  include_extend_modules  #
  ############################

  def include_extend_modules( module_self, hooked_instance, set, modules )

    # Collect include/extend modules from this set into our eventual include/extend order.
    case set.include_or_extend
      when :include_and_extend
        include_or_extend_hooked_instance( hooked_instance, set, true, true, modules )
      when :include
        include_or_extend_hooked_instance( hooked_instance, set, true, false, modules )
      when :extend
        include_or_extend_hooked_instance( hooked_instance, set, false, true, modules )
    end
    
  end

  ##########################################
  #  cascade_modules_into_hooked_instance  #
  ##########################################

  def cascade_modules_into_hooked_instance( module_self, hooked_instance, set, modules )

    # if we are supposed to cascade we need to extend with the ::ModuleCluster dependency module
    hooked_instance.extend( set.dependency_module )

    # and we call the set's definition method to cascade
    hooked_instance.__send__( set.method, *modules )

  end

  ########################################
  #  cascade_block_into_hooked_instance  #
  ########################################

  def cascade_block_into_hooked_instance( module_self, action, hooked_instance, set )
    
    hooked_instance.extend( set.dependency_module )
          
    if hooked_instance.is_a?( Class )
      
      if action == :inherited

        unless set.dependency_module == ::ModuleCluster::CascadeFeatures::Subclass
          hooked_instance.extend( ::ModuleCluster::CascadeFeatures::Subclass )
        end
        
        hooked_instance.subclass( & set.runtime_block )

      end
      
    else

      # and we call the set's definition method to cascade
      hooked_instance.__send__( set.method, & set.runtime_block )

    end
    
  end
  
  #######################################
  #  include_or_extend_hooked_instance  #
  ######################################
  
  def include_or_extend_hooked_instance( hooked_instance, 
                                         set, 
                                         should_include, 
                                         should_extend, 
                                         modules )
    
    # We have collected includes, extends, transparent cascades.
    # Now we want to actually include/extend/cascade as appropriate.
    
    # If we have a module (a class is a module):
    module_self = self
    if hooked_instance.is_a?( Module )

      hooked_instance.module_eval do
        
        if should_include                                                                    and 
           module_self.should_include_or_extend_instance?( set.module_class_instance_or_all, 
                                                           hooked_instance )                 and 
           ! modules.empty?
           
          include( *modules.reverse )
          
        end
        
        if should_extend                                                                     and 
           module_self.should_include_or_extend_instance?( set.module_class_instance_or_all, 
                                                           hooked_instance )                 and
           ! modules.empty?
           
          extend( *modules.reverse )

        end

      end
      
    # Otherwise we have an instance:
    else
      
      if should_extend                                                                       and 
         module_self.should_include_or_extend_instance?( set.module_class_instance_or_all, 
                                                         hooked_instance )                   and 
         ! modules.empty?

        hooked_instance.extend( *modules.reverse )

      end
      
    end
    
  end

  ########################################
  #  should_include_or_extend_instance?  #
  ########################################

  def should_include_or_extend_instance?( module_class_instance_or_all, into_instance )

    # The set stack already corresponds to include or extend or both, 
    # we are testing all_module_class_or_instance for:
    #
    # * any include/extend
    # * module include/extend
    # * class include/extend
    # * instance extend
  
    should_include_or_extend_instance = false
    
    case module_class_instance_or_all
      when :all, :module_or_class_or_instance, :module_and_class_and_instance, 
           :module_class_or_instance, :module_class_and_instance, :module_class_instance
        should_include_or_extend_instance = true
      when :module_or_class, :module_and_class, :module_class
        should_include_or_extend_instance = into_instance.is_a?( Module )
      when :module_or_instance, :module_and_instance, :module_instance
        should_include_or_extend_instance = ( ! into_instance.is_a?( Module ) or
                                              ( into_instance.is_a?( Module ) && 
                                                ! into_instance.is_a?( Class ) ) )
      when :class_or_instance, :class_and_instance, :class_instance
        should_include_or_extend_instance = ( into_instance.is_a?( Class ) or
                                              ! into_instance.is_a?( Module ) )
      when :module
        should_include_or_extend_instance = ( into_instance.is_a?( Module ) && 
                                              ! into_instance.is_a?( Class ) )
      when :class
        should_include_or_extend_instance = into_instance.is_a?( Class )
      when :instance
        should_include_or_extend_instance = ! into_instance.is_a?( Module )
    end

    return should_include_or_extend_instance
    
  end

  ##########################################
  #  collect_block_runtime_result_modules  #
  ##########################################

  def collect_block_runtime_result_modules( module_self, hooked_instance, set )

    runtime_block_result_modules = nil

    block = set.runtime_includes_or_extends_block

    case block.arity
      when 0
        runtime_block_result_modules = module_self.instance_eval( & block )
      else
        runtime_block_result_modules = module_self.instance_exec( hooked_instance, 
                                                                  & block )
    end
    
    if runtime_block_result_modules

      # make sure we have an array as a result
      unless runtime_block_result_modules.is_a?( Array )
        runtime_block_result_modules = [ runtime_block_result_modules ]
      end
      
      # make sure members of our result array are modules
      runtime_block_result_modules.delete_if do |this_result_instance|
        ! this_result_instance.is_a?( Module )
      end
      
      
      runtime_block_result_modules = nil if runtime_block_result_modules.empty?
      
    end
    
    return runtime_block_result_modules
    
  end
  
end
