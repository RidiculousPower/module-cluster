# -*- encoding : utf-8 -*-

###
# @private
#
# Provides :instance support by way of #new.
#
module ::Module::Cluster::Hooks::InstanceSupport

  ###################
  #  self.extended  #
  ###################
  
  def self.extended( instance )
    
    super if defined?( super )

    instance.class_eval { include( ::Module::Cluster::Hooks::PreAndPostInitializeSupport ) }
    
  end
  
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
  # Adds calls to #pre_initialize and #post_initialize before and after call to #initialize.
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

    instance.instance_eval do
      pre_initialize( *args, & block )
      initialize( *args, & block )
      post_initialize( *args, & block )
    end
    
    return instance
    
  end
  
end
