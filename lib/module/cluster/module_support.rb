# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :before_include, :after_include, :before_extend, :after_extend support by way of 
#   #append_features, #included, #extend_object, #extended.
#
module ::Module::Cluster::ModuleSupport

  #####################
  #  append_features  #
  #####################

  ###
  # Ensures :before_include hooks occur at time of include.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance to which features will be appended.
  #
  def append_features( hooked_instance )

    ::Module::Cluster.evaluate_cluster_stack( :before_include, hooked_instance, self )

    super if defined?( super )
    
  end

  ##############
  #  included  #
  ##############

  ###
  # Ensures :after_include hooks occur at time of include.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance where features will be included.
  #
  def included( hooked_instance )

    super if defined?( super )
    
    ::Module::Cluster.evaluate_cluster_stack( :after_include, hooked_instance, self )
    
  end

  ###################
  #  extend_object  #
  ###################
  
  ###
  # Ensures :before_extend hooks occur at time of extend.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance where features will be extended.
  #
  def extend_object( hooked_instance )

    ::Module::Cluster.evaluate_cluster_stack( :before_extend, hooked_instance, self )
    
    super if defined?( super )
    
  end

  ##############
  #  extended  #
  ##############
  
  ###
  # Ensures :after_extend hooks occur at time of extend.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance where features will be extended.
  #
  def extended( hooked_instance )

    super if defined?( super )
    
    ::Module::Cluster.evaluate_cluster_stack( :after_extend, hooked_instance, self )
    
  end

end
