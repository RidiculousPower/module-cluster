
module ModuleCluster::CascadeFeatures
  
  CascadeStruct = Struct.new( :includes, :extends, :cascades, :runtime_block )
  DependencyModule = Struct.new( :class_or_module, :method, :modules )
  
  #####################################################
  #  self.get_runtime_includes_or_extends_from_block  #
  #####################################################
  
  def self.get_runtime_includes_or_extends_from_block( module_self, class_or_module, include_or_extend, runtime_includes_or_extends_block )
    
    includes_or_extends = nil
    
    case runtime_includes_or_extends_block.arity
    when 0
      includes_or_extends = module_self.instance_eval( & runtime_includes_or_extends_block )
    else
      includes_or_extends = module_self.instance_exec( class_or_module, & runtime_includes_or_extends_block )
    end

    return includes_or_extends
    
  end
  
  ############################################
  #  self.includes_or_extends_for_set_stack  #
  ############################################
  
  def self.includes_or_extends_for_set_stack( module_self, class_or_module, set_stack )
    
    includes = Array.new
    extends = Array.new
    cascades = Hash.new
    
    set_stack.each do |this_set|

      # get cascades
      if this_set.dependency_module.should_cascade?( class_or_module )
        cascades[ this_set.dependency_module ] ||= Hash.new
        cascades[ this_set.dependency_module ][ this_set.method ] ||= Array.new
        cascades[ this_set.dependency_module ][ this_set.method ].concat( this_set.modules )            
      end

      # get runtime block
      runtime_set = nil
      if block = this_set.runtime_includes_or_extends_block
        runtime_set = ModuleCluster::CascadeFeatures.get_runtime_includes_or_extends_from_block( module_self, 
                                                                                                 class_or_module,
                                                                                                 this_set.include_or_extend,
                                                                                                 block )
      end
      
      # get includes/extends
      case this_set.include_or_extend
        when :include
          this_set.modules.each do |this_module|
            if this_set.dependency_module.should_include_or_extend?( class_or_module )
              includes.concat( this_set.modules )            
            end
          end
          includes.concat( runtime_set ) if runtime_set
        when :extend
          if this_set.dependency_module.should_include_or_extend?( class_or_module )
            extends.concat( this_set.modules )
          end
          extends.concat( runtime_set ) if runtime_set
      end
      
    end
    
    includes.uniq!
    extends.uniq!
    cascades.each do |this_dependency_module, this_method_and_module_set|
      this_method_and_module_set.each do |this_method, this_module_set|
        this_module_set.uniq!
      end
    end
        
    return ModuleCluster::CascadeFeatures::CascadeStruct.new( includes, extends, cascades )
    
  end
  
  ###########################
  #  self.cascade_features  #
  ###########################
  
  def self.cascade_features( class_or_module, cascade_struct )
    class_or_module.module_eval do
      include( *cascade_struct.includes.reverse ) unless cascade_struct.includes.empty?
      extend( *cascade_struct.extends.reverse ) unless cascade_struct.extends.empty?
    end

    cascade_struct.cascades.each do |this_dependency_module, this_method_and_module_set|
      this_method_and_module_set.each do |this_method, this_module_set|
        this_dependency_module.perform_cascades( class_or_module, this_method, this_module_set )
      end
    end
  end

  #####################
  #  append_features  #
  #####################

  def append_features( class_or_module )
    
    cascade_struct = ModuleCluster::CascadeFeatures.includes_or_extends_for_set_stack( self, class_or_module, cluster_stack.cascading_prepending_includes )
    ModuleCluster::CascadeFeatures.cascade_features( class_or_module, cascade_struct )
    
    super
    
  end
  
  ##############
  #  included  #
  ##############

  def included( class_or_module )

    super

    cascade_struct = ModuleCluster::CascadeFeatures.includes_or_extends_for_set_stack( self, class_or_module, cluster_stack.cascading_includes )
    ModuleCluster::CascadeFeatures.cascade_features( class_or_module, cascade_struct )
    
  end
  
  ###################
  #  extend_object  #
  ###################

  def extend_object( class_or_module )

    cascade_struct = ModuleCluster::CascadeFeatures.includes_or_extends_for_set_stack( self, class_or_module, cluster_stack.cascading_prepending_extends )
    ModuleCluster::CascadeFeatures.cascade_features( class_or_module, cascade_struct )
    
    super
    
  end
  
  ##############
  #  extended  #
  ##############

  def extended( class_or_module )

    super

    cascade_struct = ModuleCluster::CascadeFeatures.includes_or_extends_for_set_stack( self, class_or_module, cluster_stack.cascading_extends )
    ModuleCluster::CascadeFeatures.cascade_features( class_or_module, cascade_struct )

  end
  
end