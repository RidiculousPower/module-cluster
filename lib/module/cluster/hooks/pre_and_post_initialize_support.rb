# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :instance support by way of #initialize.
#
module ::Module::Cluster::Hooks::PreAndPostInitializeSupport
  
  ####################
  #  pre_initialize  #
  ####################
  
  ###
  # Permits activity to be defined prior to any initialization activity. This can be useful
  #   if initialization activity may depend on a particular feature, such as instance registration,
  #   prior to activity occuring that queries or otherwise implicates its identity/definition.
  #
  # @overload pre_initialize( any_arg, ... )
  #
  #   @param [Object] any_arg
  #
  #                   Any arguments can be used for pre_initialize.
  #                   No arguments are expected here, but any will be passed to super.
  #
  def pre_initialize( *args, & block )

    ::Module::Cluster.evaluate_cluster_stack( :before_instance, instance, self, args, & block )
    
  end

  #####################
  #  post_initialize  #
  #####################
  
  ###
  # Permits activity to be defined after all initialization activity.
  #
  # @overload post_initialize( any_arg, ... )
  #
  #   @param [Object] any_arg
  #
  #                   Any arguments can be used for post_initialize.
  #                   No arguments are expected here, but any will be passed to super.
  #
  def post_initialize( *args, & block )

    ::Module::Cluster.evaluate_cluster_stack( :after_instance, instance, self, args, & block )
    
  end
  
end
