require 'date'

Gem::Specification.new do |spec|

  spec.name                      = 'module-cluster'
  spec.rubyforge_project         = 'module-cluster'
  spec.version                   = '2.0.2'

  spec.summary                   = "Provides an interface for event hooks at any point during module include/extend or class subclassing."
  spec.description               = "Provides hooks via :included, :extended, :append_features, :extend_object, :inherited. Define behavior at hooks via simple interface."

  spec.authors                   = [ 'Asher' ]
  spec.email                     = 'asher@ridiculouspower.com'
  spec.homepage                  = 'http://rubygems.org/gems/module-cluster'

  spec.date                      = ::Date.today.to_s
  
  spec.files                     = ::Dir[ '{lib,spec}/**/*',
                                          'README*', 
                                          'LICENSE*' ]

end
