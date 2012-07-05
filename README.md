# Module Cluster #

http://rubygems.org/gems/module-cluster

# Summary #

Provides an interface for event hooks at any point during module include/extend or class subclassing.

# Description #

Provides hooks via :included, :extended, :append_features, :extend_object, :inherited. Define behavior at hooks via simple interface.

# Install #

* sudo gem install module-cluster

# Usage #

Extend the module that you want to enable:

```ruby
module SomeModule
  extend Module::Cluster
end
```

## Basic Hooks ##

Hooks are defined on named clusters, that way they can be enabled/disabled later on.

There are four type of module hooks:

* before_include
* after_include
* before_extend
* after_extend

There are also subclass hooks:

* subclass

Any of these hooks can be defined on a cluster:

```ruby
module SomeModule
  # Create a hook to be activated before this module is included
  cluster( :some_cluster_name ).before_include
end
```

Then declarations can be made by chaining calls.

### Block Hooks ###

```ruby
module SomeModule  
  cluster( :some_cluster_name ).before_include do |hooked_instance|
    # some stuff
  end
end
```

The block passed to :before_include will be run when SomeModule is included in another module.

### Include/Extend Hooks ###

```ruby
# Some other module we want to extend at include time
module AnotherModule
end

module SomeModule  
  cluster( :some_cluster_name ).before_include.extend( AnotherModule )
end
```

Now if SomeModule is included, the module in which it is included will also be extended by AnotherModule.

What if we only want to extend classes but not modules?

```ruby
# Some other module we want to extend at include time
module AnotherModule
end

module SomeModule  
  cluster( :some_cluster_name ).before_include( :class ).extend( AnotherModule )
end
```

The same works for :any, :class, :module, :instance.

## Cascading Hooks ##

Sometimes we want to be able to declare that actions should happen well down the line. For instance, ModuleA should take action on the first class but might be included in any number of intermediate modules first. We can easily handle this case by declaring cascading behavior.

```ruby
# Some other module we want to extend at include time
module AnotherModule
end

module SomeModule
  cluster( :some_cluster_name ).before_include.cascade.extend( AnotherModule )
end
```

Now any module or class that includes SomeModule or any module or class that includes that module (and so on) will be extended by AnotherModule.

If we only want certain contexts to receive the cascading functionality we can limit it the same way we limited include/extend contexts:

```ruby
# Some other module we want to extend at include time
module AnotherModule
end

module SomeModule
  cluster( :some_cluster_name ).before_include.cascade_to( :class ).extend( AnotherModule )
end
```

:cascade_to is simply an alias to :cascade that is more readable when specifying contexts.

Now any module that includes SomeModule will cause the first class that includes it to be extended by AnotherModule.

# Interface Rundown #

Create a cluster to group together hooks. From the cluster declarations specify what context will cause event hooks to occur:

## Hook Contexts ##

* :before\_include
* :after\_include
* :before\_extend
* :after\_extend
* :subclass
* :before\_include\_or\_extend
* :after\_include\_or\_extend
* :before\_include\_or\_subclass
* :after\_include\_or\_subclass
* :before\_extend\_or\_subclass
* :after\_extend\_or\_subclass
* :before\_include\_or\_extend\_or\_subclass
* :after\_include\_or\_extend\_or\_subclass

Any of these declarations will return a reference to a {::Module::Cluster::InstanceController::HookController::ChainProxy Module::Cluster::InstanceController::HookController::ChainProxy} or a {::Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy Module::Cluster::InstanceController::MultipleHookControllerProxy::ChainProxy}. Both have the same interface, so you don't need to worry about the difference.

## Hook Actions ##

From the reference returned by a hook context the following declarations can be made:

* include
* extend
* include\_and\_extend
* extend\_and\_include
* action

## Hook Action Contexts ##

As we have shown, declarations to cause cascading behavior can also be made here:

* cascade

Also, contexts can be set so that hook order can be easily manipulated. This will cause hook events to be inserted in the stack other than at the end:

* before\_include
* after\_include
* before\_extend
* after\_extend

All of these possibilities returns a reference where hook actions can be defined, exactly the same as above. The only difference is that they will occur in the chained context, which is the context described by the chained declarations. Any time that declarations begin again from the cluster, chained declarations will reset.

# License #

  (The MIT License)

  Copyright (c) 2012 Ridiculous Power, Asher

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