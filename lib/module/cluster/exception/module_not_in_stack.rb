
###
# Exception raised when a module is provided for a before/after insert but module is not present in stack
#   as specified.
#
class ::Module::Cluster::Exception::ModuleNotInStack < ::ArgumentError

  ################
  #  initialize  #
  ################
  
  ###
  # 
  # @param hook_controller Hook Controller where module was not found.
  #
  # @param module_instance Module not found.
  #
  def initialize( hook_controller, module_instance )
    
    message_string = 'Module ' + module_instance.to_s + ' not found in stack ' + hook_controller.name.to_s + '.'
    
    super( message_string )
    
  end
  
end
