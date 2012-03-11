# Module Cluster #

http://rubygems.org/gems/module-cluster

# Description #

Adds methods for defining module clusters using #included, #extended, #append_features, and #extend_object.

# Summary #

Provides methods for clustering modules so that when the main module is included other modules are also included or extended, either before or after the main module. There are currently three variants: cluster, cascade, cascade to class. Cluster causes the next module to be affected. Cascade causes all subsequent modules to be affected. Cascade to class causes the first including/extending class to be affected, but not any modules prior to it (although the effects will cascade through those unaffected modules). 

# Install #

* sudo gem install module-cluster

# Usage #

Simply:

```ruby
module SomeModule
  extend ::ModuleCluster
end
```

Definition methods accept modules as arguments. 

For example:

```ruby
module SomeModule
  extend ::ModuleCluster
  include_also_includes( SomeOtherModule )
end
```

Additionally, all methods accept a block that returns one or more modules; the modules will be added *after* any modules specified in the parameters:

```ruby
module SomeModule
  extend ::ModuleCluster
  include_also_includes( SomeOtherModule ) do
    AnotherModule
  end
end
```

Blocks can be used to return dynamically-determined modules at runtime.

```ruby
module SomeModule
  extend ::ModuleCluster
  include_or_extend_cascades_prepend_extends do
    method_that_returns_one_or_more_modules
  end
end
```

Block methods can be used for nesting declarations, for instance to apply cascades only after first module/class:

```ruby
prepend_module_include do |class_or_module|
  class_or_module.include_or_extend_cascades_prepend_extends do
    method_that_returns_one_or_more_modules
  end
end
```

Calls to the various functions are cumulative and stack in the order called. This permits multiple calls, whether subsequently or otherwise.

# Methods #

Cluster methods:

* include_also_includes
* include_also_extends
* include_also_includes_and_extends
* extend_also_includes
* extend_also_extends
* extend_also_includes_and_extends
* include_prepends_includes
* include_prepends_extends
* include_prepends_includes_and_extends
* extend_prepends_includes
* extend_prepends_extends
* extend_prepends_includes_and_extends
* include_or_extend_also_includes
* include_or_extend_also_extends
* include_or_extend_also_includes_and_extends
* include_or_extend_prepends_includes
* include_or_extend_prepends_extends
* include_or_extend_prepends_includes_and_extends

Module cluster methods:

* module_include_also_includes
* module_include_also_extends
* module_include_also_includes_and_extends
* module_extend_also_includes
* module_extend_also_extends
* module_extend_also_includes_and_extends
* module_include_prepends_includes
* module_include_prepends_extends
* module_include_prepends_includes_and_extends
* module_extend_prepends_includes
* module_extend_prepends_extends
* module_extend_prepends_includes_and_extends
* module_include_or_extend_also_includes
* module_include_or_extend_also_extends
* module_include_or_extend_also_includes_and_extends
* module_include_or_extend_prepends_includes
* module_include_or_extend_prepends_extends
* module_include_or_extend_prepends_includes_and_extends

Class cluster methods:

* class_include_also_includes
* class_include_also_extends
* class_include_also_includes_and_extends
* class_extend_also_includes
* class_extend_also_extends
* class_extend_also_includes_and_extends
* class_include_prepends_includes
* class_include_prepends_extends
* class_include_prepends_includes_and_extends
* class_extend_prepends_includes
* class_extend_prepends_extends
* class_extend_prepends_includes_and_extends
* class_include_or_extend_also_includes
* class_include_or_extend_also_extends
* class_include_or_extend_also_includes_and_extends
* class_include_or_extend_prepends_includes
* class_include_or_extend_prepends_extends
* class_include_or_extend_prepends_includes_and_extends

Instance cluster methods:

* instance_extend_also_extends
* instance_extend_prepends_extends

Module or instance cluster methods:

* module_include_or_extend_or_instance_extend_also_includes_or_extends
* module_include_or_extend_or_instance_extend_also_extends
* module_include_or_instance_extend_also_includes_or_extends
* module_include_or_instance_extend_also_extends
* module_or_instance_extend_also_extends
* module_include_or_extend_or_instance_extend_prepends_includes_or_extends
* module_include_or_instance_extend_prepends_includes_or_extends
* module_include_or_extend_or_instance_extend_prepends_extends
* module_include_or_instance_extend_prepends_extends
* module_or_instance_extend_prepends_extends

Class or module cluster methods:

* module_or_class_include_also_includes
* module_or_class_include_also_extends
* module_or_class_include_also_includes_and_extends
* module_or_class_extend_also_includes
* module_or_class_extend_also_extends
* module_or_class_extend_also_includes_and_extends
* module_or_class_include_prepends_includes
* module_or_class_include_prepends_extends
* module_or_class_include_prepends_includes_and_extends
* module_or_class_extend_prepends_includes
* module_or_class_extend_prepends_extends
* module_or_class_extend_prepends_includes_and_extends
* module_or_class_include_or_extend_also_includes
* module_or_class_include_or_extend_also_extends
* module_or_class_include_or_extend_also_includes_and_extends
* module_or_class_include_or_extend_prepends_includes
* module_or_class_include_or_extend_prepends_extends
* module_or_class_include_or_extend_prepends_includes_and_extends

Class or module or instance cluster methods:

* module_include_or_extend_or_instance_extend_also_includes_or_extends
* module_include_or_extend_or_instance_extend_also_extends
* module_include_or_instance_extend_also_includes_or_extends
* module_include_or_instance_extend_also_extends
* module_or_instance_extend_also_extends
* module_include_or_extend_or_instance_extend_prepends_includes_or_extends
* module_include_or_instance_extend_prepends_includes_or_extends
* module_include_or_extend_or_instance_extend_prepends_extends
* module_include_or_instance_extend_prepends_extends
* module_or_instance_extend_prepends_extends

Class or instance cluster methods:

* class_include_or_extend_or_instance_extend_also_includes_or_extends
* class_include_or_extend_or_instance_extend_also_extends
* class_include_or_instance_extend_also_includes_or_extends
* class_include_or_instance_extend_also_extends
* class_or_instance_extend_also_extends
* class_include_or_extend_or_instance_extend_prepends_includes_or_extends
* class_include_or_instance_extend_prepends_includes_or_extends
* class_include_or_extend_or_instance_extend_prepends_extends
* class_include_or_instance_extend_prepends_extends
* class_or_instance_extend_prepends_extends

Cascade methods (cascades to modules and classes):

* include_cascades_includes
* include_cascades_extends
* include_cascades_includes_and_extends
* extend_cascades_includes
* extend_cascades_extends
* extend_cascades_includes_and_extends
* include_cascades_prepend_includes
* include_cascades_prepend_extends
* include_cascades_prepend_includes_and_extends
* extend_cascades_prepend_includes
* extend_cascades_prepend_extends
* extend_cascades_prepend_includes_and_extends
* include_or_extend_cascades_includes
* include_or_extend_cascades_extends
* include_or_extend_cascades_includes_and_extends
* include_or_extend_cascades_prepend_includes
* include_or_extend_cascades_prepend_extends
* include_or_extend_cascades_prepend_includes_and_extends

Cascade to class methods (does not cascade to modules):

* include_cascades_includes_to_class
* include_cascades_extends_to_class
* include_cascades_includes_and_extends_to_class
* extend_cascades_includes_to_class
* extend_cascades_extends_to_class
* extend_cascades_includes_and_extends_to_class
* include_cascades_to_class_prepend_includes
* include_cascades_to_class_prepend_extends
* include_cascades_to_class_prepend_includes_and_extends
* extend_cascades_to_class_prepend_includes
* extend_cascades_to_class_prepend_extends
* extend_cascades_to_class_prepend_includes_and_extends
* include_or_extend_cascades_includes_to_class
* include_or_extend_cascades_extends_to_class
* include_or_extend_cascades_includes_and_extends_to_class
* include_or_extend_cascades_to_class_prepend_includes
* include_or_extend_cascades_to_class_prepend_extends
* include_or_extend_cascades_to_class_prepend_includes_and_extends

Cascade to module methods (does not cascade to classes):

* include_cascades_includes_to_module
* include_cascades_extends_to_module
* include_cascades_includes_and_extends_to_module
* extend_cascades_includes_to_module
* extend_cascades_extends_to_module
* extend_cascades_includes_and_extends_to_module
* include_cascades_to_module_prepend_includes
* include_cascades_to_module_prepend_extends
* include_cascades_to_module_prepend_includes_and_extends
* extend_cascades_to_module_prepend_includes
* extend_cascades_to_module_prepend_extends
* extend_cascades_to_module_prepend_includes_and_extends
* include_or_extend_cascades_includes_to_module
* include_or_extend_cascades_extends_to_module
* include_or_extend_cascades_includes_and_extends_to_module
* include_or_extend_cascades_to_module_prepend_includes
* include_or_extend_cascades_to_module_prepend_extends
* include_or_extend_cascades_to_module_prepend_includes_and_extends

Module block methods:

* module_include
* module_extend
* module_include_or_extend
* prepend_module_include
* prepend_module_extend
* prepend_module_include_or_extend

Class block methods:

* class_include
* class_extend
* class_include_or_extend
* prepend_class_include
* prepend_class_extend
* prepend_class_include_or_extend

Instance block methods:

* instance_extend
* prepend_instance_extend

Class or module block methods:

* class_or_module_include
* class_or_module_extend
* class_or_module_include_or_extend
* prepend_class_or_module_include
* prepend_class_or_module_extend
* prepend_class_or_module_include_or_extend

Module or instance block methods:

* module_or_instance_extend
* module_include_or_instance_extend
* module_include_or_extend_or_instance_extend
* prepend_module_or_instance_extend
* prepend_module_include_or_instance_extend
* prepend_module_include_or_extend_or_instance_extend

Class or instance block methods:

* class_or_instance_extend
* class_include_or_instance_extend
* class_include_or_extend_or_instance_extend
* prepend_class_or_instance_extend
* prepend_class_include_or_instance_extend
* prepend_class_include_or_extend_or_instance_extend

Class or module or instance block methods:

* class_or_module_or_instance_extend
* class_or_module_include_or_instance_extend
* class_or_module_include_or_extend_or_instance_extend
* prepend_class_or_module_or_instance_extend
* prepend_class_or_module_include_or_instance_extend
* prepend_class_or_module_include_or_extend_or_instance_extend

Suspend methods:

*  suspend_any_hooks
*  suspend_any_include_hooks
*  suspend_any_extend_hooks
*  suspend_include_hooks
*  suspend_extend_hooks
*  suspend_prepend_include_hooks
*  suspend_prepend_extend_hooks

*  hooks_suspended?
*  all_hooks_suspended?
*  all_include_hooks_suspended?
*  all_extend_hooks_suspended?
*  include_hooks_suspended?
*  extend_hooks_suspended?
*  prepend_include_hooks_suspended?
*  prepend_extend_hooks_suspended?

*  resume_any_hooks
*  resume_any_include_hooks
*  resume_any_extend_hooks
*  resume_include_hooks
*  resume_extend_hooks
*  resume_prepend_include_hooks
*  resume_prepend_extend_hooks

Suspend for block methods:

*  without_any_hooks
*  without_any_include_hooks
*  without_any_extend_hooks
*  without_include_hooks
*  without_extend_hooks
*  without_prepend_include_hooks
*  without_prepend_extend_hooks

# License #

  (The MIT License)

  Copyright (c) 2011 Asher

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.