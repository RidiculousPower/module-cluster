require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'module-cluster'
  spec.rubyforge_project         =  'module-cluster'
  spec.version                   =  '1.2.2'

  spec.summary                   =  "Adds methods for defining module clusters using #included, #extended, #append_features, and #extend_object."
  spec.description               =  "Provides methods for clustering modules so that when the main module is included other modules are also included or extended, either before or after the main module. There are currently three variants: cluster, cascade, cascade to class. Cluster causes the next module to be affected. Cascade causes all subsequent modules to be affected. Cascade to class causes the first including/extending class to be affected, but not any modules prior to it (although the effects will cascade through those unaffected modules)."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/module-cluster'

  spec.date                      =  Date.today.to_s
  
  # ensure the gem is built out of versioned files
  # also make sure we include the bundle since we exclude it from git storage
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*' ] & `git ls-files -z`.split("\0")

end
