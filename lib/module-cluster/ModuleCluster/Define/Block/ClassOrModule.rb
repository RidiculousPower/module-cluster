
module ModuleCluster::Define::Block::ClassOrModule
  
  include ModuleCluster::Define::Block::Class
  include ModuleCluster::Define::Block::Module
  
  extend ModuleCluster::ExtendForCascade
  
  #############################
  #  class_or_module_include  #
  #############################

  def class_or_module_include( & runtime_block )
    class_include( & runtime_block )
    module_include( & runtime_block )
  end

  ############################
  #  class_or_module_extend  #
  ############################

  def class_or_module_extend( & runtime_block )
    class_extend( & runtime_block )
    module_extend( & runtime_block )
  end

  #######################################
  #  class_or_module_include_or_extend  #
  #######################################

  def class_or_module_include_or_extend( & runtime_block )
    class_or_module_include( & runtime_block )
    class_or_module_extend( & runtime_block )
  end

  #####################################
  #  prepend_class_or_module_include  #
  #####################################

  def prepend_class_or_module_include( & runtime_block )
    prepend_class_include( & runtime_block )
    prepend_module_include( & runtime_block )
  end

  ####################################
  #  prepend_class_or_module_extend  #
  ####################################

  def prepend_class_or_module_extend( & runtime_block )
    prepend_class_extend( & runtime_block )
    prepend_module_extend( & runtime_block )
  end

  ###############################################
  #  prepend_class_or_module_include_or_extend  #
  ###############################################

  def prepend_class_or_module_include_or_extend( & runtime_block )
    prepend_class_or_module_include( & runtime_block )
    prepend_class_or_module_extend( & runtime_block )
  end
  
end
