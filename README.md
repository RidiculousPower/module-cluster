# Module Cluster #

http://rubygems.org/gems/module-cluster

# Description #

Adds methods for defining module clusters using #included and #extended.

# Summary #

Provides:
* :define_module_included
* :define_module_extended
* :define_module_cluster
* :define_module_included_cascades
* :define_module_extended_cascades
* :define_module_cluster_cascades
* :define_module_included_cascades_to_class
* :define_module_extended_cascades_to_class
* :define_module_cluster_cascades_to_class

# Install #

* sudo gem install module-cluster

# Usage #

Simply:

```ruby
module SomeModule
  include ModuleCluster
end
```

## The Basic Idea ##

We use blocks to define cascading module includes/extends. This automates calls to super (so we don't forget) and puts self.included/self.extended support into a module so that local overriding is still possible.

The block provides arrays to hold includes/extends. If two arrays [ includes, extends ] are returned by the block, they will be used. Otherwise the arrays passed in by parameters will be used. This means, due to how Ruby handles references, that *if you set one of the parameter arrays to a new array you have to return both arrays* or your changes won't be added.

Calls to define_module_... functions are cumulative, permitting multiple calls (whether subsequently or otherwise). This is particularly useful for configuring including/extending modules from the included/extended module (and so on - nested blocks permit this sort of determination indefinitely).

## define_module_included ##

To cause modules to be included when this module is included:

```ruby
module SomeModule
  define_module_included do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or extended when this module is included:

```ruby
module SomeModule
  define_module_included do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_extended ##

To cause modules to be included when this module is extended:

```ruby
module SomeModule
  define_module_extended do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or extended when this module is extended:

```ruby
module SomeModule
  define_module_extended do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_cluster ##

To cause modules to be included when this module is included or extended:

```ruby
module SomeModule
  define_module_cluster do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or extended when this module is included or extended:

```ruby
module SomeModule
  define_module_cluster do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_included_cascades ##

To cause modules to be included or extended when this module is used to include in a class or module.

```ruby
module SomeModule
  define_module_included_cascades do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_extended_cascades ##

To cause modules to be included or extended when this module is used to extend in a class or module:

```ruby
module SomeModule
  define_module_extended_cascades do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_cluster_cascades ##

To cause modules to be included or extended when this module is used to include or extend in a class or module:

```ruby
module SomeModule
  define_module_cluster_cascades do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_included_cascades_to_class ##

To cause modules to be included or extended when this module is used to include in a class (and not a module):

```ruby
module SomeModule
  define_module_included_cascades_to_class do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_extended_cascades_to_class ##

To cause modules to be included or extended when this module is used to extend in a class (and not a module):

```ruby
module SomeModule
  define_module_extended_cascades_to_class do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

## define_module_cluster_cascades_to_class ##

To cause modules to be included or extended when this module is used to include or extend in a class (and not a module):

```ruby
module SomeModule
  define_module_cluster_cascades_to_class do |includes, extends|
    includes.concat [ SomeOtherModule ]
    extends.concat [ SomeOtherModule ]
  end
end
```

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