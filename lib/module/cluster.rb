
# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

module ::Module::Cluster

  @clusters = { }
  
  ##################
  #  self.cluster  #
  ##################
  
  ###
  # @private
  #
  # Return cluster for instance or create if necessary
  #
  # @param instance Instance for which cluster is being created.
  #
  # @param name Name of cluster for instance.
  #
  # @return [ModuleCluster::Cluster] Cluster instance.
  #
  def self.cluster( instance, name )

    unless instance_hash = @clusters[ instance ]
      @clusters[ instance ] = instance_hash = { }
    end
    
    unless cluster_instance = instance_hash[ name ]
      instance_hash[ name ] = cluster_instance = ::Module::Cluster::Cluster.new( instance, name )
    end
    
    return cluster_instance
    
  end
 
  ###################
  #  self.extended  #
  ###################
  
  ###
  # Ensures that instance controller exists for extended instance.
  #
  def self.extended( instance )
    
    @instances[ instance ] = self.class::InstanceController.new
    
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
    
    return ::Module::Cluster.cluster( self, name )
    
  end

end
