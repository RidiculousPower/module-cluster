# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :instance support by way of #initialize.
#
module ::Module::Cluster::InitializeSupport
  
  ################
  #  initialize  #
  ################
  
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
  def initialize( *args, & block )

    ::Module::Cluster.evaluate_cluster_stack( :before_initialize, self, self.class, args, & block )

    super if defined?( super )
    
    ::Module::Cluster.evaluate_cluster_stack( :after_initialize, self, self.class, args, & block )
    
  end
  
end
