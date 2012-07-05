
basepath = 'cluster'

files = [
    
  'instance_controller/hook_controller/hook_controller_interface',
  'instance_controller/hook_controller',

  'instance_controller/hook_controller/chain_proxy',

  'instance_controller/multiple_hook_controller_proxy',
  'instance_controller/multiple_hook_controller_proxy/chain_proxy',

  'instance_controller/instance_controller_interface',
  'instance_controller',

  'cluster/cluster_interface',

  'cluster',

  'exception/module_not_in_stack',

  'class_support',
  'module_support'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
