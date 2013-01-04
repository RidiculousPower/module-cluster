
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
  # Ensures that instance controller exists for extended instance 
  #   and enables class or module support as appropriate.
  #
  # @param instance [Module,Class]
  #
  #        Module or Class instance just enabled with Module::Cluster.
  #
  def self.extended( instance )
    
    case instance
      when ::Class
        instance.extend( ::Module::Cluster::ClassSupport )
        # if we have a subclass of ::Module we are a class that creates instances as modules
        if instance < ::Module and not instance < ::Class
          instance.module_eval do
            include( ::Module::Cluster )
            include( ::Module::Cluster::ModuleSupport )
          end
        end
      when ::Module
        instance.extend( ::Module::Cluster::ModuleSupport )
    end
    
  end

  #############
  #  cluster  #
  #############
  
  ###
  # Get cluster for name. Will create cluster if it does not already exist.
  #
  # @param name Name of cluster.
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
  # @param name Name of cluster.
  #
  # @return [true,false] Whether cluster name exists for self.
  #
  def has_cluster?( name )
    
    return ::Module::Cluster.instance_controller( self ).has_cluster?( name )
    
  end
  
end
