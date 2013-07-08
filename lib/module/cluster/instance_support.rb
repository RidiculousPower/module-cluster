# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :instance support by way of #new.
#
module ::Module::Cluster::InstanceSupport
  
  ##########################
  #  self.append_features  #
  ##########################

  alias_singleton_method :append_features, :original_append_features

  ########################
  #  self.extend_object  #
  ########################

  alias_singleton_method :extend_object, :original_extend_object
  
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
  def new( *args, & block )

    instance = allocate
    
    ::Module::Cluster.evaluate_cluster_stack( :before_instance, instance, self, args, & block )

    instance.instance_eval { initialize( *args, & block ) }

    ::Module::Cluster.evaluate_cluster_stack( :after_instance, instance, self, args, & block )
    
    return instance
    
  end
  
end
