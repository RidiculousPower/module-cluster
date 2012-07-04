
###
# A Hook Controller manages a stack of actions for a given event hook (before/after include, extend or subclass).
#   The action stack manages stack frames, each of which provides details for an action to be performed
#   at event hook.
#
class ::Module::Cluster::InstanceController::HookController
  
  #############
  #  extend!  #
  #############
  
  ###
  # Alias to original Module#extend method.
  #
  class << self
    alias_method :extend!, :extend
  end
  
  ##############
  #  include!  #
  ##############

  ###
  # Alias to original Module#include method.
  #
  class << self
    alias_method :include!, :include
  end
  
  include ::Module::Cluster::InstanceController::HookController::HookControllerInterface
    
end
