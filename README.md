# Module Cluster #

http://rubygems.org/gems/module-cluster

# Description #

Adds methods for defining module clusters using #included and #extended.

# Summary #

Provides :define_module_inclusion, :define_module_extension, and :define_module_cluster.

# Install #

* sudo gem install module-cluster

# Usage #

Simply:

```ruby
module SomeModule
  include ModuleCluster
end
```

To cause modules to be included when this module is included:

```ruby
module SomeModule
  define_module_inclusion do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or extended when this module is included:

```ruby
module SomeModule
  define_module_inclusion do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

or when this module is extended

```ruby
module SomeModule
  define_module_extension do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or

```ruby
module SomeModule
  define_module_extension do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

or when this module is either included or extended:

```ruby
module SomeModule
  define_module_cluster do |includes, extends|
    includes.concat [ SomeOtherModule ]
  end
end
```

or

```ruby
module SomeModule
  define_module_cluster do |includes, extends|
    extends.concat [ SomeOtherModule ]
  end
end
```

If the block returns [ includes, extends ] as arrays, those values will be used; otherwise, the contents of the includes and extends parameters passed to the block will be used.

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