# -*- encoding : utf-8 -*-

require 'singleton_attr'
require 'array/compositing'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

###
# Public interface to enable modules/classes with module-cluster capabilities.
#
module ::Module::Cluster
  
  extend ::Module::Cluster::Controller
  
  ###################
  #  self.extended  #
  ###################
  
  ###
  # @private
  #
  # Enables class or module support as appropriate for extended instance.
  #
  # @param [Module,Class] instance
  #
  #        Module or Class instance just extended with Module::Cluster.
  #
  def self.extended( instance )
    
    enable_with_module_cluster( instance, self )
    
  end

  #############
  #  cluster  #
  #############
  
  ###
  # Get cluster for name. Will create cluster if it does not already exist.
  #
  # @param [Symbol,String] name 
  #
  #        Name of cluster.
  #
  # @return [::Module::Cluster::Cluster]
  #
  #         Cluster instance.
  #
  def cluster( name )

    return ::Module::Cluster.instance_controller( self ).cluster( name )
    
  end
  
  ##################
  #  has_cluster?  #
  ##################
  
  ###
  # Get cluster for name. Will create cluster if it does not already exist.
  #
  # @param [Symbol,String] name 
  #
  #        Name of cluster.
  #
  # @return [true,false] 
  #
  #         Whether cluster name exists for self.
  #
  def has_cluster?( name )
    
    return ::Module::Cluster.instance_controller( self ).has_cluster?( name )
    
  end
  
end
