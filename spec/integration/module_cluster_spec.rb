
require_relative '../../lib/module/cluster.rb'

describe ::Module::Cluster do
  
  ####################
  #  named clusters  #
  ####################
  
  it 'can create named clusters' do
    module ::Module::Cluster::NamedClusterMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        new_cluster_set = cluster( :cluster_name )
        new_cluster_set.is_a?( ::Module::Cluster::Cluster ).should == true
        cluster( :cluster_name ).should == new_cluster_set
      
      end

    end
  end
  
  #################################################
  #  interpolated actions from multiple clusters  #
  #################################################

  it 'can interpolate actions from multiple clusters using :before and :after' do
    module ::Module::Cluster::BeforeAfterInterpolateActionMock

      module ClusterModule
        
        extend ::Module::Cluster
        
        module A
        end
        module B
        end
        module C
        end
        
        cluster( :cluster_name ).before_include.extend( A, B, C )

        module D
        end

        cluster( :other_cluster_name ).before_include.before_extend( B ).extend( D )

        module E
        end
        module F
        end

        cluster( :third_cluster_name ).before_include.after_extend( A ).extend( E )
        cluster( :third_cluster_name ).before_include.after_extend( D ).extend( F )
        
      end
      
      module IncludingModule
        
        include ClusterModule
        
        ancestors.include?( A ).should == true
        ancestors.include?( B ).should == true
        ancestors.include?( C ).should == true
        ancestors.include?( D ).should == true
        ancestors.include?( E ).should == true
        ancestors.include?( F ).should == true

        ancestors.index( A ).should < ancestors.index( E )
        ancestors.index( E ).should < ancestors.index( D )
        ancestors.index( D ).should < ancestors.index( F )
        ancestors.index( F ).should < ancestors.index( B )
        ancestors.index( B ).should < ancestors.index( C )
        
      end
      
    end
    
  end
  
  #######################################
  #  suspend and resume named clusters  #
  #######################################
  
  it 'can suspend and resume named clusters' do
    module ::Module::Cluster::SuspendResumeMock

      module ClusterModuleMock
        
        extend ::Module::Cluster
        
        module A
        end
        module B
        end
        module C
        end

        cluster( :cluster_name ).before_include.extend( A, B, C )

        module D
        end
        module E
        end
        module F
        end

        cluster( :other_cluster_name ).before_include.extend( D, E, F )
        
      end
      
      module IncludingModule
        
        include ClusterModule
        
        ancestors.include?( A ).should == true
        ancestors.include?( B ).should == true
        ancestors.include?( C ).should == true
        ancestors.include?( D ).should == true
        ancestors.include?( E ).should == true
        ancestors.include?( F ).should == true
        
        ancestors.index( A ).should < ancestors.index( B )
        ancestors.index( B ).should < ancestors.index( C )
        ancestors.index( C ).should < ancestors.index( D )
        ancestors.index( D ).should < ancestors.index( E )
        ancestors.index( E ).should < ancestors.index( F )
        
      end
      
    end
    
  end
  
end
