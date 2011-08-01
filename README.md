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
  include ModuleCluster
end
```

Definition methods accept modules as arguments. 

For example:

```ruby
module SomeModule
  include ModuleCluster
  include_also_includes( SomeOtherModule )
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

Cascade methods (cascades to modules and classes):

* include_cascades_includes
* include_cascades_extends
* include_cascades_includes_and_extends
* extend_cascades_includes
* extend_cascades_extends
* extend_cascades_includes_and_extends
* include_cascades_prepending_includes
* include_cascades_prepending_extends
* include_cascades_prepending_includes_and_extends
* extend_cascades_prepending_includes
* extend_cascades_prepending_extends
* extend_cascades_prepending_includes_and_extends

Cascade to class methods (does not cascade to modules):

* include_cascades_includes_to_class
* include_cascades_extends_to_class
* include_cascades_includes_and_extends_to_class
* extend_cascades_includes_to_class
* extend_cascades_extends_to_class
* extend_cascades_includes_and_extends_to_class
* include_cascades_to_class_prepending_includes
* include_cascades_to_class_prepending_extends
* include_cascades_to_class_prepending_includes_and_extends
* extend_cascades_to_class_prepending_includes
* extend_cascades_to_class_prepending_extends
* extend_cascades_to_class_prepending_includes_and_extends

Cascade to module methods (does not cascade to classes):

* include_cascades_includes_to_module
* include_cascades_extends_to_module
* include_cascades_includes_and_extends_to_module
* extend_cascades_includes_to_module
* extend_cascades_extends_to_module
* extend_cascades_includes_and_extends_to_module
* include_cascades_to_module_prepending_includes
* include_cascades_to_module_prepending_extends
* include_cascades_to_module_prepending_includes_and_extends
* extend_cascades_to_module_prepending_includes
* extend_cascades_to_module_prepending_extends
* extend_cascades_to_module_prepending_includes_and_extends

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