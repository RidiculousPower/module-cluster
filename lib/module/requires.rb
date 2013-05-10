# -*- encoding : utf-8 -*-

basepath = 'cluster'

files = [
    
  'instance_controller',
  'instance_controller/stack',

  'controller',

  'cluster',
  'cluster/frame_definer',

  'cluster/frame',
  
  'class_support',
  'module_support',
  'initialize_support',
  'instance_support'
    
]

files.each do |this_file|
  require_relative( ::File.join( basepath, this_file ) + '.rb' )
end
