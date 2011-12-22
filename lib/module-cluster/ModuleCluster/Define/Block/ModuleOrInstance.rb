
module ModuleCluster::Define::Block::ModuleOrInstance
  
  include ModuleCluster::Define::Block::Module
  include ModuleCluster::Define::Block::Instance
  
  extend ModuleCluster::ExtendForCascade
  
  ###############################
  #  module_or_instance_extend  #
  ###############################

  def module_or_instance_extend( & runtime_block )
    module_extend( & runtime_block )
    instance_extend( & runtime_block )
  end

  #######################################
  #  module_include_or_instance_extend  #
  #######################################

  def module_include_or_instance_extend( & runtime_block )
    module_include( & runtime_block )
    instance_extend( & runtime_block )
  end

  #################################################
  #  module_include_or_extend_or_instance_extend  #
  #################################################

  def module_include_or_extend_or_instance_extend( & runtime_block )
    module_include_or_extend( & runtime_block )
    instance_extend( & runtime_block )
  end

  #######################################
  #  prepend_module_or_instance_extend  #
  #######################################

  def prepend_module_or_instance_extend( & runtime_block )
    prepend_module_extend( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

  ###############################################
  #  prepend_module_include_or_instance_extend  #
  ###############################################

  def prepend_module_include_or_instance_extend( & runtime_block )
    prepend_module_include( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

  #########################################################
  #  prepend_module_include_or_extend_or_instance_extend  #
  #########################################################

  def prepend_module_include_or_extend_or_instance_extend( & runtime_block )
    prepend_module_include_or_extend( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

end
