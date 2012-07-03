
class ::Module::Cluster::Exception::ModuleNotInStack < ::ArgumentError

  def initialize( hook_controller, module_instance )
    
    message_string = 'Module ' + module_instance.to_s + ' not found in stack ' + hook_controller.name.to_s + '.'
    
    super( message_string )
    
  end
  
end
