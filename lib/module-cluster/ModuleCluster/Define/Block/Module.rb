
module ModuleCluster::Define::Block::Module
  
  ####################
  #  module_include  #
  ####################

  def module_include( & runtime_block )
    cluster_stack.module_include( runtime_block )
  end

  ###################
  #  module_extend  #
  ###################

  def module_extend( & runtime_block )
    cluster_stack.module_extend( runtime_block )
  end

  ##############################
  #  module_include_or_extend  #
  ##############################

  def module_include_or_extend( & runtime_block )
    module_include( & runtime_block )
    module_extend( & runtime_block )
  end

  ############################
  #  prepend_module_include  #
  ############################

  def prepend_module_include( & runtime_block )
    cluster_stack.prepend_module_include( runtime_block )
  end

  ###########################
  #  prepend_module_extend  #
  ###########################

  def prepend_module_extend( & runtime_block )
    cluster_stack.prepend_module_extend( runtime_block )
  end

  ######################################
  #  prepend_module_include_or_extend  #
  ######################################

  def prepend_module_include_or_extend( & runtime_block )
    prepend_module_include( & runtime_block )
    prepend_module_extend( & runtime_block )
  end
  
end
