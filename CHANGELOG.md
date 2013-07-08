## 7/21/2011 ##

Initial release.

## 7/23/2011 ##

Addition of cascading module functions.

## 7/31/2011 ##

Total overhaul of internals.
Major interface changes.
Addition of prepend functions.
Added deprecated method exceptions for interface changes.

## 8/1/2011 ##

Added cascades_to_module methods.

## 8/3/2011 ##

2700% speed-up by preventing cascading duplicate includes/extends.

## 8/6/2011 ##

Actually fixed speed problems rather than just improving them.
Add block support for declarations.
Added block methods for nested declarations.

## 8/25/2011 ##

Updates to :perform_cascades to support cascading to extended instances.

## 10/18/2011 ##

Changes from :module_eval to :instance_eval for instance extend support.

## 12/22/2011 ##

Full internals update/rewrite/restructure for instance support and more complete 
hooks.

Separated out public interface modules from internal implementation modules. 

## 12/27/2011 ##

Added ::ModuleCluster::Define::Status to interrogate currently defined hooks.

Added ::ModuleCluster::Suspend, which includes various methods to temporarily or 
permanently modify hooks that have been created.

Changed return values on interface methods from self to the set created by the method.
This permits chaining of settings, such as appending .name( :set_name ).

Added set names, which permit the later suspension of sets by name rather than having to
describe which set(s) should be suspended (although this can also be done).

## 1/11/2012 ##

Added support for Class#subclass block hook.

## 3/10/2012 ##

Added support for declaring subclass blocks in a module. 
Added support for declaring class_or_module_include_or_subclass hooks, class_include_or_subclass,
  and module_include_or_subclass.

## 3/11/2012 ##

Added support for cascading block methods.

## 7/03/2012 ##

Total interface rewrite.
Renamed From ModuleCluster to Module::Cluster.

## 7/04/2012 ##

Oops! Reversed the order for before* methods. Fixed.

## 7/06/2012 ##

Fixed top-level block-only hooks.

## 7/10/2012 ##

Fixes for which instances blocks are eval'd on

## 12/22/2012 ##

Rewrite of internals, massively simplified.
Module include/extend order is no longer reversed from Ruby's include and extend methods. This change
may be quite annoying, but the inconsistency was more annoying.

## 5/22/2013 ##

Add :module_class execution and cascade hooks.
Fixed subclass handling so that it will work on Class (in addition to instances of Class).

## 7/08/2013 ##

Changed Stack from < Array to < Array::Compositing and from using #concat to using #register_parent.
This means that frames will now automatically cascade when created in a super instance after its hook,
which means that frames can be created on Object to cascade to Module, Class, and other instances.
This might be confusing and possibly not what we want; if so, we can cause Array::Compositing not to
inherit elements created after registration. Worst case it is likely that we want Object => Module,
Class, but not to new subclass.
