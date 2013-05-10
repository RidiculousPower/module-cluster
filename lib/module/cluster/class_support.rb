# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :subclass support by way of #inherited.
#
module ::Module::Cluster::ClassSupport
  
  ###############
  #  inherited  #
  ###############
  
  ###
  # Ensures :subclass hooks occur at time of subclassing.
  #
  # @param [Module,Class] hooked_subclass_instance
  #
  #        Instance inheriting features.
  #
  def inherited( hooked_subclass_instance )

    super if defined?( super )
    
    ::Module::Cluster.evaluate_cluster_stack( :subclass, hooked_subclass_instance, self )
    
  end
  
end
