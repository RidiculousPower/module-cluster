
module ::ModuleCluster::Define::Block::Subclass

  include ::ModuleCluster::CascadeFeatures::ClusterStack
  include ::ModuleCluster::Suspend::WithoutHooks
  extend ::ModuleCluster::Define::Block::Module
  
#  module_extend do |module_instance|
#    module_instance.module_eval do
#      extend ::ModuleCluster::Define::Block::Class
#      class_include do |class_instance|
#      end
#    end
#  end
  
  extend ::ModuleCluster::ExtendForCascade::Subclass
  
  ##########################
  #  self.should_cascade?  #
  ##########################

  def self.should_cascade?( class_or_module )
    # cascades anyway due to nature of subclassing
    return true
  end

  ############################
  #  self.should_run_block?  #
  ############################
  
  def self.should_run_block?( hooked_instance )

    should_run_block = false

    if hooked_instance.is_a?( Module )
      
      if hooked_instance.is_a?( Class )

        # subclass instance
        if hooked_instance.ancestors[ 1 ].is_a?( Class )
          should_run_block = true
        end
        # class instance - don't run
      end
      # module instance - don't run
      
    end
    
    return should_run_block

  end

  ##############
  #  subclass  #
  ##############

  def subclass( & runtime_block )
    return cluster_stack.subclass( ::ModuleCluster::Define::Block::Subclass, 
                                   __method__, 
                                   runtime_block )
  end

end
