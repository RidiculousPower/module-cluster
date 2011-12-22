
module ModuleCluster::Define::Block::ClassOrInstance
  
  include ModuleCluster::Define::Block::Class
  include ModuleCluster::Define::Block::Instance
  
  extend ModuleCluster::ExtendForCascade
  
  ##############################
  #  class_or_instance_extend  #
  ##############################

  def class_or_instance_extend( & runtime_block )
    class_extend( & runtime_block )
    instance_extend( & runtime_block )
  end

  ######################################
  #  class_include_or_instance_extend  #
  ######################################

  def class_include_or_instance_extend( & runtime_block )
    class_include( & runtime_block )
    instance_extend( & runtime_block )
  end

  ################################################
  #  class_include_or_extend_or_instance_extend  #
  ################################################

  def class_include_or_extend_or_instance_extend( & runtime_block )
    class_include_or_extend( & runtime_block )
    instance_extend( & runtime_block )
  end

  ######################################
  #  prepend_class_or_instance_extend  #
  ######################################

  def prepend_class_or_instance_extend( & runtime_block )
    prepend_class_extend( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

  ##############################################
  #  prepend_class_include_or_instance_extend  #
  ##############################################

  def prepend_class_include_or_instance_extend( & runtime_block )
    prepend_class_include( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

  ########################################################
  #  prepend_class_include_or_extend_or_instance_extend  #
  ########################################################

  def prepend_class_include_or_extend_or_instance_extend( & runtime_block )
    prepend_class_include_or_extend( & runtime_block )
    prepend_instance_extend( & runtime_block )
  end

end
