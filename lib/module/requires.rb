
basepath = 'cluster'

files = [
    
  'instance_controller',
  'instance_controller/stack',

  'controller',

  'cluster',

  'cluster/frame',
  
  'class_support',
  'module_support'
    
]

files.each do |this_file|
  require_relative( ::File.join( basepath, this_file ) + '.rb' )
end
