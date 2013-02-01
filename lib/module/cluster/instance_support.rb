
###
# @private
#
# Provides :instance support by way of #new.
#
module ::Module::Cluster::InstanceSupport
  
  #########
  #  new  #
  #########
  
  ###
  # Ensures :instance hooks occur at time of initialization.
  #
  # @overload initialize( any_arg, ... )
  #
  #   @param [Object] any_arg
  #
  #                   Any arguments can be used for initialize.
  #                   No arguments are expected here, but any will be passed to super.
  #
  def new( *args )

    instance = allocate
    
    ::Module::Cluster.evaluate_cluster_stack( :before_instance, instance, self, args )
    
    instance.instance_eval { initialize( *args ) }

    ::Module::Cluster.evaluate_cluster_stack( :after_instance, instance, self, args )
    
    return instance
    
  end
  
end
