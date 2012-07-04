
###
# @private
#
# Controls event hook stacks for a given Module or Class instance.
#   Holds controllers for before and after include and extend and after subclass events. 
#   Controllers hold action stacks, which include/extend modules, perform block actions, 
#   or cascade actions to an inheriting instance.
#
class ::Module::Cluster::InstanceController
  
  include ::Module::Cluster::InstanceController::InstanceControllerInterface
    
end
