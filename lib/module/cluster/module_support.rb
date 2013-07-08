# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :before_include, :after_include, :before_extend, :after_extend support by way of 
#   #append_features, #included, #extend_object, #extended.
#
module ::Module::Cluster::ModuleSupport

  ##########################
  #  self.append_features  #
  ##########################

  alias_singleton_method :append_features, :original_append_features

  ########################
  #  self.extend_object  #
  ########################

  alias_singleton_method :extend_object, :original_extend_object

  ###################
  #  self.included  #
  ###################

  def self.included( instance )
    # do nothing
  end

  ###################
  #  self.extended  #
  ###################

  def self.extended( instance )
    # do nothing
  end

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
    puts 'hooking include: ' << hooked_instance.to_s
    ::Module::Cluster.ensure_parser_constructed_module_evaluated( self )
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
    puts 'hooking extend: ' << hooked_instance.to_s

    ::Module::Cluster.ensure_parser_constructed_module_evaluated( self )
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
