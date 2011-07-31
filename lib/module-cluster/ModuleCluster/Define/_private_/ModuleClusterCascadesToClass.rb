
module ModuleCluster::Define::ModuleClusterCascadesToClass

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  include ModuleCluster::Define::ClusterStack

  #######################################################
  #  anonymous_module_cascade_to_class_append_features  #
  #######################################################

	def anonymous_module_cascade_to_class_append_features( extend_or_include, *other_modules )

    return Module.new do

      #-------------------#
      #  append_features  #
      #-------------------#

      define_method( :append_features ) do |class_or_module|
        class_or_module.module_eval do
          extend ModuleCluster::Define::ModuleClusterCascadesToClass
          extend( anonymous_module_cascade_to_class_append_features( extend_or_include, *other_modules ) )
          if is_a?( Class )
            other_modules.each do |this_module|
              __send__( extend_or_include, this_module )
            end
          end
        end
        super( class_or_module )
      end

    end

  end

  ################################################
  #  anonymous_module_cascade_to_class_included  #
  ################################################

	def anonymous_module_cascade_to_class_included( extend_or_include, *other_modules )

    return Module.new do

      #------------#
      #  included  #
      #------------#

      define_method( :included ) do |class_or_module|
        super( class_or_module )
        class_or_module.module_eval do
          extend ModuleCluster::Define::ModuleClusterCascadesToClass
          extend( anonymous_module_cascade_to_class_included( extend_or_include, *other_modules ) )
          if is_a?( Class )
            other_modules.each do |this_module|
              __send__( extend_or_include, this_module )
            end
          end
        end
      end

    end

  end

  #####################################################
  #  anonymous_module_cascade_to_class_extend_object  #
  #####################################################

	def anonymous_module_cascade_to_class_extend_object( extend_or_include, *other_modules )

    return Module.new do

      #-----------------#
      #  extend_object  #
      #-----------------#

      define_method( :extend_object ) do |class_or_module|
        class_or_module.module_eval do
          extend ModuleCluster::Define::ModuleClusterCascadesToClass
          extend( anonymous_module_cascade_to_class_extend_object( extend_or_include, *other_modules ) )
          if is_a?( Class )
            other_modules.each do |this_module|
              __send__( extend_or_include, this_module )
            end
          end
        end
        super( class_or_module )
      end

    end

  end

  ################################################
  #  anonymous_module_cascade_to_class_extended  #
  ################################################

	def anonymous_module_cascade_to_class_extended( extend_or_include, *other_modules )

    return Module.new do

      #------------#
      #  included  #
      #------------#

      define_method( :extended ) do |class_or_module|
        super( class_or_module )
        class_or_module.module_eval do
          extend ModuleCluster::Define::ModuleClusterCascadesToClass
          extend( anonymous_module_cascade_to_class_extended( extend_or_include, *other_modules ) )
          if is_a?( Class )
            other_modules.each do |this_module|
              __send__( extend_or_include, this_module )
            end
          end
        end
      end

    end

  end

end
