require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'module-cluster'
  spec.rubyforge_project         =  'module-cluster'
  spec.version                   =  '1.0.1'

  spec.summary                   =  "Adds methods for defining module clusters using #included and #extended."
  spec.description               =  "Provides :define_module_included, :define_module_extended, and :define_module_cluster."

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
