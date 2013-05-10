# -*- encoding : utf-8 -*-

############################
#  enable_cluster_context  #
############################

def enable_cluster_context( cluster_context, include_modules, extend_modules, block_action )
  cluster_context.include( *include_modules )
  cluster_context.extend( *extend_modules )
  cluster_context.action( & block_action )
end

##########################
#  enable_for_execution  #
##########################

def enable_for_execution( instance, 
                          cluster_name, 
                          event_context, 
                          include_modules, 
                          extend_modules, 
                          block_action, 
                          execution_contexts )
  cluster_context = cluster_context( instance, cluster_name, event_context, execution_contexts )
  enable_cluster_context( cluster_context, include_modules, extend_modules, block_action )
  instance
end

########################
#  enable_for_cascade  #
########################

def enable_for_cascade( instance, 
                        cluster_name, 
                        event_context, 
                        include_modules, 
                        extend_modules, 
                        block_action, 
                        execution_contexts, 
                        cascade_contexts )
  cluster_context = cluster_context( instance, cluster_name, event_context, execution_contexts )
  cluster_context.cascade_to( *cascade_contexts )
  enable_cluster_context( cluster_context, include_modules, extend_modules, block_action )
  instance
end

#####################
#  cluster_context  #
#####################

def cluster_context( instance, cluster_name, event_context, execution_contexts )
  instance.cluster( cluster_name ).__send__( event_context, *execution_contexts )
end

##################
#  execute_hook  #
##################

def execute_hook( include_or_extend, clustered_instance, inheriting_instance, block_state )
  block_state.clear
  case include_or_extend
    when :include
      inheriting_instance.module_eval do
        include clustered_instance
      end
    when :extend
      inheriting_instance.extend( clustered_instance )
  end
  inheriting_instance
end

