
require 'date'

Gem::Specification.new do |spec|

  spec.name                      = 'module-cluster'
  spec.rubyforge_project         = 'module-cluster'
  spec.version                   = '2.1.0'

  spec.summary                   = "Provides an interface for event hooks at any point during module include/extend or class subclassing."
  spec.description               = "Provides hooks via :included, :extended, :append_features, :extend_object, :inherited. Define behavior at hooks via simple interface."

  spec.authors                   = [ 'Asher' ]
  spec.email                     = 'asher@ridiculouspower.com'
  spec.homepage                  = 'http://rubygems.org/gems/module-cluster'

  spec.add_dependency            'call_super'
  spec.add_dependency            'pre_and_post_initialize'
  spec.add_dependency            'singleton_attr'
  spec.add_dependency            'array-compositing'

  spec.required_ruby_version     = ">= 1.9.1"

  spec.date                      = ::Date.today.to_s
  
  spec.files                     = ::Dir[ '{lib,lib_ext,spec}/**/*',
                                          'README*', 
                                          'LICENSE*' ]

end
