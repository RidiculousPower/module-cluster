
module ModuleCluster::Define::ClusterStack
  
  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  ################
  #  eigenclass  #
  ################
  
  def eigenclass
    return class << self ; self ; end
  end

  #########################
  #  clusterstack_module  #
  #########################

  def clusterstack_module( & clusterstack_extend_include_block )
    
    module_instance = nil

    unless const_defined?( :ClusterStackModule ) and module_instance = const_get( :ClusterStackModule )

      module_instance = Module.new do

        #-------------------------#
        #  increment_stack_count  #
        #-------------------------#

        def self.increment_stack_count
          @stack_count ||= 0
          @stack_count += 1
          return @stack_count
        end

      end

      const_set( :ClusterStackModule, module_instance )

    end
    
    # we use a block so that we don't have to worry about manually re-extending each time
    if block_given?
      module_instance.module_eval( & clusterstack_extend_include_block )
      # we have to re-extend each time so that new includes/extends apply to self
      extend( module_instance )
    end
    
    return module_instance

  end

end
