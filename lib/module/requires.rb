# -*- encoding : utf-8 -*-

[
  
  'cluster/instance_controller',
  'cluster/instance_controller/stack',

  'cluster/controller',

  'cluster/cluster',
  'cluster/cluster/frame_definer',

  'cluster/cluster/frame',
  
  'cluster/hooks/class_support',
  'cluster/hooks/module_support',
  'cluster/hooks/instance_support'
    
].each { |this_file| require_relative( this_file << '.rb' ) }
