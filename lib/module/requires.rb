# -*- encoding : utf-8 -*-

[
  
  '../../lib_ext/class',
  '../../lib_ext/module',
  
  'cluster/instance_controller',
  'cluster/instance_controller/stack',

  'cluster/controller',

  'cluster/cluster',
  'cluster/cluster/frame_definer',

  'cluster/cluster/frame',
  
  'cluster/class_support',
  'cluster/module_support',
  'cluster/initialize_support',
  'cluster/instance_support'
    
].each { |this_file| require_relative( this_file << '.rb' ) }
