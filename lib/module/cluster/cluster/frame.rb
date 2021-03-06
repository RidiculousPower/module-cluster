# -*- encoding : utf-8 -*-

###
# @private
#
# Struct used to store event frames for processing at time of event (include/extend/subclass).
#
# @!attribute [rw] [Module,Class] cluster_owner
#
#         Instance to which frame's cluster belongs.
#
# @!attribute [rw] [Symbol] cluster_name
#
#         Name of cluster to which frame belongs.
#
# @!attribute [rw] [Array<:any,:module,:class,:instance>] execution_contexts
#
#         Context for which action should occur.
#
# @!attribute [rw] [Array<:any,:module,:class,:subclass>] cascade_contexts
#
#         Context for which action should be inherited.
#
# @!attribute [rw] [Array<Module>] modules
#
#         Modules to include/extend.
#
# @!attribute [rw] [:include,:extend,:include_and_extend,:extend_and_include] include_or_extend
#
#         Action to perform for modules (include and/or extend).
#
# @!attribute [rw] [Proc] block_action
#
#         Block action to run.
#
class ::Module::Cluster::Cluster::Frame < ::Struct.new( :cluster_owner,
                                                        :cluster_name, 
                                                        :execution_contexts, 
                                                        :cascade_contexts,
                                                        :modules, 
                                                        :include_or_extend,
                                                        :block_action )
  
  #####################
  #  initialize_copy  #
  #####################
  
  ###
  # Create a copy, duplicating context.
  #
  # @param [Module::Cluster::Cluster::Frame] copy
  #
  #        Copy of frame to initialize.
  #
  def initialize_copy( copy )
    
    super
    
    copy.execution_contexts = execution_contexts.dup if execution_contexts
    copy.cascade_contexts = cascade_contexts.dup if cascade_contexts
    copy.modules = modules.dup if modules

    return copy
    
  end
  
end
