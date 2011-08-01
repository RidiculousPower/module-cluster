
module ModuleCluster::Define::ClusterStack
  
  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  #########################
  #  clusterstack_module  #
  #########################

  def clusterstack_module( & clusterstack_extend_include_block )
    
    unless const_defined?( :ClusterStackModule )
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
    
    # we use a block so that we don't have to worry about re-extending each time
    self::ClusterStackModule.module_eval( & clusterstack_extend_include_block ) if block_given?

    # we have to re-extend each time so that new includes/extends apply to self
    extend( self::ClusterStackModule )
    
    return self::ClusterStackModule

  end

end
