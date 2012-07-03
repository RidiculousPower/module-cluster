
basepath = 'cluster'

files = [
    
  'cluster/instance_controller',

  'cluster/instance_controller/hook_controller/hook_controller_interface',
  'cluster/instance_controller/hook_controller',

  'cluster/instance_controller/hook_controller/chain_proxy',

  'cluster/instance_controller/multiple_hook_controller_proxy',
  'cluster/instance_controller/multiple_hook_controller_proxy/chain_proxy',

  'cluster/cluster_interface',

  'exception/module_not_in_stack',

  'cluster'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
