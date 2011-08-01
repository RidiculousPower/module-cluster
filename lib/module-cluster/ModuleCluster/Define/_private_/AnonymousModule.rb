
module ModuleCluster::Define::AnonymousModule

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  include ModuleCluster::Define::ClusterStack

  ##########################################
  #  anonymous_module_for_append_features  #
  ##########################################

	def anonymous_module_for_append_features( subset_string = '', & method_block )

    module_instance = Module.new do

      #-------------------#
      #  append_features  #
      #-------------------#

      define_method( :append_features ) do |class_or_module|
        class_or_module.module_eval( & method_block )
        super( class_or_module )
      end

    end

    set_anonymous_module_constant( 'AppendFeatures' + subset_string, module_instance )
    
    return module_instance
    
  end

  ###################################
  #  anonymous_module_for_included  #
  ###################################

	def anonymous_module_for_included( subset_string = '', & method_block )

    module_instance = Module.new do

      #------------#
      #  included  #
      #------------#

      define_method( :included ) do |class_or_module|
        super( class_or_module )
        class_or_module.module_eval( & method_block )
      end

    end

    set_anonymous_module_constant( 'Included' + subset_string, module_instance )
    
    return module_instance

  end

  ########################################
  #  anonymous_module_for_extend_object  #
  ########################################

	def anonymous_module_for_extend_object( subset_string = '', & method_block )

    module_instance = Module.new do

      #-----------------#
      #  extend_object  #
      #-----------------#

      define_method( :extend_object ) do |class_or_module|
        class_or_module.module_eval( & method_block )
        super( class_or_module )
      end

    end

    set_anonymous_module_constant( 'ExtendObject' + subset_string, module_instance )
    
    return module_instance

  end

  ###################################
  #  anonymous_module_for_extended  #
  ###################################

	def anonymous_module_for_extended( subset_string = '', & method_block )

    module_instance = Module.new do

      #------------#
      #  extended  #
      #------------#

      define_method( :extended ) do |class_or_module|
        super( class_or_module )
        class_or_module.module_eval( & method_block )
      end

    end

    set_anonymous_module_constant( 'Included' + subset_string, module_instance )
    
    return module_instance

  end

  ###################################
  #  set_anonymous_module_constant  #
  ###################################

  def set_anonymous_module_constant( base_name, module_instance )
    
    module_constant_name = ( base_name << clusterstack_module.increment_stack_count.to_s ).to_sym
    const_set( module_constant_name, module_instance )
    
  end
  
end
