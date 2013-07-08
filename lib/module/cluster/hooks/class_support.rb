# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :subclass support by way of #inherited.
#
module ::Module::Cluster::Hooks::ClassSupport
  
  ##########################
  #  self.append_features  #
  ##########################

  alias_singleton_method :append_features, :original_append_features

  ########################
  #  self.extend_object  #
  ########################

  alias_singleton_method :extend_object, :original_extend_object
  
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
