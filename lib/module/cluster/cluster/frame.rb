
###
# Struct used to store event frames for processing at time of event (include/extend/subclass).
#
# @member cluster_owner [Module,Class]
#
#         Instance to which frame's cluster belongs.
#
# @member cluster_name [Symbol]
#
#         Name of cluster to which frame belongs.
#
# @member cascade_context [Array<:any,:module,:class,:subclass>]
#
#         Context for which action should be inherited.
#
# @member instance_contexts [Array<:any,:module,:class,:subclass,:instance>]
#
#         Context for which action should occur.
#
# @member modules [Array<Module>]
#
#         Modules to include/extend.
#
# @member include_or_extend [:include,:extend,:include_and_extend,:extend_and_include]
#
#         Action to perform for modules (include and/or extend).
#
# @member block_action [Proc]
#
#         Block action to run.
#
::Module::Cluster::Cluster::Frame = ::Struct.new( :cluster_owner,
                                                  :cluster_name, 
                                                  :cascade_contexts,
                                                  :instance_contexts, 
                                                  :modules, 
                                                  :include_or_extend,
                                                  :block_action )
