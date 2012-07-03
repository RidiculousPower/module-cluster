
require_relative '../../lib/module/cluster.rb'

describe ::Module::Cluster do

  #############################
  #  cascading event actions  #
  #############################

  # cascade to any instance (class, subclass, module, instance)
  
  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades
        cluster( :cluster_name ).extend_cascades
        cluster( :cluster_name ).include_or_extend_cascades
        
      end
    end
  end
  
  # cascade to class
  # this means to the first class, not subclasses

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class )
        cluster( :cluster_name ).extend_cascades( :class )
        cluster( :cluster_name ).include_or_extend_cascades( :class )
        
      end
    end
  end

  # cascade to subclass

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToSubclassActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster

        cluster( :cluster_name ).include_cascades( :subclass )
        cluster( :cluster_name ).extend_cascades( :subclass )
        cluster( :cluster_name ).include_or_extend_cascades( :subclass )

      end
    end
  end
  
  # cascade to module

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToModuleActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :module )
        cluster( :cluster_name ).extend_cascades( :module )
        cluster( :cluster_name ).include_or_extend_cascades( :module )
        
      end
    end
  end
  
  # cascade to instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :instance )
        cluster( :cluster_name ).extend_cascades( :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :instance )
        
      end
    end
  end

  # cascade to class or subclass

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrSubclassActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :subclass )
        cluster( :cluster_name ).extend_cascades( :class, :subclass )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :subclass )

      end
    end
  end

  # cascade to module or subclass

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToModuleOrSubclassActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :module, :subclass )
        cluster( :cluster_name ).extend_cascades( :module, :subclass )
        cluster( :cluster_name ).include_or_extend_cascades( :module, :subclass )
        
      end
    end
  end

  # cascade to subclass or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToSubclassOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :subclass, :instance )
        cluster( :cluster_name ).extend_cascades( :subclass, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :subclass, :instance )
        
      end
    end
  end
  
  # cascade to class or module

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrModuleActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :module )
        cluster( :cluster_name ).extend_cascades( :class, :module )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :module )
        
      end
    end
  end

  # cascade to class or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :instance )
        cluster( :cluster_name ).extend_cascades( :class, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :instance )
        
      end
    end
  end

  # cascade to module or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToModuleOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :module, :instance )
        cluster( :cluster_name ).extend_cascades( :module, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :module, :instance )
        
      end
    end
  end

  # cascade to class or subclass or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrSubclassOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :subclass, :instance )
        cluster( :cluster_name ).extend_cascades( :class, :subclass, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :subclass, :instance )
        
      end
    end
  end

  # cascade to module or subclass or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToModuleOrSubclassOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :module, :subclass, :instance )
        cluster( :cluster_name ).extend_cascades( :module, :subclass, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :module, :subclass, :instance )
        
      end
    end
  end

  # cascade to class or module or instance

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrModuleOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :module, :instance )
        cluster( :cluster_name ).extend_cascades( :class, :module, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :module, :instance )
        
      end
    end
  end

  # cascade to class or subclass or module or instance (redundant with non-specification)

  it 'can create cascade event actions to perform at hook time' do
    module ::Module::Cluster::CascadeToClassOrSubclassOrModuleOrInstanceActionMock
      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        cluster( :cluster_name ).include_cascades( :class, :subclass, :module, :instance )
        cluster( :cluster_name ).extend_cascades( :class, :subclass, :module, :instance )
        cluster( :cluster_name ).include_or_extend_cascades( :class, :subclass, :module, :instance )
        
      end
    end
  end

end
