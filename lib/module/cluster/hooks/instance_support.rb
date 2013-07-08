# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :instance support by way of #new.
#
module ::Module::Cluster::Hooks::InstanceSupport

  ####################
  #  pre_initialize  #
  ####################
  
  ###
  # Ensures :before_instance hooks occur at time of instance creation.
  #
  # @param [Module,Class] hooked_subclass_instance
  #
  #        Instance inheriting features.
  #
  def pre_initialize( *args, & block )

    ::Module::Cluster.evaluate_cluster_stack( :before_instance, self, self.class, args, & block )
    
  end

  #####################
  #  post_initialize  #
  #####################
  
  ###
  # Ensures :after_instance hooks occur at time of instance creation.
  #
  # @param [Module,Class] hooked_subclass_instance
  #
  #        Instance inheriting features.
  #
  def post_initialize( *args, & block )

    ::Module::Cluster.evaluate_cluster_stack( :after_instance, self, self.class, args, & block )
    
  end

end
