
module ModuleCluster
  class ClusterStack
    module Block
      module Class
      end
      module Instance
      end
      module Module
      end
    end
    module Status
    end
    module Suspend
    end
  end
  module CascadeFeatures
  end
  module Define
    module Block
      module Class
      end
      module ClassOrModule
      end
      module ClassOrInstance
      end
      module Instance
      end
      module Module
      end
      module ModuleOrInstance
      end
    end
    module ClusterStack
    end
    module Cluster
    end
    module ClassCluster
    end
    module ClassOrInstanceCluster
    end
    module ClusterCascades
    end
    module ClusterCascadesToClass
    end
    module ClusterCascadesToModule
    end
    module Deprecated
    end
    module InstanceCluster
    end
    module ModuleCluster
    end
    module ModuleOrClassCluster
    end
    module ModuleOrInstanceCluster
    end
  end
  module Suspend
    module Hooks
    end
    module WithoutHooks
    end
  end
end


require_relative 'module-cluster/_private_/ModuleCluster/CascadeFeatures/ClusterStack.rb'
require_relative 'module-cluster/_private_/ModuleCluster/CascadeFeatures/PerformCascades.rb'
require_relative 'module-cluster/_private_/ModuleCluster/CascadeFeatures.rb'

require_relative 'module-cluster/_private_/ModuleCluster/ExtendForCascade.rb'

require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Set.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Set/MultiSetProxy.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Suspend.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Status.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Includes.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Extends.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/PrependsIncludes.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/PrependsExtends.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Block/Set.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Block/Class.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Block/Instance.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Block/Module.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack/Block.rb'
require_relative 'module-cluster/_private_/ModuleCluster/ClusterStack.rb'

require_relative 'module-cluster/ModuleCluster/Suspend/Hooks.rb'
require_relative 'module-cluster/ModuleCluster/Suspend/WithoutHooks.rb'
require_relative 'module-cluster/ModuleCluster/Suspend.rb'

require_relative 'module-cluster/ModuleCluster/Define/Block/Class.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/Instance.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/Module.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/ClassOrInstance.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/ClassOrModule.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/ModuleOrInstance.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block/ClassOrModuleOrInstance.rb'
require_relative 'module-cluster/ModuleCluster/Define/Block.rb'

require_relative 'module-cluster/ModuleCluster/Define/Cluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ModuleCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ClassCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ModuleOrClassCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ModuleOrInstanceCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ClassOrInstanceCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/InstanceCluster.rb'
require_relative 'module-cluster/ModuleCluster/Define/ClusterCascades.rb'
require_relative 'module-cluster/ModuleCluster/Define/ClusterCascadesToClass.rb'
require_relative 'module-cluster/ModuleCluster/Define/ClusterCascadesToModule.rb'

require_relative 'module-cluster/ModuleCluster/Define/Deprecated.rb'

require_relative 'module-cluster/ModuleCluster/Define.rb'

require_relative 'module-cluster/ModuleCluster.rb'

